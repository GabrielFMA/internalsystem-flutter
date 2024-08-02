import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:internalsystem/models/register_model.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;

part 'register_store.g.dart';

class RegisterStore = _RegisterStore with _$RegisterStore;

abstract class _RegisterStore with Store {
  static const _url =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyAE8KFKXcg1ATVd6l-G9P7BHKrfXt--QZ8';
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @observable
  RegisterModel? _data;

  @observable
  String _email = '';

  @observable
  String _password = '';

  @action
  void setEmail(String value) => _email = value;

  @action
  void setPassword(String value) => _password = value;

  @action
  Future<void> signUpWithEmailAndPassword(RegisterModel data) async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        body: jsonEncode({
          'email': _email,
          'password': _password,
          'returnSecureToken': true,
        }),
      );
      if (jsonDecode(response.body).containsKey('idToken')) {
        _data = data;
        await registerUserData(jsonDecode(response.body)['localId']);
      }

      print("Novo usuário registrado com sucesso.");
    } catch (e) {
      print("Erro ao registrar usuário: $e");
    }
  }

  @action
  Future<void> registerUserData(String id) async {
    try {
      await _firestore.collection('Users').doc(id).set(_data!.toMap());
      print('Id: $id');
      print('Email: ${_data!.email}');
      print('Cargo: ${_data!.role}');
      print('Acesso web: ${_data!.isAdmin}');
    } catch (e) {
      print("Erro ao registrar dados do usuário: $e");
    }
  }
}
