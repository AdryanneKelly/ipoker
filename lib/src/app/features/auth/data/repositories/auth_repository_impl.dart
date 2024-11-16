import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:planning_poker_ifood/src/app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:planning_poker_ifood/src/app/features/auth/data/models/user_model.dart';
import 'package:planning_poker_ifood/src/app/features/auth/domain/entities/user_entity.dart';
import 'package:planning_poker_ifood/src/app/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:planning_poker_ifood/src/core/exceptions/auth_exception.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';

class AuthRepositoryImpl implements IAuthRepository {
  final AuthRemoteDatasource _remoteDatasource;

  AuthRepositoryImpl({required AuthRemoteDatasource remoteDatasource}) : _remoteDatasource = remoteDatasource;

  @override
  Future<Output<UserEntity>> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final response = await _remoteDatasource.signInWithEmailAndPassword(email: email, password: password);
      return response.fold(
        (exception) => left(exception),
        (credential) => right(UserModel.fromCredential(credential)),
      );
    } on FirebaseAuthException catch (e, s) {
      if (e.code == 'user-not-found') {
        return left(AuthException(message: 'Usuário não encontrado'));
      } else if (e.code == 'wrong-password') {
        return left(AuthException(message: 'Senha incorreta'));
      } else if (e.code == 'invalid-credential') {
        return left(AuthException(message: 'Email ou senha inválidos'));
      }
      return left(AuthException(message: e.toString()));
    }
  }

  @override
  Future<Output<UserEntity>> signUpWithEmailAndPassword(
      {required String name, required String email, required String password}) async {
    final response = await _remoteDatasource.signUpWithEmailAndPassword(name: name, email: email, password: password);
    return response.fold(
      (exception) => left(exception),
      (credential) => right(UserModel.fromCredential(credential)),
    );
  }
}
