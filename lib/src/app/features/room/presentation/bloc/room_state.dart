part of 'room_bloc.dart';

abstract class RoomState extends Equatable {
  const RoomState();

  @override
  List<Object> get props => [];
}

class RoomInitial extends RoomState {}

class RoomLoading extends RoomState {}

class GetRoomLoaded extends RoomState {
  final List<RoomEntity> rooms;

  const GetRoomLoaded({required this.rooms});

  @override
  List<Object> get props => [rooms];
}

class RoomCreated extends RoomState {
  final RoomEntity room;

  const RoomCreated({required this.room});

  @override
  List<Object> get props => [room];
}

class RoomError extends RoomState {
  final String message;

  const RoomError({required this.message});

  @override
  List<Object> get props => [message];
}
