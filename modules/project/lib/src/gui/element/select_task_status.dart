part of project.gui;

class SelectTaskStatus extends cl_form.Select {
  SelectTaskStatus([first]) : super() {
    addClass('task-status');
    if (first != null) addOption(first[0], first[1]);
    TaskStatus.taskStatus
        .forEach((option) => addOption(option['k'], option['v']));
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
      ..removeClass('to-do')
      ..removeClass('done')
      ..removeClass('test')
      ..removeClass('in-progress')
      ..removeClass('for-discussion')
      ..removeClass('postponed')
      ..removeClass('canceled');
    if (key == TaskStatus.ToDo)
      el.addClass('to-do');
    else if (key == TaskStatus.Done)
      el.addClass('done');
    else if (key == TaskStatus.Test)
      el.addClass('test');
    else if (key == TaskStatus.InProgress)
      el.addClass('in-progress');
    else if (key == TaskStatus.ForDiscussion)
      el.addClass('for-discussion');
    else if (key == TaskStatus.Canceled)
      el.addClass('postponed');
    else if (key == TaskStatus.Postponed) el.addClass('canceled');
  }
}
