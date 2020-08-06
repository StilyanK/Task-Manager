part of project.gui;

class ProgressComponent extends cl_form.DataElement<int, SpanElement> {
  cl_app.Application<auth.Client> ap;
  cl_chart.BarSmall bar;

  ProgressComponent(this.ap) : super() {
    dom = new SpanElement();
    bar = new cl_chart.BarSmall(100)..setPercents(0);

    final cl_action.ButtonOption group = new cl_action.ButtonOption()
      ..setIcon(cl.Icon.print)
      ..addAction<Event>((e) => e.stopPropagation());

    final btn1 = new cl_action.Button()
      ..setTitle('20%')
      ..addAction((e) => bar.setPercents(20));
    final btn2 = new cl_action.Button()
      ..setTitle('40%')
      ..addAction((e) => bar.setPercents(40));
    final btn3 = new cl_action.Button()
      ..setTitle('60%')
      ..addAction((e) => bar.setPercents(60));

    final btn4 = new cl_action.Button()
      ..setTitle('80%')
      ..addAction((e) => bar.setPercents(80));

    final btn5 = new cl_action.Button()
      ..setTitle('100%')
      ..addAction((e) => bar.setPercents(100));

    group..addSub(btn1)..addSub(btn2)..addSub(btn3)..addSub(btn4)..addSub(btn5);
    group.buttonOption.addClass('light');

    final actionCont = new cl.CLElement(new DivElement())
      ..addClass('progress')
      ..append(bar.dom)
      ..append(group);

    dom.append(actionCont.dom);
  }

  void setValue(int value) {
    bar.setPercents(value);
    super.setValue(value);
  }
}
