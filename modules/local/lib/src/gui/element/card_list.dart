part of local.gui;

abstract class Card<T> extends cl.CLElement {
  cl_app.Application ap;
  Object id;
  T rCard;

  Card(this.ap, this.id, this.rCard) : super(new DivElement());

  void createDom();
}

abstract class CardListGadget<T, C extends Card>
    extends cl_app.GadgetBase<List<T>> {
  String title;
  String archive;
  String icon;
  cl.CLElement titleDom, contentDom;
  cl_form.InputDate date;

  cl_app.Application<auth.Client> ap;
  num delayms = 100;
  cl.Container innerContainer;
  List<C> cards = [];

  CardListGadget(this.ap, this.title, this.archive, this.icon) : super() {
    setController(getController());
  }

  void createDom() {
    addClass('ui-requests');
    if (title != null) {
      titleDom = new cl.CLElement(new HeadingElement.h2())
        ..append(new cl.Icon(icon).dom)
        ..appendTo(this)
        ..append(new SpanElement()
          ..classes.add('title')
          ..text = title)
        ..append(date = new cl_form.InputDate())
        ..append(cl_action.Button()
          ..setIcon(cl.Icon.chevron_left)
          ..addClass('light')
          ..addAction((e) => date
              .setValue(date.getValue_().subtract(const Duration(days: 1)))))
        ..append(cl_action.Button()
          ..setIcon(cl.Icon.chevron_right)
          ..addClass('light')
          ..addAction((e) =>
              date.setValue(date.getValue_().add(const Duration(days: 1)))))
        ..append(cl_action.Button()
          ..setIcon(cl.Icon.search)
          ..setTip(intl.See_all())
          ..addClass('light')
          ..addAction((e) => ap.run(archive)));
    }
    contentDom = new cl.CLElement(new DivElement())..appendTo(this);
    innerContainer = new cl.Container()..addClass('ui-row');
    contentDom.append(innerContainer);
    new cl_util.CLscroll(contentDom.dom);
    init();
  }

  cl_app.GadgetController<List<T>> getController();

  C getCard(T r);

  void init() {
    date
      ..setValue(new DateTime.now())
      ..onValueChanged.listen((_) {
        if (date.getValue() != null)
          load();
        else
          date.setValue(new DateTime.now());
      });
  }

  void updateCard(T c) {
    final card = getCard(c)..createDom();
    removeCard(card.id);
    cards.add(card);
    innerContainer.prepend(card);
    new Timer(
        new Duration(milliseconds: delayms * 1), () => card.addClass('show'));
  }

  void removeCard(Object id) {
    final found = cards.firstWhere((c) => c.id == id, orElse: () => null);
    if (found != null) {
      cards.remove(found);
      found.remove();
    }
  }

  void update() {
    innerContainer.removeChilds();
    cards = [];
    int k = 0;
    for (int i = contr.result.length; i > 0; i--) {
      final card = getCard(contr.result[i - 1])..createDom();
      cards.add(card);
      innerContainer.append(card);
      new Timer(new Duration(milliseconds: delayms * k++),
          () => card.addClass('show'));
    }
  }
}
