// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Task_Entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TaskEntity _$TaskEntityFromJson(Map<String, dynamic> json) => TaskEntity(
  id: json['id'] as String?,
  task: json['task'] as String?,
  description: json['description'] as String?,
  date: json['date'] as String?,
  time: json['time'] as String?,
  isComplete: json['isComplete'] as bool?,
  isPinned: json['isPinned'] as bool?,
);

Map<String, dynamic> _$TaskEntityToJson(TaskEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'task': instance.task,
      'description': instance.description,
      'date': instance.date,
      'time': instance.time,
      'isComplete': instance.isComplete,
      'isPinned': instance.isPinned,
    };
