part of local.gui;

abstract class BaseReportsClass {
  final StreamController<BaseReportsClass> contr =
      new StreamController.broadcast();

  final StreamController<BaseReportsClass> contrCsv =
      new StreamController.broadcast();

  final StreamController<BaseReportsClass> contrPrint =
      new StreamController.broadcast();

  ListingInnerReports Function(cl.Container container) getGrid;

  BaseReportsClass(this.ap);

  cl_app.Application ap;
  String title;
  UrlPattern CsvPath;
  UrlPattern PrintPath;

  Stream<BaseReportsClass> get onGenerate => contr.stream;

  Stream<BaseReportsClass> get onCsv => contrCsv.stream;

  Stream<BaseReportsClass> get onPrint => contrPrint.stream;

  cl_gui.FormElement getForm();
}

class ReportMain implements cl_app.Item {
  cl_app.Application ap;
  cl_app.WinApp wapi;
  LayoutContainer layout;
  List<BaseReportsClass> reports;

  ListingInner grid;

  cl_form.InputDate date;
  cl.Container xmlCont;
  cl_gui.TabElement firstTab;
  cl_gui.Accordion accordion;

  cl_app.WinMeta meta = new cl_app.WinMeta()
    ..title = intl.Report()
    ..icon = hms_icon.Icon.chart_clipboard;

  ReportMain(this.ap, this.reports) {
    initLayout();
    setUI();
    setDefaults();
  }

  Future<void> callPrint(dynamic path, Map m) async {
    final d = base64.encode(utf8.encode(json.encode(m)));
    final url = '${ap.baseurl}${path.reverse([d])}';
    cl_util.printUrl(url);
  }

  void setDefaults() {
    layout.contRight.activeTab(firstTab);
  }

  void initLayout() {
    wapi = new cl_app.WinApp(ap)..load(meta, this);
    layout = new LayoutContainer();
    wapi.win.getContent().append(layout);
    wapi.render();
  }

  void setUI() {
    accordion = new cl_gui.Accordion();
    firstTab = layout.contRight.createTab(null);
    xmlCont = new cl.Container()..appendTo(firstTab);
    reports.forEach((report) {
      final node = accordion.createNode(report.title);
      final form = report.getForm();
      node.contentDom.append(form);
      report.onGenerate.listen((r) {
        xmlCont.removeChilds();
        r.getGrid(xmlCont).refresh(form.formInner);
      });
      report.onCsv.listen((r) {
        ap.download(r.CsvPath.reverse([]),
            {'form': form.formInner.getValue(), 'name': report.title});
      });

      report.onPrint.listen((r) async {
        await callPrint(r.PrintPath, form.formInner.getValue());
      });
    });
    layout.contLeft.append(accordion, scrollable: true);
  }
}
