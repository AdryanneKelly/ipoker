part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserInitial extends UserState {}

class UserLoading extends UserState {}

class UserError extends UserState {
  final String message;

  const UserError({required this.message});

  @override
  List<Object> get props => [message];
}

class UserLoaded extends UserState {
  final UserEntity user;

  const UserLoaded({required this.user});

  @override
  List<Object> get props => [user];
}
