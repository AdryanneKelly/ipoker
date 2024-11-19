// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:planning_poker_ifood/src/app/features/room/domain/entities/room_entity.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/repositories/room_repository_interface.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';
import 'package:planning_poker_ifood/src/core/usecases/usecase_interface.dart';

class FinishRoomUsecase implements IUsecase<RoomEntity, FinishRoomParams> {
  final IRoomRepository _roomRepository;

  FinishRoomUsecase({required IRoomRepository roomRepository}) : _roomRepository = roomRepository;

  @override
  Future<Output<RoomEntity>> call(FinishRoomParams params) async {
    return await _roomRepository.updateRoom(
      collection: params.collection,
      data: params.data,
      documentId: params.roomId,
    );
  }
}

class FinishRoomParams {
  final String collection;
  final String roomId;
  final Map<String, dynamic> data;

  FinishRoomParams({
    required this.collection,
    required this.roomId,
    required this.data,
  });
}
