import 'package:planning_poker_ifood/src/app/features/room/domain/entities/task_entity.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/repositories/room_repository_interface.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';
import 'package:planning_poker_ifood/src/core/usecases/usecase_interface.dart';

class CreateTaskUsecase implements IUsecase<List<TaskEntity>, CreateTaskParams> {
  final IRoomRepository _roomRepository;

  CreateTaskUsecase({required IRoomRepository roomRepository}) : _roomRepository = roomRepository;

  @override
  Future<Output<List<TaskEntity>>> call(CreateTaskParams params) async {
    return await _roomRepository.createTasks(roomId: params.roomId, collection: params.collection, tasks: params.tasks);
  }
}

class CreateTaskParams {
  final String collection;
  final List<Map<String, dynamic>> tasks;
  final String roomId;

  CreateTaskParams({required this.roomId, required this.collection, required this.tasks});
}
