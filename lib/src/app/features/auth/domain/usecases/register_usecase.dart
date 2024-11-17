import 'package:planning_poker_ifood/src/core/features/user/domain/entities/user_entity.dart';
import 'package:planning_poker_ifood/src/app/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';
import 'package:planning_poker_ifood/src/core/usecases/usecase_interface.dart';

class RegisterUsecase implements IUsecase<UserEntity, RegisterParams> {
  final IAuthRepository _authRepository;

  RegisterUsecase({required IAuthRepository authRepository}) : _authRepository = authRepository;

  @override
  Future<Output<UserEntity>> call(RegisterParams params) async {
    return await _authRepository.signUpWithEmailAndPassword(name: params.name, email: params.email, password: params.password);
  }

}

class RegisterParams {
  final String name;
  final String email;
  final String password;

  RegisterParams({required this.name, required this.email, required this.password});
}