import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'request_store.g.dart';

class RequestStore = _RequestStore with _$RequestStore;

abstract class _RequestStore with Store {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String?> fetchId(
    String collection,
    String? secondCollection,
    String? document,
    String field,
    String value,
  ) async {
    try {
      QuerySnapshot collectionSnapshot;

      if (document == null || secondCollection == null) {
        collectionSnapshot = await _firebaseFirestore
            .collection(collection)
            .where(field, isEqualTo: value.toLowerCase())
            .get();
      } else {
        collectionSnapshot = await _firebaseFirestore
            .collection(collection)
            .doc(document)
            .collection(secondCollection)
            .where(field, isEqualTo: value.toLowerCase())
            .get();
      }

      if (collectionSnapshot.docs.isNotEmpty) {
        return collectionSnapshot.docs.first.id;
      } else {
        print("Nenhum documento encontrado com $field igual a $value.");
        return null;
      }
    } catch (e) {
      print("Erro ao buscar o documento: $e");
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> fetchData(
    String collection,
    String? secondCollection,
    String? document,
    List<String> information,
  ) async {
    try {
      List<Map<String, dynamic>> dataList = [];
      QuerySnapshot collectionSnapshot;
      String collectionTypeKey;

      if (document == null && secondCollection == null) {
        collectionSnapshot =
            await _firebaseFirestore.collection(collection).get();
        collectionTypeKey = 'document';
      } else {
        collectionSnapshot = await _firebaseFirestore
            .collection(collection)
            .doc(document!)
            .collection(secondCollection!)
            .get();
        collectionTypeKey = secondCollection;
      }

      for (var doc in collectionSnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        Map<String, dynamic> extractedData = {};

        for (var key in information) {
          extractedData[key] = data[key];
        }

        dataList.add({
          "id": doc.id,
          collectionTypeKey: extractedData,
        });
      }

      return dataList;
    } catch (e) {
      print("Erro ao recuperar a coleção: $e");
      return [];
    }
  }

  Future<dynamic> fetchSpecificInformation(
    String collection,
    String? secondCollection,
    String document,
    String? secondDocument,
    String field,
  ) async {
    try {
      QuerySnapshot querySnapshot;

      if (secondCollection == null || secondDocument == null) {
        querySnapshot = await _firebaseFirestore
            .collection(collection)
            .where(field)
            .get();
      } else {
        querySnapshot = await _firebaseFirestore
            .collection(collection)
            .doc(document)
            .collection(secondCollection)
            .where(field)
            .get();
      }
      
      var doc = querySnapshot.docs[0];
      return doc[field];
    } catch (e) {
      print("Error fetching information: $e");
      return null;
    }
  }
}
