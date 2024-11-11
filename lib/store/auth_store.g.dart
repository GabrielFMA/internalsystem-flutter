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

  late final _$loginWithEmailAndPasswordAsyncAction =
      AsyncAction('_AuthStore.loginWithEmailAndPassword', context: context);

  @override
  Future<void> loginWithEmailAndPassword(AuthModel data,
      TextErrorModel textError, BuildContext context, Function onSuccess) {
    return _$loginWithEmailAndPasswordAsyncAction.run(() =>
        super.loginWithEmailAndPassword(data, textError, context, onSuccess));
  }

  late final _$logoutAsyncAction =
      AsyncAction('_AuthStore.logout', context: context);

  @override
  Future<void> logout() {
    return _$logoutAsyncAction.run(() => super.logout());
  }

  @override
  String toString() {
    return '''

    ''';
  }
}
