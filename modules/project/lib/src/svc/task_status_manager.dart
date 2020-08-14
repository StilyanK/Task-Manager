part of project.svc;

class TaskStatusManager {
  Manager<mapper.App> manager;
  Task task;

  TaskStatusManager(this.manager, this.task);

  Future<void> setStatus() async {
    final childTasks = await manager.app.task.findAllChildTasks(task.task_id);

    if (childTasks.isNotEmpty) {
      final check =
          childTasks.every((element) => element.status == TaskStatus.Done);
      if (check) {
        task
          ..status = TaskStatus.Done
          ..progress = 100;
      } else {
        task.status = TaskStatus.InProgress;
      }
    }
  }
}
