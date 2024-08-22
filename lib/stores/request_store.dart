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

  Future<String?> fetchId(
    String collection,
    String field,
    String value,
  ) async {
    try {
      final collectionSnapshot = await _firebaseFirestore
          .collection(collection)
          .where(field, isEqualTo: value.toLowerCase())
          .get();

      if (collectionSnapshot.docs.isNotEmpty) {
        return collectionSnapshot.docs[0].id;
      } else {
        print("Nenhum documento encontrado com $field igual a $value.");
        return null;
      }
    } catch (e) {
      print("Erro ao buscar o documento: $e");
      return null;
    }
  }

  Future<String?> fetchSecondaryId(
    String collection,
    String secondCollection,
    String document,
    String field,
    String value,
  ) async {
    try {
      final collectionSnapshot = await _firebaseFirestore
          .collection(collection)
          .doc(document)
          .collection(secondCollection)
          .where(field, isEqualTo: value.toLowerCase())
          .get();

      if (collectionSnapshot.docs.isNotEmpty) {
        return collectionSnapshot.docs[0].id;
      } else {
        print("Nenhum documento encontrado com $field igual a $value.");
        return null;
      }
    } catch (e) {
      print("Erro ao buscar o documento: $e");
      return null;
    }
  }

  @action
  Future<List<Map<String, dynamic>>> fetchSecondaryData(
    String collection,
    String secondCollection,
    String document,
  ) async {
    final secondCollectionSnapshot = await _firebaseFirestore
        .collection(collection)
        .doc(document)
        .collection(secondCollection)
        .get();

    List<Map<String, dynamic>> secondaryList = [];
    if (secondCollectionSnapshot.docs.isNotEmpty) {
      for (var doc in secondCollectionSnapshot.docs) {
        final data = doc.data();
        secondaryList.add({
          "id": doc.id,
          secondCollection: data,
        });
      }
    }

    return secondaryList;
  }
}
