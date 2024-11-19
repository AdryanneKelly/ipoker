import 'package:planning_poker_ifood/src/core/features/task/domain/entities/task_entity.dart';
import 'package:planning_poker_ifood/src/core/features/task/domain/repositories/task_repository_interface.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';
import 'package:planning_poker_ifood/src/core/usecases/usecase_interface.dart';

class GetTaskUsecase implements IUsecase<List<TaskEntity>, GetTaskParams> {
  final ITaskRepository _taskRepository;

  GetTaskUsecase({required ITaskRepository taskRepository}) : _taskRepository = taskRepository;
  @override
  Future<Output<List<TaskEntity>>> call(GetTaskParams params) async {
    return await _taskRepository.getTasks(roomId: params.roomId, collection: params.collection);
  }
}

class GetTaskParams {
  final String collection;
  final String roomId;

  GetTaskParams({required this.roomId, required this.collection});
}
