// GENERATED CODE - DO NOT MODIFY BY HAND

part of project.path;

// **************************************************************************
// DTOSerializableGenerator
// **************************************************************************

abstract class $TaskDTO {
  static const String id = 'id';
  static const String title = 'title';
  static const String description = 'description';
  static const String createdTime = 'createdTime';
  static const String deadLine = 'deadLine';
  static const String createdBy = 'createdBy';
  static const String assignedTo = 'assignedTo';
  static const String status = 'status';
  static const String priority = 'priority';
  static const String progress = 'progress';
  static const String modifiedBy = 'modifiedBy';
}

TaskDTO _$TaskDTOFromMap(Map data) => new TaskDTO()
  ..id = data[$TaskDTO.id]
  ..title = data[$TaskDTO.title]
  ..description = data[$TaskDTO.description]
  ..createdTime = data[$TaskDTO.createdTime] is String
      ? DateTime.tryParse(data[$TaskDTO.createdTime])
      : data[$TaskDTO.createdTime]
  ..deadLine = data[$TaskDTO.deadLine] is String
      ? DateTime.tryParse(data[$TaskDTO.deadLine])
      : data[$TaskDTO.deadLine]
  ..createdBy = data[$TaskDTO.createdBy]
  ..assignedTo = data[$TaskDTO.assignedTo]
  ..status = data[$TaskDTO.status]
  ..priority = data[$TaskDTO.priority]
  ..progress = data[$TaskDTO.progress]
  ..modifiedBy = data[$TaskDTO.modifiedBy];

Map<String, dynamic> _$TaskDTOToMap(TaskDTO obj) => <String, dynamic>{
      $TaskDTO.id: obj.id,
      $TaskDTO.title: obj.title,
      $TaskDTO.description: obj.description,
      $TaskDTO.createdTime: obj.createdTime?.toIso8601String(),
      $TaskDTO.deadLine: obj.deadLine?.toIso8601String(),
      $TaskDTO.createdBy: obj.createdBy,
      $TaskDTO.assignedTo: obj.assignedTo,
      $TaskDTO.status: obj.status,
      $TaskDTO.priority: obj.priority,
      $TaskDTO.progress: obj.progress,
      $TaskDTO.modifiedBy: obj.modifiedBy
    };
