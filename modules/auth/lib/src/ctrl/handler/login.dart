part of auth.ctrl;

class CLogin extends base.Base<App> {
  CLogin(req) : super(req);

  Future<void> login() async {
    final cookie = req.cookies.firstWhere(
        (cookie) => cookie.name == AUTHCOOKIENAME,
        orElse: () => null);
    if (cookie != null) await userLogout();

    final body = await HttpBodyHandler.processRequest(req);
    if (body.body.length > 0 && body.body['user'] != null) {
      if (await userLogin(req, body.body['user'], body.body['password'],
          req.connectionInfo.remoteAddress.address)) {
        final params = req.requestedUri.queryParameters;
        final redirect = params['r'] == null
            ? '${base.baseURL}/'
            : '${base.baseURL}${params['r']}';
        return req.response.redirect(Uri(
            scheme: 'https',
            host: req.headers.host,
            port: (req.headers.port != 80 && req.headers.port != 443)
                ? req.headers.port
                : null,
            path: redirect));
      }
    }
    await _renderLogin();
  }

  Future<void> forgotten() async {
    final cookie = req.cookies.firstWhere(
            (cookie) => cookie.name == AUTHCOOKIENAME,
        orElse: () => null);
    if (cookie != null) await userLogout();

    final body = await HttpBodyHandler.processRequest(req);
    final Map state = {};

    if (body.body.length > 0 && body.body['user'] != null) {
      await base.dbWrap<void, App>(App(), (manager) async {
        final c = UserService(manager);
        await c.loadUserByUser(body.body['user']);
        if (c.user != null && c.user.mail != null) {
          final string = await c.genereatePassword();
          final m = base.Mail(SmtpServer('ns1.centryl.net',
              port: 25,
              username: 'medicframe',
              password: '!2@3#AP2JkLQ',
              ignoreBadCertificate: true,
              ssl: false))
            ..from('no-reply@medicframe.com')
            ..to(c.user.mail)
            ..setSubject('Забравена парола')
            ..setText('Новата Ви парола е: $string');
          await m.send();
          state['success'] = 'true';
        } else {
          state['error'] = 'true';
        }
      });
    } else {
      state['default'] = 'true';
    }
    await _renderForgotten(state);
  }

  Future<void> logout() async {
    await userLogout();
    req.response.redirect(Uri(
        scheme: 'https',
        host: req.headers.host,
        port: (req.headers.port != 80 && req.headers.port != 443)
            ? req.headers.port
            : null,
        path: '${base.baseURL}/'));
  }

  Future<void> _renderLogin() async {
    final f = File('${base.path}/web/login.html');
    final data = f.existsSync()
        ? await f.readAsString()
        : await loadResource('protocol_auth/templates/login.html');
    responseHtml(
        await Template(data, lenient: true, htmlEscapeValues: false)
            .renderString({}));
  }

  Future<void> _renderForgotten(Map param) async {
    final f = File('${base.path}/web/forgotten.html');
    final data = f.existsSync()
        ? await f.readAsString()
        : await loadResource('protocol_auth/templates/forgotten.html');
    responseHtml(
        await Template(data, lenient: true, htmlEscapeValues: false)
            .renderString(param));
  }

  Future<bool> isLogged() async =>
      (req is HttpRequest) ? _checkHttpRequest() : _checkWSRequest();

  Future<bool> _checkHttpRequest() async {
    final rpath = req.requestedUri.path;
    if (rpath.contains(RegExp(r'^/login(/.*)*$'))) return true;
    if (rpath.contains(RegExp(r'^/forgotten(/.*)*$'))) return true;
    if (rpath.contains(RegExp(r'^/wsio(/.*)*$'))) return true;
    if (rpath.contains(RegExp(r'^/api(/.*)*$'))) return true;
    if (rpath.contains(RegExp(r'^/noauth(/.*)*$'))) return true;

    final cookie = req.cookies.firstWhere(
        (cookie) => cookie.name == AUTHCOOKIENAME,
        orElse: () => setCookie(req));
    await base.dbWrap<void, App>(
        App(), (manager) => initSession(manager, cookie.value));
    if (req.session[SESSIONKEY] == null) {
      final r = '${base.baseURL}/login';
      final q = (rpath == '/') ? null : {'r': req.requestedUri.path};
      req.response.redirect(Uri(
          scheme: 'https',
          host: req.headers.host,
          port: (req.headers.port != 80 && req.headers.port != 443)
              ? req.headers.port
              : null,
          path: r,
          queryParameters: q));
      return false;
    } else {
      return true;
    }
  }

  Future<bool> _checkWSRequest() async {
    final cookie = req.cookies.firstWhere(
        (cookie) => cookie.name == AUTHCOOKIENAME,
        orElse: () => null);
    if (cookie == null) return false;
    if (req.session[SESSIONKEY] == null)
      await base.dbWrap<void, App>(
          App(), (manager) => initSession(manager, cookie.value));
    return req.session[SESSIONKEY] != null;
  }

  Future<void> initSession(Manager man, String sessid) async {
    final manager = man.convert(App());
    final us = UserService(manager);
    await us.loadUserBySession(sessid);
    if (us.user == null)
      req.session[SESSIONKEY] = null;
    else {
      if (us.session.date_end != null) {
        us.session.date_end = null;
        await manager.app.user_session.update(us.session);
      }
      req.session[SESSIONKEY] =
          (await us.loadUserSessionFromSession()).toJson();
      req.session.onTimeout = _checkWSRequest;
    }
  }

  Cookie setCookie(HttpRequest req) {
    final cookie = Cookie(AUTHCOOKIENAME, req.session.id);
    req.response.cookies.add(cookie);
    req.cookies.add(cookie);
    req.session[SESSIONKEY] = null;
    return cookie;
  }

  Future<bool> userLogin(HttpRequest req, String username, String password,
          String ipAddress) =>
      base.dbWrap<bool, App>(App(), (manager) async {
        final c = UserService(manager);
        if (password != null)
          await c.loadUserByUserPass(username, password);
        else
          await c.loadUserByUserIPAddress(username, ipAddress);
        if (c.user != null) {
          final cookie = req.cookies.firstWhere(
              (cookie) => cookie.name == AUTHCOOKIENAME,
              orElse: () => setCookie(req));
          final res =
              await manager.app.user_session.findBySession(cookie.value);
          final sessionData = await c.loadUserSessionFromUser();
          sessionData.settings['session'] = cookie.value;
          final sessionSettingsSerialized = sessionData.settings;
          if (res != null) {
            res
              ..date_end = null
              ..data = sessionSettingsSerialized;
            await manager.app.user_session.update(res);
          } else {
            await manager.app.user_session
                .insert(manager.app.user_session.createObject()
                  ..user_id = c.user.user_id
                  ..session = cookie.value
                  ..date_start = DateTime.now()
                  ..data = sessionSettingsSerialized);
          }
          return true;
        } else {
          return false;
        }
      });

  Future<bool> userLogout() =>
      base.dbWrap<bool, App>(App(), (manager) async {
        final cookie = req.cookies.firstWhere(
            (cookie) => cookie.name == AUTHCOOKIENAME,
            orElse: () => null);
        if (cookie != null) {
          req.session[SESSIONKEY] = null;
          req.response.cookies
              .add(Cookie('DARTSESSID', '_')..expires = DateTime.now());
          req.response.cookies.add(
              Cookie(AUTHCOOKIENAME, '_')..expires = DateTime.now());
          final us = UserService(manager);
          await us.loadUserBySession(cookie.value);
          if (us.session != null) {
            us.session.date_end = DateTime.now();
            await manager.app.user_session.update(us.session);
            return true;
          }
        }
        return false;
      });
}
