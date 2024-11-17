import 'package:firebase_auth/firebase_auth.dart';
import 'package:planning_poker_ifood/src/core/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'],
      email: map['email'],
    );
  }

  factory UserModel.fromCredential(UserCredential credential) {
    return UserModel(
      id: credential.user!.uid,
      name: credential.user!.displayName ?? '',
      email: credential.user!.email ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
    };
  }
}
