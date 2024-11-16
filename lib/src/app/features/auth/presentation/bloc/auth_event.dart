part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginAuthEvent extends AuthEvent {
  final String email;
  final String password;

  const LoginAuthEvent({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}

class RegisterAuthEvent extends AuthEvent {
  final String name;
  final String email;
  final String password;

  const RegisterAuthEvent({required this.name, required this.email, required this.password});

  @override
  List<Object> get props => [name, email, password];
}
