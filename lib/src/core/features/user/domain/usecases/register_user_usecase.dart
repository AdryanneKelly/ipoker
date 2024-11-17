import 'package:planning_poker_ifood/src/core/features/user/domain/entities/user_entity.dart';
import 'package:planning_poker_ifood/src/core/features/user/domain/repositories/user_repository_interface.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';
import 'package:planning_poker_ifood/src/core/usecases/usecase_interface.dart';

class RegisterUserUsecase implements IUsecase<void, RegisterUserParams> {
  final IUserRepository _repository;

  RegisterUserUsecase({
    required IUserRepository repository,
  }) : _repository = repository;

  @override
  Future<Output<UserEntity>> call(RegisterUserParams params) async {
    return await _repository.add(
      collection: params.collection,
      data: params.data,
      uid: params.uid,
    );
  }
}

class RegisterUserParams {
  final String collection;
  final Map<String, dynamic> data;
  final String uid;

  RegisterUserParams({
    required this.collection,
    required this.data,
    required this.uid,
  });
}
