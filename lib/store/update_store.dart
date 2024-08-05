import 'package:mobx/mobx.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'update_store.g.dart';

class UpdateStore = _UpdateStore with _$UpdateStore;

abstract class _UpdateStore with Store {

  Future<void> updatedPrimaryData(String collection, String document, String field, value) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(document)
        .update({field: value});
  }

  Future<void> updatedSecondaryData(String collection, String secondCollection, String document, String secondDocument, String field, value) async {
    await FirebaseFirestore.instance
        .collection(collection)
        .doc(document)
        .collection(secondCollection)
        .doc(secondDocument)
        .update({field: value});
  }
}
