part of project.gui;

class ProgressComponent extends cl_form.DataElement<int, SpanElement> {
  cl_app.Application<auth.Client> ap;
  cl_chart.BarSmall bar;
  cl_action.ButtonOption group;
  final List options = [0, 20, 40, 60, 80, 100];

  ProgressComponent(this.ap) : super() {
    dom = new SpanElement();
    addClass('ui-progress');
    bar = new cl_chart.BarSmall(100)..setPercents(0);

    group = new cl_action.ButtonOption()
      ..setIcon(cl.Icon.print)
      ..addAction<Event>((e) => e.stopPropagation());

    options.forEach((option) {
      group.addSub(new cl_action.Button()
        ..setTitle('$option%')
        ..addAction((e) => setValue(option)));
    });
    group.buttonOption.addClass('light');

    final actionCont = new cl.CLElement(new DivElement())
      ..addClass('progress')
      ..append(bar.dom)
      ..append(group);

    dom.append(actionCont.dom);
  }

  void setValue(int value) {
    value ??= 0;
    bar.setPercents(value);
    manageProgressStyle(value);
    super.setValue(value);
  }

  void disable() {
    group.disable();
  }

  void enable() {
    group.enable();
  }

  void manageProgressStyle(int percentage) {
    options.forEach((option) => bar.removeClass('progress-$option'));
    bar
      ..addClass('progress-$percentage')
      ..setPercents(percentage);
  }
}
