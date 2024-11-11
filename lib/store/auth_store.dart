// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internalsystem/models/text_error_model.dart';
import 'package:internalsystem/utils/error_messages.dart';
import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/auth_model.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  @observable
  AuthModel? _user;

  void _log(String message) {
    print("[AuthStore] $message");
  }

  AuthModel? get getUser => _user;

  @action
  Future<void> loginWithEmailAndPassword(AuthModel data, TextErrorModel textError,
      BuildContext context, Function onSuccess) async {
    try {
      if (data.email == null || data.password == null) return;

      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: data.email!,
        password: data.password!,
      );

      if (await checkWebAccountAccess(userCredential.user?.uid, context)) {
        _log('Usuário: ${userCredential.user?.uid}');
        print(_user?.name);
        print(_user?.email);
        onSuccess();
      } else {
        logout();
        textError.error =
            ErrorMessages.getErrorMessage('user-without-permission');
      }
    } on FirebaseAuthException catch (e) {
      _log(e.code);
      textError.error = ErrorMessages.getErrorMessage(e.code);
    } catch (e) {
      textError.error = 'Ocorreu um erro inesperado: ${e.toString()}';
    }
  }

  Future<bool> checkWebAccountAccess(
    String? uid,
    BuildContext context,
  ) async {
    if (uid == null) return false;

    try {
      final snapshot = await FirebaseDatabase.instance
          .ref()
          .child('users')
          .child(uid)
          .get();
      if (!snapshot.exists) return false;

      final data = snapshot.value as Map<dynamic, dynamic>;

      if (!data['permissions']['isAdmin']) return false;

      _user = AuthModel(
        id: uid,
        name: data['name'] ?? 'Nome não disponível',
        email: data['email'] ?? 'Email não disponível',
        permissions: data['permissions'],
      );

      return true;
    } catch (e) {
      _log('Erro ao acessar o Firestore: $e');
    }

    return false;
  }

  @action
  Future<void> logout() async {
    try {
      await FirebaseAuth.instance.signOut();
      _user = null;
    } catch (e) {
      _log('Error logging out: $e');
    }
  }
}
