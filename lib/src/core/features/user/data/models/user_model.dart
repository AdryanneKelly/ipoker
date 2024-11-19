import 'package:firebase_auth/firebase_auth.dart';
import 'package:planning_poker_ifood/src/core/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({
    required super.id,
    required super.name,
    required super.email,
    super.point,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    try {
      return UserModel(
        id: map['uid'] as String,
        email: map['email'] as String,
        name: map['name'] as String,
        point: map['point'] != null ? map['point'] as int : null,
    );
  
    } catch (e, s) {
      throw Exception('Error parsing UserModel: $e - $s');
    }
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
      'uid': id,
      'point': point,
      'name': name,
      'email': email,
    };
  }

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    int? point,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      point: point ?? this.point,
    );
  }
}
