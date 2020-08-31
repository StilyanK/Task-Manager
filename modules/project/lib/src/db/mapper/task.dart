part of project.mapper;

class TaskMapper extends Mapper<Task, TaskCollection, App> {
  String table = 'task';
  dynamic pkey = 'task_id';

  TaskMapper(m) : super(m);

  CollectionBuilder<Task, TaskCollection, App> findAllByBuilder() {
    final cb = collectionBuilder(selectBuilder());
    return cb;
  }

  Future<TaskCollection> findByAllToDo(int user) => loadC(selectBuilder()
    ..where('${entity.$Task.status} != @p1')
    ..andWhere('${entity.$Task.status} != @p4')
    ..andWhere('${entity.$Task.assigned_to} = @p2')
    ..andWhere('${entity.$Task.is_deleted} = @p3')
    ..setParameter('p1', TaskStatus.Done)
    ..setParameter('p4', TaskStatus.Canceled)
    ..setParameter('p2', user)
    ..setParameter('p3', false));

  Future<TaskCollection> findAllChildTasks(int task_id) => loadC(selectBuilder()
    ..where('${entity.$Task.parent_task} = @p1')
    ..setParameter('p1', task_id)
    ..addOrderBy('${entity.$Task.task_id}', 'ASC'));

  Future<bool> delete(Task object) async {
    object.is_deleted = true;
    await manager.app.task.update(object);
    return true;
  }
}

class Task extends entity.Task with Entity<App> {}

class TaskCollection extends entity.TaskCollection<Task> {}
