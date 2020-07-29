part of project.mapper;

class TaskMapper extends Mapper<Task, TaskCollection, App> {
  String table = 'task';
  dynamic pkey = 'task_id';

  TaskMapper(m) : super(m);

  CollectionBuilder<Task, TaskCollection, App> findAllByBuilder() {
    final cb = collectionBuilder(selectBuilder());
    return cb;
  }
}

class Task extends entity.Task with Entity<App> {}

class TaskCollection extends entity.TaskCollection<Task> {}
