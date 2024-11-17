import 'package:planning_poker_ifood/src/core/features/user/domain/entities/user_entity.dart';
import 'package:planning_poker_ifood/src/core/features/user/domain/repositories/user_repository_interface.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';
import 'package:planning_poker_ifood/src/core/usecases/usecase_interface.dart';

class GetUserUsecase implements IUsecase<UserEntity, GetUserParams> {
  final IUserRepository _repository;

  GetUserUsecase({
    required IUserRepository repository,
  }) : _repository = repository;

  @override
  Future<Output<UserEntity>> call(
    GetUserParams params,
  ) {
    return _repository.getByUuid(
      uuid: params.uuid,
      collection: params.collection,
    );
  }
}

class GetUserParams {
  final String uuid;
  final String collection;

  GetUserParams({
    required this.uuid,
    required this.collection,
  });
}
