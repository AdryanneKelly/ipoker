import 'package:planning_poker_ifood/src/app/features/room/domain/entities/room_entity.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/repositories/room_repository_interface.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';
import 'package:planning_poker_ifood/src/core/usecases/usecase_interface.dart';

class CreateRoomUsecase implements IUsecase<RoomEntity, CreateRoomParams> {
  final IRoomRepository _roomRepository;

  CreateRoomUsecase({required IRoomRepository roomRepository}) : _roomRepository = roomRepository;

  @override
  Future<Output<RoomEntity>> call(CreateRoomParams params) async {
    return await _roomRepository.createRoom(collection: params.collection, data: params.data);
  }
}

class CreateRoomParams {
  final String collection;
  final Map<String, dynamic> data;

  CreateRoomParams({required this.collection, required this.data});
}
