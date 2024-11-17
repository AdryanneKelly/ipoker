import 'package:planning_poker_ifood/src/core/features/user/domain/entities/user_entity.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';

abstract interface class IUserRepository {
  Future<Output<UserEntity>> getByUuid({
    required String uuid,
    required String collection,
  });

  Future<Output<UserEntity>> add({
    required String collection,
    required String uid,
    required Map<String, dynamic> data,
  });
}
