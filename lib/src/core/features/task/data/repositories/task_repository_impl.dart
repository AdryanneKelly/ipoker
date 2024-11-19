import 'package:fpdart/fpdart.dart';
import 'package:planning_poker_ifood/src/core/features/task/data/datasources/task_remote_datasource.dart';
import 'package:planning_poker_ifood/src/core/features/task/data/models/task_model.dart';
import 'package:planning_poker_ifood/src/core/features/task/domain/entities/task_entity.dart';
import 'package:planning_poker_ifood/src/core/features/task/domain/repositories/task_repository_interface.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';

class TaskRepositoryImpl implements ITaskRepository {
  final TaskRemoteDatasource _taskRemoteDatasource;

  TaskRepositoryImpl({required TaskRemoteDatasource taskRemoteDatasource})
      : _taskRemoteDatasource = taskRemoteDatasource;
  @override
  Future<Output<TaskEntity>> createTask({required String collection, required TaskEntity task}) async {
    final result = await _taskRemoteDatasource.add(collection: collection, data: (task as TaskModel).toMap());
    return right(TaskModel.fromMap(result));
  }

  @override
  Future<Output<List<TaskEntity>>> getTasks({required String collection, required String roomId}) async {
    final result = await _taskRemoteDatasource.get(collection: collection);

    final taskByRoom = result.where((element) => element['roomId'] == roomId).toList();

    final tasks = taskByRoom.map((e) => TaskModel.fromMap(e)).toList();

    return right(tasks);
  }

  @override
  Future<void> updateTask({required String collection, required TaskEntity task}) async {
    final result = await _taskRemoteDatasource.update(
        collection: collection, document: task.uid!, data: (task as TaskModel).toMap());
    return result;
  }
}
