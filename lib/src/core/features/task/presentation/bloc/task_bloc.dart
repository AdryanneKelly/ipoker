import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planning_poker_ifood/src/core/features/task/domain/entities/task_entity.dart';
import 'package:planning_poker_ifood/src/core/features/task/domain/usecases/create_task_usecase.dart';
import 'package:planning_poker_ifood/src/core/features/task/domain/usecases/get_task_usecase.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final GetTaskUsecase _getTaskUsecase;
  final CreateTaskUsecase _createTaskUsecase;
  TaskBloc({
    required GetTaskUsecase getTaskUsecase,
    required CreateTaskUsecase createTaskUsecase,
  })  : _getTaskUsecase = getTaskUsecase,
        _createTaskUsecase = createTaskUsecase,
        super(TaskInitial()) {
    on<GetTasks>((event, emit) async {
      emit(TaskLoading());
      final result = await _getTaskUsecase.call(GetTaskParams(
        roomId: event.roomId,
        collection: event.collection,
      ));
      result.fold(
        (error) => emit(TaskError(message: error.message)),
        (tasks) => emit(TaskLoaded(tasks: tasks)),
      );
    });

    on<CreateTask>((event, emit) async {
      emit(TaskLoading());
      final result = await _createTaskUsecase.call(CreateTaskParam(
        collection: event.collection,
        task: event.task,
      ));
      result.fold(
        (error) => emit(TaskError(message: error.message)),
        (task) => emit(TaskCreated(task: task)),
      );
    });
  }
}
