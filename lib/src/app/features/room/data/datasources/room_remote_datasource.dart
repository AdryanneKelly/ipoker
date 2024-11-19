import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:planning_poker_ifood/src/core/services/database/firebase/firebase_interface.dart';

class RoomRemoteDatasource implements IFirebase {
  final FirebaseFirestore _firebaseFirestore;

  RoomRemoteDatasource({required FirebaseFirestore firebaseFirestore}) : _firebaseFirestore = firebaseFirestore;

  @override
  Future<Map<String, dynamic>> add({required String collection, required Map<String, dynamic> data}) async {
    final response = await _firebaseFirestore.collection(collection).add(data);
    return response.get().then((doc) {
      final data = doc.data();
      data!['uid'] = doc.id;
      return data;
    });
  }

  @override
  Future<void> delete({required String collection, required String document}) async {
    await _firebaseFirestore.collection(collection).doc(document).delete();
  }

  @override
  Future<List<Map<String, dynamic>>> get({required String collection}) async {
    final querySnapshot = await _firebaseFirestore.collection(collection).get();
    return querySnapshot.docs.map((doc) {
      doc.data()['uid'] = doc.id;
      return doc.data();
    }).toList();
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
  
  @override
  Future<List<Map<String, dynamic>>> getByUser({required String collection, required String userId}) async {
    final querySnapshot = await _firebaseFirestore.collection(collection).get();
    // Filtra os documentos onde o uid do moderador é igual ao userId
    final filterToUser = querySnapshot.docs.where((doc) {
      final data = doc.data();

      // Verifica se o campo 'moderator' é um Map e acessa o 'uid'
      if (data['moderator'] is Map<String, dynamic>) {
        final moderator = data['moderator'] as Map<String, dynamic>;
        return moderator['uid'] == userId;
      }
      return false;
    }).toList();

    // Retorna os dados filtrados com o 'uid' do documento
    return filterToUser.map((doc) {
      final data = doc.data();
      data['uid'] = doc.id;
      return data;
    }).toList();
  }
}
