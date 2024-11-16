import 'package:firebase_auth/firebase_auth.dart';
import 'package:fpdart/fpdart.dart';
import 'package:planning_poker_ifood/src/core/exceptions/auth_exception.dart';
import 'package:planning_poker_ifood/src/core/services/database/firebase/auth_firebase_interface.dart';
import 'package:planning_poker_ifood/src/core/typedefs/typedefs.dart';

class AuthRemoteDatasource implements IAuthFirebase {
  final FirebaseAuth _firebaseAuth;

  AuthRemoteDatasource({required FirebaseAuth firebaseAuth}) : _firebaseAuth = firebaseAuth;

  @override
  Future<Output<UserCredential>> signInWithEmailAndPassword({required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
      return right(userCredential);
    } on AuthException catch (e) {
      return left(e);
    }
  }

  @override
  Future<Output<UserCredential>> signUpWithEmailAndPassword({required String name, required String email, required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
      userCredential.user!.updateDisplayName(name);
      return right(userCredential);
    } on AuthException catch (e) {
      return left(e);
    }
  }
  
}