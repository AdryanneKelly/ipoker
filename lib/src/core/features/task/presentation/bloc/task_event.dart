part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class GetTasks extends TaskEvent {
  final String roomId;
  final String collection;

  const GetTasks({required this.roomId, required this.collection});

  @override
  List<Object> get props => [roomId, collection];
}

class CreateTask extends TaskEvent {
  final String collection;
  final TaskEntity task;

  const CreateTask({required this.collection, required this.task});

  @override
  List<Object> get props => [collection, task];
}
