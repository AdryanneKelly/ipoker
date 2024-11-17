part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class GetUserEvent extends UserEvent {
  final String uuid;
  final String collection;

  const GetUserEvent({
    required this.uuid,
    required this.collection,
  });

  @override
  List<Object> get props => [uuid, collection];
}