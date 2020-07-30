part of project.path;

@DTOSerializable()
class TaskDTO {
  int id;
  String title;
  String description;
  DateTime createdTime;
  int createdBy;
  int assignedTo;
  int status;
  int priority;
  int modifiedBy;

  TaskDTO();

  factory TaskDTO.fromMap(Map data) =>
      _$TaskDTOFromMap(data);

  Map toMap() => _$TaskDTOToMap(this);

  Map toJson() => toMap();
}