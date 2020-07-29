part of project.path;

@DTOSerializable()
class TaskDTO {


  TaskDTO();

  factory TaskDTO.fromMap(Map data) =>
      _$TaskDTOFromMap(data);

  Map toMap() => _$TaskDTOToMap(this);

  Map toJson() => toMap();
}