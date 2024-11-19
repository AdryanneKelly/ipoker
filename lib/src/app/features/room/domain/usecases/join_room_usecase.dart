import 'package:planning_poker_ifood/src/app/features/room/domain/entities/room_entity.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/repositories/room_repository_interface.dart';
import 'package:planning_poker_ifood/src/core/features/user/domain/entities/user_entity.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';
import 'package:planning_poker_ifood/src/core/usecases/usecase_interface.dart';

class JoinRoomUsecase implements IUsecase<RoomEntity, JoinRoomParams> {
  final IRoomRepository _roomRepository;

  JoinRoomUsecase({
    required IRoomRepository roomRepository,
  }) : _roomRepository = roomRepository;

  @override
  Future<Output<RoomEntity>> call(JoinRoomParams params) async {
    return await _roomRepository.joinRoom(
      collection: params.collection,
      roomId: params.roomId,
      user: params.user,
    );
  }
}

class JoinRoomParams {
  final String collection;
  final String roomId;
  final UserEntity user;

  JoinRoomParams({required this.collection, required this.roomId, required this.user});
}
