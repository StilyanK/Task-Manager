part of project.gui;

class SelectTaskPriority extends cl_form.Select {
  static final List taskPriority = [
    {'v': 'Low', 'k': 0},
    {'v': 'Medium', 'k': 1},
    {'v': 'High', 'k': 2},
    {'v': 'Urgent', 'k': 3},
  ];

  SelectTaskPriority([first]) : super() {
    addClass('task-status');
    if (first != null) addOption(first[0], first[1]);
    taskPriority.forEach((option) => addOption(option['k'], option['v']));
  }

  cl.CLElement addOption(dynamic value, dynamic title,
      [bool initValue = true]) {
    final li = super.addOption(value, title, initValue);
    _setClass(li, value);
    return li;
  }

  void setShadowValue() {
    super.setShadowValue();
    _setClass(domValue, getValue());
  }

  void _setClass(cl.CLElement el, key) {
    el
      ..removeClass('low')
      ..removeClass('medium')
      ..removeClass('high')
      ..removeClass('urgent');
    if (key == TaskPriority.Low)
      el.addClass('low');
    else if (key == TaskPriority.Medium)
      el.addClass('medium');
    else if (key == TaskPriority.High)
      el.addClass('high');
    else if (key == TaskPriority.Urgent) el.addClass('urgent');
  }
}
