part of project.path;

@DTOSerializable()
class TaskDTO {
  int id;
  String longTitle;
  String shortTitle;
  String shortDescription;
  String longDescription;
  DateTime createdTime;
  DateTime deadLine;
  int createdBy;
  int assignedTo;
  int status;
  int priority;
  int progress;
  int modifiedBy;

  TaskDTO();

  factory TaskDTO.fromMap(Map data) =>
      _$TaskDTOFromMap(data);

  Map toMap() => _$TaskDTOToMap(this);

  Map toJson() => toMap();
}