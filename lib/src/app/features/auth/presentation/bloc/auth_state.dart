part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();  

  @override
  List<Object> get props => [];
}
class AuthInitial extends AuthState {}

class LoginAuthLoading extends AuthState {}

class LoginAuthSuccess extends AuthState {
  final UserEntity user;

  const LoginAuthSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class LoginAuthFailure extends AuthState {
  final String message;

  const LoginAuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}

class RegisterAuthLoading extends AuthState {}

class RegisterAuthSuccess extends AuthState {
  final UserEntity user;

  const RegisterAuthSuccess({required this.user});

  @override
  List<Object> get props => [user];
}

class RegisterAuthFailure extends AuthState {
  final String message;

  const RegisterAuthFailure({required this.message});

  @override
  List<Object> get props => [message];
}
