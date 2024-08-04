// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterStore on _RegisterStore, Store {
  late final _$signUpWithEmailAndPasswordAsyncAction = AsyncAction(
      '_RegisterStore.signUpWithEmailAndPassword',
      context: context);

  @override
  Future<void> signUpWithEmailAndPassword(
      RegisterModel data, Function onSuccess) {
    return _$signUpWithEmailAndPasswordAsyncAction
        .run(() => super.signUpWithEmailAndPassword(data, onSuccess));
  }

  late final _$registerUserDataAsyncAction =
      AsyncAction('_RegisterStore.registerUserData', context: context);

  @override
  Future<void> registerUserData(
      String collection, String document, RegisterModel data) {
    return _$registerUserDataAsyncAction
        .run(() => super.registerUserData(collection, document, data));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
