part of project.mapper;

class TaskMapper extends Mapper<Task, TaskCollection, App> {
  String table = 'task';
  dynamic pkey = 'task_id';

  TaskMapper(m) : super(m);

  CollectionBuilder<Task, TaskCollection, App> findAllByBuilder() {
    final cb = collectionBuilder(selectBuilder());
    return cb;
  }


  Future<TaskCollection> findByAllToDo(
     int user_id, DateTime date) =>
      loadC(selectBuilder()
        ..where('${entity.$Task.date_created} >= @p1')
        ..andWhere('${entity.$Task.date_created} < @p1')
        ..setParameter('p1', date)
        ..setParameter('p2', user_id));
}

class Task extends entity.Task with Entity<App> {}

class TaskCollection extends entity.TaskCollection<Task> {}
