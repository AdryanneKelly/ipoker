import 'package:planning_poker_ifood/src/core/features/user/domain/entities/user_entity.dart';
import 'package:planning_poker_ifood/src/app/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';
import 'package:planning_poker_ifood/src/core/usecases/usecase_interface.dart';

class LoginUsecase implements IUsecase<UserEntity, LoginParams> {
  final IAuthRepository _authRepository;

  LoginUsecase({required IAuthRepository authRepository}) : _authRepository = authRepository;
  
  @override
  Future<Output<UserEntity>> call(LoginParams params) async {
    return await _authRepository.signInWithEmailAndPassword(email: params.email, password: params.password);
  }
}

class LoginParams {
  final String email;
  final String password;

  LoginParams({required this.email, required this.password});
}