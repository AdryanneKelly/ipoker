import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planning_poker_ifood/src/core/services/database/firebase/firebase_interface.dart';

class RoomRemoteDatasource implements IFirebase {
  final FirebaseFirestore _firebaseFirestore;

  RoomRemoteDatasource({required FirebaseFirestore firebaseFirestore}) : _firebaseFirestore = firebaseFirestore;

  @override
  Future<Map<String, dynamic>> add({required String collection, required Map<String, dynamic> data}) async {
    final response = await _firebaseFirestore.collection(collection).add(data);
    return response.get().then((doc) => doc.data()!);
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
    final doc = await _firebaseFirestore.collection(collection).doc(document).get();
    return doc.data()!;
  }

  @override
  Future<void> update(
      {required String collection, required String document, required Map<String, dynamic> data}) async {
    await _firebaseFirestore.collection(collection).doc(document).update(data);
  }
}
