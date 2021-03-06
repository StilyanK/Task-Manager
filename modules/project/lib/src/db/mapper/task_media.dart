part of project.mapper;

class TaskMediaMapper extends Mapper<TaskMedia, TaskMediaCollection, App> {
  String table = 'task_media';
  dynamic pkey = 'task_media_id';

  TaskMediaMapper(m) : super(m);

  Future<TaskMedia> insert(TaskMedia object) async {
    String from;
    String to;
    String source;

    from = '${base.path}/tmp';
    to = joinAll(
        ['${base.path}/media', 'task', object.task_id.toString()]);

    source = await base.moveFileCheck(from, to, object.source);

    object.source = source;

    return super.insert(object);
  }

  Future<bool> delete(TaskMedia object) async {
    final res = await super.delete(object);
    try {
      await new File(joinAll([
        '${base.path}/media',
        'task',
        object.task_id.toString(),
        object.source
      ])).delete();
    } catch (e) {}

    return res;
  }

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
