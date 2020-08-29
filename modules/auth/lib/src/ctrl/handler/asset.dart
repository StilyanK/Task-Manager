part of auth.ctrl;

class CAsset extends base.Base<App> {
  CAsset(req) : super(req);

  void outputImageResize() {
    final uri = Uri.decodeComponent(req.uri.path);
    final s = RoutesU.image_resize.parse(uri)[0];
    final w = RoutesU.image_resize.parse(uri)[1];
    final h = RoutesU.image_resize.parse(uri)[2];
    final p = RoutesU.image_resize.parse(uri)[3];
    req.response.headers.add('X-Accel-Redirect',
        Uri.encodeComponent('${base.baseURL}/${s}_/image${w}x$h/$p'));
    req.response.close();
  }

  void outputMedia() {
    final uri = Uri.decodeComponent(req.uri.path);
    final s = RoutesU.file.parse(uri)[0];
    final p = RoutesU.file.parse(uri)[1];
    final parts = p.split('.');
    if (parts.length > 1) {
      final ext = parts.last.toLowerCase();
      var type = '';
      if (ext == 'jpg')
        type = 'image/jpg';
      else if (ext == 'png')
        type = 'image/png';
      else if (ext == 'gif')
        type = 'image/gif';
      else if (ext == 'pdf') type = 'application/pdf';
      req.response.headers.add('content-type', type);
    }
    req.response.headers.add(
        'X-Accel-Redirect', Uri.encodeComponent('${base.baseURL}/${s}_/$p'));
    req.response.close();
  }
}
