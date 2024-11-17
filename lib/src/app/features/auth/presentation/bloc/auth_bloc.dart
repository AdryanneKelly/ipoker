import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planning_poker_ifood/src/core/features/user/domain/entities/user_entity.dart';
import 'package:planning_poker_ifood/src/app/features/auth/domain/usecases/login_usecase.dart';
import 'package:planning_poker_ifood/src/app/features/auth/domain/usecases/register_usecase.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUsecase _loginUsecase;
  final RegisterUsecase _registerUsecase;

  AuthBloc({
    required LoginUsecase loginUsecase,
    required RegisterUsecase registerUsecase,
  })  : _loginUsecase = loginUsecase,
        _registerUsecase = registerUsecase, 
        super(AuthInitial()) {
    on<RegisterAuthEvent>((event, emit) async {
      emit(RegisterAuthLoading());
      final result = await _registerUsecase(RegisterParams(name: event.name, email: event.email, password: event.password));
      result.fold(
        (exception) => emit(RegisterAuthFailure(message: exception.message)),
        (user) => emit(RegisterAuthSuccess(user: user)),
      );
    });
    on<LoginAuthEvent>((event, emit) async {
      emit(LoginAuthLoading());
      final result = await _loginUsecase(LoginParams(email: event.email, password: event.password));
      result.fold(
        (exception) => emit(LoginAuthFailure(message:  exception.message)),
        (user) => emit(LoginAuthSuccess(user: user)),
      );
    });
  }
}
