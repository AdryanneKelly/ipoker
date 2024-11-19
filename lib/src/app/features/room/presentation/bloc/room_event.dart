part of 'room_bloc.dart';

abstract class RoomEvent extends Equatable {
  const RoomEvent();

  @override
  List<Object> get props => [];
}

class GetRoomEvent extends RoomEvent {
  final String userId;

  const GetRoomEvent({required this.userId});

  @override
  List<Object> get props => [userId];
}

class CreateRoomEvent extends RoomEvent {
  final Map<String, dynamic> data;
  final String collection;

  const CreateRoomEvent({
    required this.data,
    required this.collection,
  });

  @override
  List<Object> get props => [data, collection];
}

class JoinRoomEvent extends RoomEvent {
  final String collection;
  final String roomId;
  final UserEntity user;

  const JoinRoomEvent({
    required this.collection,
    required this.roomId,
    required this.user,
  });

  @override
  List<Object> get props => [collection, roomId, user];
}

class UpdateRoomEvent extends RoomEvent {
  final String collection;
  final Map<String, dynamic> data;
  final String documentId;

  const UpdateRoomEvent({
    required this.collection,
    required this.data,
    required this.documentId,
  });

  @override
  List<Object> get props => [collection, data, documentId];
}
