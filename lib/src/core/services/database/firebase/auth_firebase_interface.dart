import 'package:firebase_auth/firebase_auth.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';

abstract interface class IAuthFirebase {
  Future<Output<UserCredential>> signInWithEmailAndPassword({required String email, required String password});
  Future<Output<UserCredential>> signUpWithEmailAndPassword({required String name, required String email, required String password});
}
