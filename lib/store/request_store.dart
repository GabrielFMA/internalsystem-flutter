// ignore_for_file: unrelated_type_equality_checks, library_private_types_in_public_api, avoid_print

import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'request_store.g.dart';

class RequestStore = _RequestStore with _$RequestStore;

abstract class _RequestStore with Store {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Future<String?> fetchId(
    String collection,
    String field,
    String value, {
    String? secondCollection,
    String? document,
  }) async {
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
    String collection, {
    String? secondCollection,
    String? document,
    List<String>? information,
  }) async {
    try {
      List<Map<String, dynamic>> dataList = [];
      QuerySnapshot collectionSnapshot;

      if (document == null && secondCollection == null) {
        collectionSnapshot =
            await _firebaseFirestore.collection(collection).get();
      } else if (document != null && secondCollection != null) {
        collectionSnapshot = await _firebaseFirestore
            .collection(collection)
            .doc(document)
            .collection(secondCollection)
            .get();
      } else {
        print("Parâmetros fornecidos são inconsistentes.");
        return [];
      }

      for (var doc in collectionSnapshot.docs) {
        final data = doc.data() as Map<String, dynamic>;
        Map<String, dynamic> extractedData = {};

        if (information != null) {
          for (var key in information) {
            if (data.containsKey(key)) {
              extractedData[key] = data[key];
            }
          }
        } else {
          extractedData = data;
        }

        dataList.add({
          "uid": document ?? doc.id,
          "data": extractedData,
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
    String field,
    dynamic value, {
    String? document,
    String? secondCollection,
    List<String>? information,
  }) async {
    try {
      QuerySnapshot querySnapshot;

      if (secondCollection == null) {
        querySnapshot = await _firebaseFirestore
            .collection(collection)
            .where(field, isEqualTo: value)
            .get();
      } else {
        querySnapshot = await _firebaseFirestore
            .collection(collection)
            .doc(document)
            .collection(secondCollection)
            .where(field, isEqualTo: value)
            .get();
      }
      
      if (querySnapshot.docs.isEmpty) {
        dynamic defaultValue;
        if (value is bool) {
          defaultValue = false;
        } else if (value is Map) {
          defaultValue = {};
        } else if (value is List) {
          defaultValue = [];
        } else {
          defaultValue = '';
        }
        return defaultValue;
      }

      var doc = querySnapshot.docs[0];
      if (document != null && secondCollection != null && information == null) {
        return doc[field];
      } else {
        Map<String, dynamic> extractedData = {};
        List dataList = [];

        if (information != null && information.isNotEmpty) {
          final data = doc.data() as Map<String, dynamic>;
          for (var key in information) {
            if (data.containsKey(key)) {
              extractedData[key] = data[key];
            }
          }

          dataList = [
            doc.id,
            extractedData,
          ];

          return dataList;
        } else {
          dataList = [
            doc.id,
            doc.data(),
          ];

          return dataList;
        }
      }
    } catch (e) {
      print("Error fetching information: $e");
      return null;
    }
  }
}
