import 'package:planning_poker_ifood/src/core/features/user/domain/entities/user_entity.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';

abstract interface class IAuthRepository {
  Future<Output<UserEntity>> signInWithEmailAndPassword({required String email, required String password});
  Future<Output<UserEntity>> signUpWithEmailAndPassword({required String name, required String email, required String password});
}