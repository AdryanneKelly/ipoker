import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get_it/get_it.dart';
import 'package:planning_poker_ifood/src/app/features/auth/data/datasources/auth_remote_datasource.dart';
import 'package:planning_poker_ifood/src/app/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:planning_poker_ifood/src/app/features/auth/domain/repositories/auth_repository_interface.dart';
import 'package:planning_poker_ifood/src/app/features/auth/domain/usecases/login_usecase.dart';
import 'package:planning_poker_ifood/src/app/features/auth/domain/usecases/register_usecase.dart';
import 'package:planning_poker_ifood/src/app/features/auth/presentation/bloc/auth_bloc.dart';

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
}
