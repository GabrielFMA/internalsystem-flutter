// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'package:flutter/material.dart';
import 'package:internalsystem/models/text_error_model.dart';
import 'package:internalsystem/stores/request_store.dart';
import 'package:internalsystem/utils/error_messages.dart';
import 'package:mobx/mobx.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import '../models/auth_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'auth_store.g.dart';

class AuthStore = _AuthStore with _$AuthStore;

abstract class _AuthStore with Store {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @observable
  AuthModel? _user;

  @observable
  String _email = '';

  @observable
  String _password = '';

  @action
  void setEmail(String value) => _email = value;

  @action
  void setPassword(String value) => _password = value;

  AuthModel? get getUser => _user;

  @action
  Future<void> loginWithEmailAndPassword(TextErrorModel textError,
      BuildContext context, Function onSuccess) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      if (await checkWebAccountAccess(userCredential.user?.uid, context)) {
        print('Usuario: ${userCredential.user?.uid}');
        print(_user?.name);
        print(_user?.email);
        onSuccess();
      } else {
        logout();
        textError.error =
            ErrorMessages.getErrorMessage('user-without-permission');
      }
    } on FirebaseAuthException catch (e) {
      print(e.code);
      textError.error = ErrorMessages.getErrorMessage(e.code);
    } catch (e) {
      textError.error = 'Ocorreu um erro inesperado: ${e.toString()}';
    }
  }

  Future<bool> checkWebAccountAccess(
    String? document,
    BuildContext context,
  ) async {
    if (document == null) return false;

    try {
      final List<Map> permissions =
          await Provider.of<RequestStore>(context, listen: false).fetchData(
        'users',
        document: document,
        secondCollection: 'permissions',
      );

      final documentSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(document)
          .get();

      if (permissions.isEmpty ||
          !(permissions[0]['data']['isAdmin'] ?? false) ||
          !documentSnapshot.exists) {
        return false;
      }

      final data = documentSnapshot.data();
      if (data != null) {
        _user = AuthModel(
          id: document,
          name: data['name'] ?? 'Nome não disponível',
          email: data['email'] ?? 'Email não disponível',
          permissions: permissions[0]['data'],
        );
        return true;
      }
    } catch (e) {
      print('Erro ao acessar o Firestore: $e');
    }

    return false;
  }

  @action
  Future<void> logout() async {
    try {
      await _firebaseAuth.signOut();
      _user = null;
    } catch (e) {
      print('Error logging out: $e');
    }
  }
}
