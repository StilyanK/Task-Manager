import 'package:cl_base/shared.dart' as base;
import '../../intl/server.dart' as intl;

abstract class PA extends  base.$RunRights {
  static const String read = base.$RunRights.read;
  static const String create = base.$RunRights.create;
  static const String update = base.$RunRights.update;
  static const String delete = base.$RunRights.delete;
  static const String export = base.$RunRights.export;
  static const String lock = base.$RunRights.lock;
  static const List<String> crud = const [read, create, update, delete];
}

class PermissionManager {
  final _permissions = <int, _Permission>{};

  static PermissionManager _instance;

  factory PermissionManager() => _instance ??= PermissionManager._();

  PermissionManager._();

  void registerGroup(int userGroupId) {
    if (!_permissions.containsKey(userGroupId))
      _permissions[userGroupId] = _Permission();
  }

  _Permission permission(int userGroupId) =>
      _permissions[userGroupId] ?? _Permission();

  void register(String group, String scope, List<String> access,
      [bool defaultValue = false]) {
    _permissions
        .forEach((k, v) => v.register(group, scope, access, defaultValue));
  }

  String message(String group, String scope, String access) {
    var message = '';
    switch (access) {
      case PA.read:
        message = intl.error_permission_read(group, scope);
        break;
      case PA.create:
        message = intl.error_permission_create(group, scope);
        break;
      case PA.update:
        message = intl.error_permission_update(group, scope);
        break;
      case PA.delete:
        message = intl.error_permission_delete(group, scope);
        break;
    }
    return message;
  }
}

class _Permission {
  final _data = <String, Map<String, Map<String, bool>>>{};

  void register(String group, String scope, List<String> access,
      [bool defaultValue = false]) {
    access.forEach((ac) {
      if (_data[group] == null) _data[group] = {};
      if (_data[group][scope] == null) _data[group][scope] = {};
      _data[group][scope][ac] = defaultValue;
    });
  }

  bool check(String group, String scope, String access,
      Map<String, Map<String, Map<String, bool>>> permissions) {
    if (permissions == null || permissions.isEmpty) return true;
    if (permissions[group] is Map && permissions[group][scope] is Map)
      return permissions[group][scope][access] ?? false;
    else if (_data[group] is Map && _data[group][scope] is Map)
      return _data[group][scope][access] ?? false;
    return false;
  }

  Map<String, Map<String, Map<String, bool>>> merge(Map permissions) {
    final m = <String, Map<String, Map<String, bool>>>{};

    _data.forEach((k, v) {
      if (m[k] == null) m[k] = {};
      v.forEach((k1, v1) {
        if (m[k][k1] == null) m[k][k1] = {};
        v1.forEach((k2, v2) {
          if (permissions != null &&
              permissions[k] != null &&
              permissions[k][k1] != null &&
              permissions[k][k1][k2] != null)
            m[k][k1][k2] = permissions[k][k1][k2];
          else
            m[k][k1][k2] = v2;
        });
      });
    });
    return m;
  }

  Map<String, Map<String, Map<String, bool>>> getBlank() => _data;
}
