abstract interface class IFirebase {
  Future<List<Map<String, dynamic>>> get({required String collection});
  Future<Map<String, dynamic>> add({required String collection, required Map<String, dynamic> data});
  Future<void> update({required String collection, required String document, required Map<String, dynamic> data});
  Future<void> delete({required String collection, required String document});
  Future<Map<String, dynamic>> getByDocument({required String collection, required String document});
}
