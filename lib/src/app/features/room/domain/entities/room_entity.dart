// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:planning_poker_ifood/src/core/features/task/domain/entities/task_entity.dart';
import 'package:planning_poker_ifood/src/core/features/user/domain/entities/user_entity.dart';

class RoomEntity {
  final String uid;
  final String title;
  final UserEntity moderator;
  final List<UserEntity>? participants;
  final String status;
  final TaskEntity? currentTask;
  
  RoomEntity({
    required this.uid,  
    required this.title,
    required this.moderator,
    this.participants,
    required this.status,
    this.currentTask,
  });

 
}
