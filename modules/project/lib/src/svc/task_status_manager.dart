part of project.svc;

class TaskStatusManager {
  Manager<mapper.App> manager;
  mapper.Task task;

  TaskStatusManager(this.manager, this.task);

  Future<void> setStatus() async {
    final childTasks = await manager.app.task.findAllChildTasks(task.task_id);

    if (childTasks.isNotEmpty) {
      final checkDone =
          childTasks.every((element) => element.status == TaskStatus.Done);
      final checkToDo =
          childTasks.every((element) => element.status == TaskStatus.ToDo);
      final checkTest =
          childTasks.every((element) => element.status == TaskStatus.Test);
      final checkCanceled =
          childTasks.every((element) => element.status == TaskStatus.Canceled);
      final checkForDiscussion = childTasks
          .every((element) => element.status == TaskStatus.ForDiscussion);
      final checkForPostponed =
          childTasks.every((element) => element.status == TaskStatus.Postponed);
      final containsCanceledOrDiscussion = childTasks.any((element) =>
          element.status == TaskStatus.ForDiscussion ||
          element.status == TaskStatus.Canceled ||
          element.status == TaskStatus.Postponed);

      task.date_done = null;
      if (checkDone) {
        task
          ..status = TaskStatus.Done
          ..progress = 100
          ..date_done = _findLastTaskDate(childTasks);
      } else if (checkToDo) {
        task
          ..status = TaskStatus.ToDo
          ..progress = 0;
      } else if (checkTest) {
        task
          ..progress = 100
          ..status = TaskStatus.Test
          ..date_done = _findLastTaskDate(childTasks);
      } else if (checkCanceled) {
        task.status = TaskStatus.Canceled;
      } else if (checkForDiscussion) {
        task.status = TaskStatus.ForDiscussion;
      } else if (checkForPostponed) {
        task.status = TaskStatus.Postponed;
      } else if (!containsCanceledOrDiscussion) {
        task
          ..status = TaskStatus.InProgress
          ..progress = _findProgress(childTasks);
      }
    }
  }

  DateTime _findLastTaskDate(TaskCollection col) {
    final List<DateTime> subTaskDates = [];
    for (final o in col) {
      if (o.date_done != null) subTaskDates.add(o.date_done);
    }
    if (subTaskDates.isNotEmpty) {
      DateTime lastDate = subTaskDates.first;
      for (final o in subTaskDates) {
        if (o.isAfter(lastDate)) lastDate = o;
      }
      return lastDate;
    }
  }

  int _findProgress(TaskCollection childTasks) {
    int sum = 0;
    if (childTasks.isNotEmpty) {
      childTasks.forEach((element) {
        sum += element.progress;
      });
      final progress = sum / childTasks.length;
      return progress.toInt();
    } else {
      return sum;
    }
  }
}
