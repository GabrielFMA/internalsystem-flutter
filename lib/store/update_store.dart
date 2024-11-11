// ignore_for_file: library_private_types_in_public_api

import 'package:firebase_database/firebase_database.dart';
import 'package:internalsystem/models/update_model.dart';
import 'package:mobx/mobx.dart';

part 'update_store.g.dart';

class UpdateStore = _UpdateStore with _$UpdateStore;

abstract class _UpdateStore with Store {
  Future<void> updatedData(
      String collection, String document, UpdateModel data) async {
    await FirebaseDatabase.instance
        .ref()
        .child(collection)
        .child(document)
        .update(data.toMap());
  }
}
