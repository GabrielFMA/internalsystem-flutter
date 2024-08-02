// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'register_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$RegisterStore on _RegisterStore, Store {
  late final _$_dataAtom = Atom(name: '_RegisterStore._data', context: context);

  @override
  RegisterModel? get _data {
    _$_dataAtom.reportRead();
    return super._data;
  }

  @override
  set _data(RegisterModel? value) {
    _$_dataAtom.reportWrite(value, super._data, () {
      super._data = value;
    });
  }

  late final _$_emailAtom =
      Atom(name: '_RegisterStore._email', context: context);

  @override
  String get _email {
    _$_emailAtom.reportRead();
    return super._email;
  }

  @override
  set _email(String value) {
    _$_emailAtom.reportWrite(value, super._email, () {
      super._email = value;
    });
  }

  late final _$_passwordAtom =
      Atom(name: '_RegisterStore._password', context: context);

  @override
  String get _password {
    _$_passwordAtom.reportRead();
    return super._password;
  }

  @override
  set _password(String value) {
    _$_passwordAtom.reportWrite(value, super._password, () {
      super._password = value;
    });
  }

  late final _$signUpWithEmailAndPasswordAsyncAction = AsyncAction(
      '_RegisterStore.signUpWithEmailAndPassword',
      context: context);

  @override
  Future<void> signUpWithEmailAndPassword(dynamic data) {
    return _$signUpWithEmailAndPasswordAsyncAction
        .run(() => super.signUpWithEmailAndPassword(data));
  }

  late final _$registerUserDataAsyncAction =
      AsyncAction('_RegisterStore.registerUserData', context: context);

  @override
  Future<void> registerUserData(String id) {
    return _$registerUserDataAsyncAction.run(() => super.registerUserData(id));
  }

  late final _$_RegisterStoreActionController =
      ActionController(name: '_RegisterStore', context: context);

  @override
  void setEmail(String value) {
    final _$actionInfo = _$_RegisterStoreActionController.startAction(
        name: '_RegisterStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_RegisterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_RegisterStoreActionController.startAction(
        name: '_RegisterStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_RegisterStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
