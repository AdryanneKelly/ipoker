import 'package:planning_poker_ifood/src/core/features/task/domain/entities/task_entity.dart';
import 'package:planning_poker_ifood/src/core/features/task/domain/repositories/task_repository_interface.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';
import 'package:planning_poker_ifood/src/core/usecases/usecase_interface.dart';

class CreateTaskUsecase implements IUsecase<TaskEntity, CreateTaskParam> {
  final ITaskRepository _taskRepository;

  CreateTaskUsecase({required ITaskRepository taskRepository}) : _taskRepository = taskRepository;

  @override
  Future<Output<TaskEntity>> call(CreateTaskParam params) async {
    return await _taskRepository.createTask(collection: params.collection, task: params.task);
  }
}

class CreateTaskParam {
  final String collection;
  final TaskEntity task;

  CreateTaskParam({required this.collection, required this.task});
}
