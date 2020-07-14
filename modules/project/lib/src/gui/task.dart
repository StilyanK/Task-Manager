part of project.gui;

class PdfContainer extends cl.Container {
  cl.Container contMenu, cont, contLeft, contMiddleUp, contMiddle, contRight;

  PdfContainer() {
    addClass('document-view');
    createDom();
  }

  void createDom() {
    cont = cl.Container();
    contLeft = cl.Container();
    contRight = cl.Container();
    contMiddleUp = cl.Container();
    contMiddle = cl.Container()..addClass('middle');
    contMenu = cl.Container();

    cont
      ..addCol(contLeft = cl.Container()..addClass('left'))
      ..addCol(contMiddleUp = cl.Container()..auto = true)
      ..addCol(contRight = cl.Container()..addClass('right'));

    addRow(cont..auto = true);
    addRow(contMenu);

    contMiddleUp.append(contMiddle, scrollable: true);
  }
}

class RecordView extends cl_app.Item {
  //cl_app.WinApp wapi;
  PdfContainer layout;
  CanvasElement _canvas;

  String get prefix => '/media/${e.PatientRecord.$table}/$rec_id';

  cl_app.WinMeta meta = cl_app.WinMeta()
    ..title = intl.Document()
    ..icon = Icon.Calendar;
  cl_app.Application ap;

  int rec_id;
  e.PatientRecord _record;
  List<e.PatientDocument> _docs;

  final List<cl.Container> _prevCont = [];
  final List<CanvasElement> _prevCanv = [];

  RecordView(this.ap, this.rec_id) : super() {
    wapi = cl_app.WinApp(ap)..load(meta, this);

    wapi.win.getContent().append(layout = PdfContainer());
    wapi.render();
    wapi.win.observer.addHook('close', (_) {
      _removeCanvas();
      return true;
    });

    ap.serverCall(RoutesPatientRecord.itemGet.reverse([]),
        {$BaseConsts.id: rec_id}).then((m) async {
      final aml = (m.remove(e.PatientRecord.$apps) as List).cast<Map>();
      final dm = (m.remove(e.PatientRecord.$documents) as List).cast<Map>();

      final dml = <Map>[];
      for (final el in dm) {
        for (final dmc in el[e.PatientDocument.$comments]) {
          dml.add(dmc);
          dml.last[e.DocComment.$document] = el[e.$PatientDocument.comment];
        }
      }

      _record = e.PatientRecord()..init(m);
      _docs = dm.map((el) => e.PatientDocument()..init(el)).toList();

      _clearPreviews();
      _docs.forEach(_renderPreview);
      _canvas =
          await _renderPdf(layout.contMiddle, '$prefix/${_docs.first.source}');

      ///Doctor comments
      for (final app in aml) {
        final dtS = app[e.$ApprovalStatus.stamp];
        final dt = (dtS == null) ? null : DateTime.tryParse(dtS);
        final ds = e.ApprovalStatus.decodeState(app[e.$ApprovalStatus.state]);
        final el = cl.CLElement<DivElement>(DivElement())
          ..addClass('comment')
          ..setHtml('<strong>${app[e.ApprovalStatus.$user]}</strong>'
              '<br/> ${local.Date(dt).getWithTimeFull()} '
              '<br/> ${app[e.$ApprovalStatus.comment]} '
              '<br/> <strong>$ds</strong>');
        layout.contRight.append(el);
      }

      for (final dm in dml) {
        final dtS = dm[e.$DocComment.stamp];
        final dt = (dtS == null) ? null : DateTime.tryParse(dtS);
        final el = cl.CLElement<DivElement>(DivElement())
          ..addClass('comment fcomment')
          ..setHtml('<strong>${dm[e.DocComment.$user]}</strong>'
              '<br/> ${intl.For()} ${dm[e.DocComment.$document]} '
              '<br/> ${local.Date(dt).getWithTimeFull()} '
              '<br/> ${dm[e.$ApprovalStatus.comment]} ');
        layout.contRight.append(el);
      }
    });
  }

  void _clearPreviews() {
    for (int i = 0; i < _prevCont.length; i++) {
      _prevCanv[i].remove();
      _prevCont[i].remove();
    }
    layout.contLeft.setHtml('');
    _removeCanvas();
  }

  Future<void> _renderPreview(e.PatientDocument el) async {
    cl.Container tit;
    _prevCont
      ..add(tit = cl.Container()
        ..addClass('title')
        ..setHtml(el.comment))
      ..add(cl.Container()
        ..addClass('thumb')
        ..addAction((_) async {
          _removeCanvas();
          _canvas = await _renderPdf(layout.contMiddle, '$prefix/${el.source}');
        }));
    layout.contLeft..append(tit)..append(_prevCont.last);
    _prevCanv.add(await _renderPdf(_prevCont.last, '$prefix/${el.source}'));
  }

  Future<CanvasElement> _renderPdf(
      cl.CLElement container, String source) async {
    final CanvasElement canvas = document.createElement('canvas');
    container.append(canvas);
    final ctx = canvas.getContext('2d');
    canvas
      ..width = container.getWidth().toInt()
      ..height = container.getHeight().toInt();

    final doc = pdfjsLib.getDocument(source);
    final d = await FutureWrap<PDFDocument>(doc.promise);
    final p = await FutureWrap<Page>(d.getPage(1));
    final v = p.getViewport(Arguments(
        scale: canvas.width / p.getViewport(Arguments(scale: 1)).width));

    final task = p.render(RenderParameters(viewport: v, canvasContext: ctx));
    await FutureWrap(task.promise);
    return canvas;
  }

  void _removeCanvas() {
    _canvas?.remove();
    layout.contMiddle.setHtml('');
  }

  void setDefaults() {}

  void setUI() {}
}
