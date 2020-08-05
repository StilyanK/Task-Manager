part of project.mapper;

class TaskMapper extends Mapper<Task, TaskCollection, App> {
  String table = 'task';
  dynamic pkey = 'task_id';

  TaskMapper(m) : super(m);

  CollectionBuilder<Task, TaskCollection, App> findAllByBuilder() {
    final cb = collectionBuilder(selectBuilder());
    return cb;
  }

  Future<TaskCollection> findByAllToDo(int user) =>
      loadC(selectBuilder()
        ..where('${entity.$Task.status} != @p1')
        ..andWhere('${entity.$Task.assigned_to} = @p2')
        ..setParameter('p1', TaskStatus.Done)
        ..setParameter('p2', user));
}

class Task extends entity.Task with Entity<App> {}

class TaskCollection extends entity.TaskCollection<Task> {}
