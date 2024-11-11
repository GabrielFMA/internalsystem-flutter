// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:mobx/mobx.dart';

part 'request_store.g.dart';

class RequestStore = _RequestStore with _$RequestStore;

abstract class _RequestStore with Store {
  @observable
  ObservableList<Map<String, dynamic>> fetchedData =
      ObservableList<Map<String, dynamic>>();

  void _log(String message) {
    print("[RequestStore] $message");
  }

  Future<void> fetchData(
    String collection, {
    String? document,
    List<String>? information,
  }) async {
    try {
      final snapshot =
          await FirebaseDatabase.instance.ref().child(collection).get();

      fetchedData.clear();

      if (snapshot.exists) {
        final data = Map<String, dynamic>.from(snapshot.value as Map);

        for (var docKey in data.keys) {
          Map<String, dynamic> extractedData = {};

          extractedData['uid'] = docKey;

          if (information != null) {
            for (var key in information) {
              if (data[docKey] != null && data[docKey].containsKey(key)) {
                extractedData[key] = data[docKey][key];
              }
            }
          } else {
            final documentData = Map<String, dynamic>.from(data[docKey]);
            extractedData.addAll(documentData);
          }

          fetchedData.add(extractedData);
        }
      }
    } catch (e) {
      _log("Erro ao recuperar a coleção: $e");
    }
  }
}
