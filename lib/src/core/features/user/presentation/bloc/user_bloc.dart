import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planning_poker_ifood/src/core/features/user/domain/entities/user_entity.dart';
import 'package:planning_poker_ifood/src/core/features/user/domain/usecases/get_user_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final GetUserUsecase _getUserUsecase;

  UserBloc({required GetUserUsecase getUserUsecase})
      : _getUserUsecase = getUserUsecase,
        super(UserInitial()) {
    on<GetUserEvent>((event, emit) {
      emit(UserLoading());
      _getUserUsecase(GetUserParams(uuid: event.uuid, collection: event.collection)).then((result) {
        result.fold(
          (error) => emit(UserError(message: error.message)),
          (user) => emit(UserLoaded(user: user)),
        );
      });
    });
  }
}
