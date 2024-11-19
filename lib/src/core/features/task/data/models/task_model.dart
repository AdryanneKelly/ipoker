import 'dart:convert';

import 'package:planning_poker_ifood/src/core/features/task/domain/entities/task_entity.dart';

class TaskModel extends TaskEntity {
  TaskModel({
    super.uid,
    required super.roomId,
    required super.title,
    required super.description,
    super.storyPoints,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'roomId': roomId,
      'title': title,
      'description': description,
      'storyPoints': storyPoints,
    };
  }

  factory TaskModel.fromMap(Map<String, dynamic> map) {
    try {
      return TaskModel(
        uid: map['uid'] != null ? map['uid'] as String : null,
        roomId: map['roomId'] as String,
        title: map['title'] as String,
        description: map['description'] as String,
        storyPoints: map['storyPoints'] != null ? map['storyPoints'] as int : null,
      );
    } catch (e, s) {
      throw Exception('Error parsing TaskModel: $e - $s');
    }
  }

  String toJson() => json.encode(toMap());

  factory TaskModel.fromJson(String source) => TaskModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
