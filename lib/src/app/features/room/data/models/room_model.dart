import 'dart:convert';

import 'package:planning_poker_ifood/src/core/features/user/data/models/user_model.dart';
import 'package:planning_poker_ifood/src/app/features/room/data/models/task_model.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/entities/room_entity.dart';

class RoomModel extends RoomEntity {
  RoomModel({
    required super.title,
    required super.moderator,
    required super.status,
    super.participants,
    super.currentTask,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'title': title,
      'moderator': (moderator as UserModel).toMap(),
      'participants': participants?.map((x) => (x as UserModel).toMap()).toList(),
      'status': status,
      'currentTask': (currentTask as TaskModel).toMap(),
    };
  }

  factory RoomModel.fromMap(Map<String, dynamic> map) {
    try {
      return RoomModel(
        title: map['title'] as String,
        moderator: UserModel.fromMap(map['moderator'] as Map<String, dynamic>),
        participants: map['participants'] != null
            ? List<UserModel>.from(
                (map['participants'] as List<int>).map<UserModel?>(
                  (x) => UserModel.fromMap(x as Map<String, dynamic>),
                ),
              )
            : null,
        status: map['status'] as String,
        currentTask: map['currentTask'] != null ? TaskModel.fromMap(map['currentTask'] as Map<String, dynamic>) : null,
      );
    } catch (e, s) {
      throw Exception('Error parsing RoomModel: $e - $s');
    }
  }

  String toJson() => json.encode(toMap());

  factory RoomModel.fromJson(String source) => RoomModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
