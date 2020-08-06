// GENERATED CODE - DO NOT MODIFY BY HAND

part of project.entity;

// **************************************************************************
// EntitySerializableGenerator
// **************************************************************************

abstract class $Task {
  static const String task_id = 'task_id';
  static const String priority = 'priority';
  static const String status = 'status';
  static const String parent_task = 'parent_task';
  static const String title = 'title';
  static const String description = 'description';
  static const String date_created = 'date_created';
  static const String date_modified = 'date_modified';
  static const String created_by = 'created_by';
  static const String assigned_to = 'assigned_to';
  static const String modified_by = 'modified_by';
  static const String progress = 'progress';
  static const String deadline = 'deadline';
}

void _$TaskFromMap(Task obj, Map data) => obj
  ..task_id = data[$Task.task_id]
  ..priority = data[$Task.priority]
  ..status = data[$Task.status]
  ..parent_task = data[$Task.parent_task]
  ..title = data[$Task.title]
  ..description = data[$Task.description]
  ..date_created = data[$Task.date_created] is String
      ? DateTime.tryParse(data[$Task.date_created])
      : data[$Task.date_created]
  ..date_modified = data[$Task.date_modified] is String
      ? DateTime.tryParse(data[$Task.date_modified])
      : data[$Task.date_modified]
  ..created_by = data[$Task.created_by]
  ..assigned_to = data[$Task.assigned_to]
  ..modified_by = data[$Task.modified_by]
  ..progress = data[$Task.progress]
  ..deadline = data[$Task.deadline] is String
      ? DateTime.tryParse(data[$Task.deadline])
      : data[$Task.deadline];

Map<String, dynamic> _$TaskToMap(Task obj, [asJson = false]) =>
    <String, dynamic>{
      $Task.task_id: obj.task_id,
      $Task.priority: obj.priority,
      $Task.status: obj.status,
      $Task.parent_task: obj.parent_task,
      $Task.title: obj.title,
      $Task.description: obj.description,
      $Task.date_created:
          asJson ? obj.date_created?.toIso8601String() : obj.date_created,
      $Task.date_modified:
          asJson ? obj.date_modified?.toIso8601String() : obj.date_modified,
      $Task.created_by: obj.created_by,
      $Task.assigned_to: obj.assigned_to,
      $Task.modified_by: obj.modified_by,
      $Task.progress: obj.progress,
      $Task.deadline: asJson ? obj.deadline?.toIso8601String() : obj.deadline
    };

abstract class $TaskMedia {
  static const String task_media_id = 'task_media_id';
  static const String task_id = 'task_id';
  static const String task_comment_id = 'task_comment_id';
  static const String source = 'source';
  static const String date_created = 'date_created';
}

void _$TaskMediaFromMap(TaskMedia obj, Map data) => obj
  ..task_media_id = data[$TaskMedia.task_media_id]
  ..task_id = data[$TaskMedia.task_id]
  ..task_comment_id = data[$TaskMedia.task_comment_id]
  ..source = data[$TaskMedia.source]
  ..date_created = data[$TaskMedia.date_created] is String
      ? DateTime.tryParse(data[$TaskMedia.date_created])
      : data[$TaskMedia.date_created];

Map<String, dynamic> _$TaskMediaToMap(TaskMedia obj, [asJson = false]) =>
    <String, dynamic>{
      $TaskMedia.task_media_id: obj.task_media_id,
      $TaskMedia.task_id: obj.task_id,
      $TaskMedia.task_comment_id: obj.task_comment_id,
      $TaskMedia.source: obj.source,
      $TaskMedia.date_created:
          asJson ? obj.date_created?.toIso8601String() : obj.date_created
    };
