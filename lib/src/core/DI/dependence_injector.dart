import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:planning_poker_ifood/src/app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:planning_poker_ifood/src/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:planning_poker_ifood/src/app/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:planning_poker_ifood/src/app/features/auth/domain/usecases/login_usecase.dart';
import 'package:planning_poker_ifood/src/app/features/auth/domain/usecases/register_usecase.dart';
import 'package:planning_poker_ifood/src/app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:planning_poker_ifood/src/app/features/room/data/datasources/room_remote_datasource.dart';
import 'package:planning_poker_ifood/src/app/features/room/data/repositories/room_repository_impl.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/repositories/room_repository_interface.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/usecases/create_room_usecase.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/usecases/create_task_usecase.dart';
import 'package:planning_poker_ifood/src/app/features/room/domain/usecases/get_room_usecase.dart';
import 'package:planning_poker_ifood/src/app/features/room/presentation/bloc/room_bloc.dart';
import 'package:planning_poker_ifood/src/core/features/user/data/datasources/user_remote_datasource.dart';
import 'package:planning_poker_ifood/src/core/features/user/data/repositories/user_repository_impl.dart';
import 'package:planning_poker_ifood/src/core/features/user/domain/repositories/user_repository_interface.dart';
import 'package:planning_poker_ifood/src/core/features/user/domain/usecases/get_user_usecase.dart';
import 'package:planning_poker_ifood/src/core/features/user/domain/usecases/register_user_usecase.dart';
import 'package:planning_poker_ifood/src/core/features/user/presentation/bloc/user_bloc.dart';

final injector = GetIt.instance;
FirebaseAuth get firebaseAuth => FirebaseAuth.instance;
FirebaseFirestore get firebaseFirestore => FirebaseFirestore.instance;

void setupDI() {
  injector.registerLazySingleton<FirebaseAuth>(() => firebaseAuth);
  injector.registerLazySingleton<FirebaseFirestore>(() => firebaseFirestore);
  injector.registerFactory<AuthRemoteDatasource>(() => AuthRemoteDatasource(firebaseAuth: injector<FirebaseAuth>()));
  injector
      .registerFactory<IAuthRepository>(() => AuthRepositoryImpl(remoteDatasource: injector<AuthRemoteDatasource>()));
  injector.registerFactory<LoginUsecase>(() => LoginUsecase(authRepository: injector<IAuthRepository>()));
  injector.registerFactory<RegisterUsecase>(() => RegisterUsecase(authRepository: injector<IAuthRepository>()));
  injector.registerLazySingleton<AuthBloc>(() => AuthBloc(loginUsecase: injector<LoginUsecase>(), registerUsecase: injector<RegisterUsecase>()));
  injector.registerFactory<RoomRemoteDatasource>(
      () => RoomRemoteDatasource(firebaseFirestore: injector<FirebaseFirestore>()));
  injector.registerFactory<IRoomRepository>(() => RoomRepositoryImpl(roomDatasource: injector<RoomRemoteDatasource>()));
  injector.registerFactory<GetRoomUsecase>(() => GetRoomUsecase(roomRepository: injector<IRoomRepository>()));
  injector.registerFactory<CreateRoomUsecase>(() => CreateRoomUsecase(roomRepository: injector<IRoomRepository>()));
  injector.registerFactory<CreateTaskUsecase>(() => CreateTaskUsecase(roomRepository: injector<IRoomRepository>()));
  injector.registerLazySingleton<RoomBloc>(() => RoomBloc(
      getRoomUsecase: injector<GetRoomUsecase>(),
      createRoomUsecase: injector<CreateRoomUsecase>(),
      createTaskUsecase: injector<CreateTaskUsecase>()));
  injector.registerFactory<UserRemoteDatasource>(
      () => UserRemoteDatasource(firebaseFirestore: injector<FirebaseFirestore>()));
  injector.registerFactory<IUserRepository>(
      () => UserRepositoryImpl(userRemoteDatasource: injector<UserRemoteDatasource>()));
  injector.registerFactory<GetUserUsecase>(() => GetUserUsecase(repository: injector<IUserRepository>()));
  injector.registerFactory<RegisterUserUsecase>(() => RegisterUserUsecase(repository: injector<IUserRepository>()));
  injector.registerLazySingleton(() => UserBloc(getUserUsecase: injector<GetUserUsecase>()));
}
