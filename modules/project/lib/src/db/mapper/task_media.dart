part of project.mapper;

class TaskMediaMapper extends Mapper<TaskMedia, TaskMediaCollection, App> {
  String table = 'task_media';
  dynamic pkey = 'task_media_id';

  TaskMediaMapper(m) : super(m);

  CollectionBuilder<TaskMedia, TaskMediaCollection, App> findAllByBuilder() {
    final cb = collectionBuilder(selectBuilder());
    return cb;
  }

  Future<TaskMediaCollection> findByAllByTaskId(int task_id) =>
      loadC(selectBuilder()
        ..where('${entity.$TaskMedia.task_id} = @p1')
        ..setParameter('p1', task_id));
}

class TaskMedia extends entity.TaskMedia with Entity<App> {}

class TaskMediaCollection extends entity.TaskMediaCollection<TaskMedia> {}
