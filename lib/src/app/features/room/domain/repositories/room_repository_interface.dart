import 'package:planning_poker_ifood/src/app/features/room/domain/entities/room_entity.dart';
import 'package:planning_poker_ifood/src/core/features/task/domain/entities/task_entity.dart';
import 'package:planning_poker_ifood/src/core/features/user/domain/entities/user_entity.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';

abstract interface class IRoomRepository {
  Future<Output<List<RoomEntity>>> getRooms({required String userId});
  Future<Output<RoomEntity>> createRoom({required String collection, required Map<String, dynamic> data});
  Future<Output<RoomEntity>> updateRoom(
      {required String collection, required Map<String, dynamic> data, required String documentId});
  Future<Output<List<TaskEntity>>> createTasks(
      {required String roomId, required String collection, required List<Map<String, dynamic>> tasks});
  Future<Output<RoomEntity>> joinRoom({required String collection, required String roomId, required UserEntity user});
}
