import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/entities/room_entity.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/usecases/create_room_usecase.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/usecases/create_task_usecase.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/usecases/get_room_usecase.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  final GetRoomUsecase _getRoomUsecase;
  final CreateRoomUsecase _createRoomUsecase;
  final CreateTaskUsecase _createTaskUsecase;

  RoomBloc(
      {required GetRoomUsecase getRoomUsecase,
      required CreateRoomUsecase createRoomUsecase,
      required CreateTaskUsecase createTaskUsecase})
      : _getRoomUsecase = getRoomUsecase,
        _createRoomUsecase = createRoomUsecase,
        _createTaskUsecase = createTaskUsecase,
        super(RoomInitial()) {
    on<GetRoomEvent>((event, emit) async {
      emit(RoomLoading());
      final result = await getRoomUsecase(GetRommParams(userId: event.userId));
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
  }
}
