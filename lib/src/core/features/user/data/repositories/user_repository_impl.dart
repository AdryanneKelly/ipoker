import 'package:fpdart/fpdart.dart';
import 'package:planning_poker_ifood/src/core/features/user/data/datasources/user_remote_datasource.dart';
import 'package:planning_poker_ifood/src/core/features/user/data/models/user_model.dart';
import 'package:planning_poker_ifood/src/core/features/user/domain/entities/user_entity.dart';
import 'package:planning_poker_ifood/src/core/features/user/domain/repositories/user_repository_interface.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';

class UserRepositoryImpl implements IUserRepository {
  final UserRemoteDatasource _userRemoteDatasource;

  UserRepositoryImpl({required UserRemoteDatasource userRemoteDatasource})
      : _userRemoteDatasource = userRemoteDatasource;

  @override
  Future<Output<UserEntity>> add(
      {required String collection, required String uid, required Map<String, dynamic> data}) async {
    data['uuid'] = uid;
    final response = await _userRemoteDatasource.add(collection: collection, data: data);
    return right(UserModel.fromMap(response));
  }

  @override
  Future<Output<UserEntity>> getByUuid({required String uuid, required String collection}) async {
    final response = await _userRemoteDatasource.getByDocument(document: uuid, collection: collection);
    return right(UserModel.fromMap(response));
  }
}
