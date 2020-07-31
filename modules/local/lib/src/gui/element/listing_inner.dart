part of local.gui;

abstract class ListingInnerReports extends Listing {
  bool fixedFooter = true;
  String mode = Listing.MODE_MONITOR;
  cl.Container container;
  UrlPattern xlsPath;
  UrlPattern printPath;
  Map data;
  bool printButton = false;
  cl_form.Form formOuter;

  ListingInnerReports.bound(ap, this.container) : super(ap, autoload: false);

  void initLayout() {
    layout = new ListingContainer();
    menu = new cl_action.Menu(layout.contMenu);
    container.append(layout, scrollable: true);
  }

  void setPaginator() {}

  void setParamsGet() {
    super.setParamsGet();
    params['filter'].addAll(formOuter.getValue());
  }

  void refresh(cl_form.Form f) {
    formOuter = f;
    getData();
  }

  void setActions() {
    final refresh = new cl_action.Button()
      ..setName('refresh')
      ..setTitle('Refresh')
      ..setIcon(cl.Icon.sync)
      ..addAction(filterGet);
    menu.add(refresh);
    if (printButton) {
      menu.add(new cl_action.Button()
        ..addClass('important')
        ..setIcon(cl.Icon.print));
    }
  }
}
