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
