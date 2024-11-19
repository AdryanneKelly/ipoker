import 'package:planning_poker_ifood/src/core/features/task/domain/entities/task_entity.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';

abstract interface class ITaskRepository {
  Future<Output<List<TaskEntity>>> getTasks({
    required String collection,
    required String roomId,
  });

  Future<Output<TaskEntity>> createTask({
    required String collection,
    required TaskEntity task,
  });

  Future<void> updateTask({
    required String collection,
    required TaskEntity task,
  });
}
