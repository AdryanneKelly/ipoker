import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/entities/room_entity.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/usecases/create_room_usecase.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/usecases/finish_room_usecase.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/usecases/get_room_usecase.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/usecases/join_room_usecase.dart';
import 'package:planning_poker_ifood/src/core/features/user/domain/entities/user_entity.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final GetRoomUsecase _getRoomUsecase;
  final CreateRoomUsecase _createRoomUsecase;
  final JoinRoomUsecase _joinRoomUsecase;
  final FinishRoomUsecase _finishRoomUsecase;

  RoomBloc(
      {required GetRoomUsecase getRoomUsecase,
      required CreateRoomUsecase createRoomUsecase,
      required JoinRoomUsecase joinRoomUsecase,
      required FinishRoomUsecase finishRoomUsecase})
      : _getRoomUsecase = getRoomUsecase,
        _createRoomUsecase = createRoomUsecase,
        _joinRoomUsecase = joinRoomUsecase,
        _finishRoomUsecase = finishRoomUsecase,
        super(RoomInitial()) {
    on<GetRoomEvent>((event, emit) async {
      emit(RoomLoading());
      final result = await _getRoomUsecase(GetRommParams(userId: event.userId));
      result.fold(
        (error) => emit(RoomError(message: error.message)),
        (rooms) => emit(GetRoomLoaded(rooms: rooms)),
      );
    });

    on<CreateRoomEvent>((event, emit) async {
      emit(RoomLoading());
      final result = await _createRoomUsecase(CreateRoomParams(collection: event.collection, data: event.data));
      result.fold(
        (error) => emit(RoomError(message: error.message)),
        (room) => emit(RoomCreated(room: room)),
      );
    });


    on<JoinRoomEvent>((event, emit) async {
      emit(RoomLoading());
      final result =
          await _joinRoomUsecase(JoinRoomParams(collection: event.collection, roomId: event.roomId, user: event.user));
      result.fold(
        (error) => emit(RoomError(message: error.message)),
        (room) => emit(RoomJoined(room: room)),
      );
    });

    on<UpdateRoomEvent>((event, emit) async {
      emit(RoomLoading());
      final result = await _finishRoomUsecase(
          FinishRoomParams(collection: event.collection, roomId: event.documentId, data: event.data));
      result.fold(
        (error) => emit(RoomError(message: error.message)),
        (room) => emit(RoomUpdated(room: room)),
      );
    });
  }
}
