// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  late final _$_userAtom = Atom(name: '_AuthStore._user', context: context);

  @override
  AuthModel? get _user {
    _$_userAtom.reportRead();
    return super._user;
  }

  @override
  set _user(AuthModel? value) {
    _$_userAtom.reportWrite(value, super._user, () {
      super._user = value;
    });
  }

  late final _$_emailAtom = Atom(name: '_AuthStore._email', context: context);

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
      Atom(name: '_AuthStore._password', context: context);

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

  late final _$loginWithEmailAndPasswordAsyncAction =
      AsyncAction('_AuthStore.loginWithEmailAndPassword', context: context);

  @override
  Future<void> loginWithEmailAndPassword(
      TextErrorModel textError, BuildContext context, Function onSuccess) {
    return _$loginWithEmailAndPasswordAsyncAction.run(
        () => super.loginWithEmailAndPassword(textError, context, onSuccess));
  }

  late final _$logoutAsyncAction =
      AsyncAction('_AuthStore.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  late final _$_AuthStoreActionController =
      ActionController(name: '_AuthStore', context: context);

  @override
  void setEmail(String value) {
    final _$actionInfo =
        _$_AuthStoreActionController.startAction(name: '_AuthStore.setEmail');
    try {
      return super.setEmail(value);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPassword(String value) {
    final _$actionInfo = _$_AuthStoreActionController.startAction(
        name: '_AuthStore.setPassword');
    try {
      return super.setPassword(value);
    } finally {
      _$_AuthStoreActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
