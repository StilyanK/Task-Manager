part of project.entity;

@MSerializable()
class Task {
  int task_id;
  int priority;
  int status;
  int parent_task;
  String title;
  String description;
  DateTime date_created;
  DateTime date_modified;
  DateTime date_done;
  int created_by;
  int assigned_to;
  int modified_by;
  int progress;
  DateTime deadline;
  int project_id;

  Task();

  void init(Map data) => _$TaskFromMap(this, data);

  Map<String, dynamic> toJson() => _$TaskToMap(this, true);

  Map<String, dynamic> toMap() => _$TaskToMap(this);
}

class TaskCollection<E extends Task> extends Collection<E> {}
