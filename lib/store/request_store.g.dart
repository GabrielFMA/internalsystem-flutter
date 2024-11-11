// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'request_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RequestStore on _RequestStore, Store {
  late final _$fetchedDataAtom =
      Atom(name: '_RequestStore.fetchedData', context: context);

  @override
  ObservableList<Map<String, dynamic>> get fetchedData {
    _$fetchedDataAtom.reportRead();
    return super.fetchedData;
  }

  @override
  set fetchedData(ObservableList<Map<String, dynamic>> value) {
    _$fetchedDataAtom.reportWrite(value, super.fetchedData, () {
      super.fetchedData = value;
    });
  }

  @override
  String toString() {
    return '''
fetchedData: ${fetchedData}
    ''';
  }
}
