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
      RegisterModel data, BuildContext context, Function onSuccess) {
    return _$signUpWithEmailAndPasswordAsyncAction
        .run(() => super.signUpWithEmailAndPassword(data, context, onSuccess));
  }

  late final _$registerDataAsyncAction =
      AsyncAction('_RegisterStore.registerData', context: context);

  @override
  Future<void> registerData(String collection, String document, dynamic data,
      BuildContext context, Function onSuccess) {
    return _$registerDataAsyncAction.run(() =>
        super.registerData(collection, document, data, context, onSuccess));
  }

  late final _$duplicityCheckAsyncAction =
      AsyncAction('_RegisterStore.duplicityCheck', context: context);

  @override
  Future<void> duplicityCheck(RegisterModel data, Function onSuccess) {
    return _$duplicityCheckAsyncAction
        .run(() => super.duplicityCheck(data, onSuccess));
  }

  late final _$zipCodeVerificationAsyncAction =
      AsyncAction('_RegisterStore.zipCodeVerification', context: context);

  @override
  Future<void> zipCodeVerification(RegisterModel data, Function onSuccess) {
    return _$zipCodeVerificationAsyncAction
        .run(() => super.zipCodeVerification(data, onSuccess));
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
