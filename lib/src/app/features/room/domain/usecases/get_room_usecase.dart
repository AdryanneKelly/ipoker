import 'package:planning_poker_ifood/src/app/features/room/domain/entities/room_entity.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/repositories/room_repository_interface.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';
import 'package:planning_poker_ifood/src/core/usecases/usecase_interface.dart';

class GetRoomUsecase implements IUsecase<List<RoomEntity>, GetRommParams> {
  final IRoomRepository _roomRepository;

  GetRoomUsecase({required IRoomRepository roomRepository}) : _roomRepository = roomRepository;

  @override
  Future<Output<List<RoomEntity>>> call(GetRommParams params) async {
    return await _roomRepository.getRooms(userId: params.userId);
  }
}

class GetRommParams {
  final String userId;

  GetRommParams({required this.userId});
}
