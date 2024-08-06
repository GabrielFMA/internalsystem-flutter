import 'package:internalsystem/models/request_model.dart';
import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'request_store.g.dart';

class RequestStore = _RequestStore with _$RequestStore;

abstract class _RequestStore with Store {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<List<Map<String, dynamic>>> collectionRecovery(
    String collection,
    String primaryInformation,
    String secondInformation,
  ) async {
    final collectionSnapshot =
        await _firebaseFirestore.collection(collection).get();

    List<Map<String, dynamic>> dataList = [];
    for (var doc in collectionSnapshot.docs) {
      final data = doc.data();
      dataList.add({
        "id": doc.id,
        primaryInformation: data[primaryInformation],
        secondInformation: data[secondInformation],
      });
    }
    return dataList;
  }

  @action
  Future<RequestModel> fetchData(
    String collection,
    String document,
  ) async {
    final docSnapshot =
        await _firebaseFirestore.collection(collection).doc(document).get();

    return RequestModel.fromMap(docSnapshot.data() ?? {});
  }

  @action
  Future<RequestModel> fetchSecondaryData(
    String collection,
    String secondCollection,
    String document,
    String secondDocument,
  ) async {
    try {
      // Obtém o documento do Firestore
      final docSnapshot = await _firebaseFirestore
          .collection(collection)
          .doc(document)
          .collection(secondCollection)
          .doc(secondDocument)
          .get();

      final permissionsData = secondCollection == 'permissions'
          ? docSnapshot.data() ?? {}
          : TemplateRequestModel().permissions;

      return RequestModel(permissions: permissionsData);
    } catch (e) {
      print('Erro ao buscar: $e');
      return RequestModel();
    }
  }
}
