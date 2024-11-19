import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:fpdart/fpdart.dart';
import 'package:planning_poker_ifood/src/app/features/room/data/datasources/room_remote_datasource.dart';
import 'package:planning_poker_ifood/src/app/features/room/data/models/room_model.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/entities/room_entity.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/repositories/room_repository_interface.dart';
import 'package:planning_poker_ifood/src/core/exceptions/server_exception.dart';
import 'package:planning_poker_ifood/src/core/features/task/data/models/task_model.dart';
import 'package:planning_poker_ifood/src/core/features/task/domain/entities/task_entity.dart';
import 'package:planning_poker_ifood/src/core/features/user/data/models/user_model.dart';
import 'package:planning_poker_ifood/src/core/features/user/domain/entities/user_entity.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';

class RoomRepositoryImpl implements IRoomRepository {
  final RoomRemoteDatasource _roomDatasource;

  RoomRepositoryImpl({required RoomRemoteDatasource roomDatasource}) : _roomDatasource = roomDatasource;

  @override
  Future<Output<RoomEntity>> createRoom({required String collection, required Map<String, dynamic> data}) async {
    try {
      final response = await _roomDatasource.add(collection: collection, data: data);
      log('response CREATED: $response');
      return right(RoomModel.fromMap(response));
    } on FirebaseException catch (e, s) {
      return left(ServerException(message: 'Error creating room: $e - $s'));
    }
  }

  @override
  Future<Output<List<RoomEntity>>> getRooms({required String userId}) async {
    try {
      /// TODO - AJUSTAR COLLECTION
      final response = await _roomDatasource.getByUser(collection: "rooms", userId: userId);
      log('response: $response');

      return right(response.map((e) => RoomModel.fromMap(e)).toList());
    } on FirebaseException catch (e, s) {
      return left(ServerException(message: 'Error getting rooms: $e - $s'));
    }
  }

  @override
  Future<Output<List<TaskEntity>>> createTasks(
      {required String roomId, required String collection, required List<Map<String, dynamic>> tasks}) async {
    try {
      tasks.map((task) async {
        task['roomId'] = roomId;
        await _roomDatasource.add(collection: collection, data: task);
      });
      return right(tasks.map((e) => TaskModel.fromMap(e)).toList());
    } on FirebaseException catch (e, s) {
      return left(ServerException(message: 'Error creating tasks: $e - $s'));
    }
  }

  @override
  Future<Output<RoomEntity>> updateRoom(
      {required String collection, required Map<String, dynamic> data, required String documentId}) async {
    try {
      await _roomDatasource.update(collection: collection, document: documentId, data: data);
      data['uid'] = documentId;
      return right(RoomModel.fromMap(data));
    } on FirebaseException catch (e, s) {
      return left(ServerException(message: 'Error updating room: $e - $s'));
    }
  }

  @override
  Future<Output<RoomEntity>> joinRoom(
      {required String collection, required String roomId, required UserEntity user}) async {
    try {
      final response = await _roomDatasource.getByDocument(collection: collection, document: roomId);
      log('response JOIN ROOM: $response');

      response['participants'].add((user as UserModel).toMap());

      await _roomDatasource.update(collection: collection, document: roomId, data: response);

      final updatedRoom = await _roomDatasource.getByDocument(collection: collection, document: roomId);

      updatedRoom['uid'] = roomId;

      log('updatedRoom: $updatedRoom');

      return right(RoomModel.fromMap(updatedRoom));
    } catch (e) {
      return left(ServerException(message: 'Error joining room: $e'));
    }
  }
}
