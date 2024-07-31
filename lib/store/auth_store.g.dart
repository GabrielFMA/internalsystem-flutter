// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$AuthStore on _AuthStore, Store {
  late final _$userAtom = Atom(name: '_AuthStore.user', context: context);

  @override
  get user {
    _$userAtom.reportRead();
    return super.user;
  }

  @override
  set user(value) {
    _$userAtom.reportWrite(value, super.user, () {
      super.user = value;
    });
  }

  late final _$emailAtom = Atom(name: '_AuthStore.email', context: context);

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  late final _$passwordAtom =
      Atom(name: '_AuthStore.password', context: context);

  @override
  String get password {
    _$passwordAtom.reportRead();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.reportWrite(value, super.password, () {
      super.password = value;
    });
  }

  late final _$loginWithEmailAndPasswordAsyncAction =
      AsyncAction('_AuthStore.loginWithEmailAndPassword', context: context);

  @override
  Future<void> loginWithEmailAndPassword() {
    return _$loginWithEmailAndPasswordAsyncAction
        .run(() => super.loginWithEmailAndPassword());
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
user: ${user},
email: ${email},
password: ${password}
    ''';
  }
}
