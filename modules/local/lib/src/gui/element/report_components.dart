part of local.gui;

abstract class Update {
  void refresh([DateTime d, String code]);
}

class LayoutContainer extends cl.Container {
  LayoutContainer() : super() {
    contLeft = new cl.Container()
      ..addClass('section')
      ..setStyle({'width': '350px'});
    contRight = new cl_gui.TabContainer()
      ..auto = true;

    addCol(contLeft);
    addCol(contRight);
  }

  cl.Container contLeft;
  cl_gui.TabContainer contRight;
}

abstract class ListingInner extends Listing implements Update {
  ListingInner.bound(ap, this.container, {this.warning})
      : super(ap, autoload: false);
  String mode = Listing.MODE_LIST;
  bool warning = false;
  cl.Container container;

  void setActions() {
    super.setActions();
    menu.remove('del');
  }

  void initLayout() {
    layout = new ListingContainer();
    menu = new cl_action.Menu(layout.contMenu);
    container.append(layout);
  }

  void setPaginator() {}
}