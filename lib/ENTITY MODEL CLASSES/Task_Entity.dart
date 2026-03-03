// import 'package:json_annotation/json_annotation.dart';
//
// part 'Task_Entity.g.dart';
// @JsonSerializable()
// class TaskEntity{
//   String? isPinned;
//   String? documentId;
//   String? task;
//   String? description;
//   String? date;
//   String? time;
//   bool? isComplete;
//   TaskEntity({this.task,this.description,this.date,this.time,this.isComplete,this.documentId,this.isPinned});
//   factory TaskEntity.fromJson(Map<String,dynamic> json) => _$TaskEntityFromJson(json);
//   Map<String,dynamic> toJson() => _$TaskEntityToJson(this);
//}





import 'package:json_annotation/json_annotation.dart';

part 'Task_Entity.g.dart';

@JsonSerializable()
class TaskEntity {
  final String? id;
  String? task;
  String? description;
  String? date;
  String? time;
  bool? isComplete;
  bool? isPinned;

  @JsonKey(ignore: true) // 👈 IMPORTANT FIX
  String? documentId;

  TaskEntity({
    this.id,
    this.task,
    this.description,
    this.date,
    this.time,
    this.isComplete,
    this.isPinned,
    this.documentId,
  });

  factory TaskEntity.fromJson(Map<String, dynamic> json) =>
      _$TaskEntityFromJson(json);

  Map<String, dynamic> toJson() => _$TaskEntityToJson(this);
}
