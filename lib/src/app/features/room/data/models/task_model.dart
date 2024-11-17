import 'dart:convert';

import 'package:planning_poker_ifood/src/app/features/room/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    required super.roomId,
    required super.title,
    required super.description,
    super.storyPoints,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'roomId': roomId,
      'title': title,
      'description': description,
      'storyPoints': storyPoints,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    return TaskModel(
      roomId: map['roomId'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      storyPoints: map['storyPoints'] != null ? map['storyPoints'] as int : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
