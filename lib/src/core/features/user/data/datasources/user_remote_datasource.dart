import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planning_poker_ifood/src/core/services/database/firebase/firebase_interface.dart';

class UserRemoteDatasource implements IFirebase {
  final FirebaseFirestore _firebaseFirestore;

  UserRemoteDatasource({required FirebaseFirestore firebaseFirestore}) : _firebaseFirestore = firebaseFirestore;

  @override
  Future<Map<String, dynamic>> add({required String collection, required Map<String, dynamic> data}) async {
    final documentReference = await _firebaseFirestore.collection(collection).add(data);
    final documentSnapshot = await documentReference.get();
    return documentSnapshot.data()!;
  }

  @override
  Future<void> delete({required String collection, required String document}) async {
    await _firebaseFirestore.collection(collection).doc(document).delete();
  }

  @override
  Future<List<Map<String, dynamic>>> get({required String collection}) async {
    final querySnapshot = await _firebaseFirestore.collection(collection).get();
    return querySnapshot.docs.map((doc) => doc.data()).toList();
  }

  @override
  Future<Map<String, dynamic>> getByDocument({required String collection, required String document}) async {
    final documentSnapshot = await _firebaseFirestore.collection(collection).doc(document).get();
    return documentSnapshot.data()!;
  }

  @override
  Future<void> update(
      {required String collection, required String document, required Map<String, dynamic> data}) async {
    await _firebaseFirestore.collection(collection).doc(document).update(data);
  }
  
  @override
  Future<List<Map<String, dynamic>>> getByUser({required String collection, required String userId}) {
    // TODO: implement getByUser
    throw UnimplementedError();
  }
}
