part of project.mapper;

class TaskMapper extends Mapper<Task, TaskCollection, App> {
  String table = 'task';
  dynamic pkey = 'task_id';

  TaskMapper(m) : super(m);

//  Future<RecordTimeCollection> findAllByRecord(int rec_id) =>
//      loadC(selectBuilder()
//        ..where('${entity.$RecordTime.rec_id} = @rec')
//        ..setParameter('rec', rec_id)
//        ..orderBy(entity.$RecordTime.stamp)
//        ..addOrderBy(entity.$RecordTime.user_id));
}

class Task extends entity.Task with Entity<App> {}

class TaskCollection extends entity.TaskCollection<Task> {}
