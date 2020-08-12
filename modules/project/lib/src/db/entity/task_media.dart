part of project.entity;

@MSerializable()
class TaskMedia {
  int task_media_id;
  int task_id;
  String source;
  DateTime date_created;

  TaskMedia();

  void init(Map data) => _$TaskMediaFromMap(this, data);

  Map<String, dynamic> toJson() => _$TaskMediaToMap(this, true);

  Map<String, dynamic> toMap() => _$TaskMediaToMap(this);
}

class TaskMediaCollection<E extends TaskMedia> extends Collection<E> {}
