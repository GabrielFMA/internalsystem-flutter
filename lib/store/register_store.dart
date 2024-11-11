

// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internalsystem/models/register_model.dart';
import 'package:internalsystem/store/request_store.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStore with _$RegisterStore;

void _log(String message) {
  print("[RegisterStore] $message");
}

abstract class _RegisterStore with Store {
  static const _url =
      'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDn7WXMzqT6kj_PgFC800zLgLsjSjXQpio';

  @action
  Future<void> signUpWithEmailAndPassword(
      RegisterModel data, BuildContext context, Function onSuccess) async {
    try {
      final response = await http.post(
        Uri.parse(_url),
        body: jsonEncode({
          'email': data.email,
          'password': data.password,
          'returnSecureToken': true,
        }),
      );

      if (jsonDecode(response.body).containsKey('idToken')) {
        await zipCodeVerification(data, () async {
          duplicityCheck(data, () async {
            await registerData(
                'users', jsonDecode(response.body)['localId'], data, context, () async {
              _log("Novo usuário registrado com sucesso.");
              onSuccess();
            });
          });
        });
      } else {
        _log("Token de autenticação não encontrado.");
      }
    } catch (e) {
      _log("Erro ao registrar usuário: $e");
    }
  }

  @action
  Future<void> registerData(
    String collection,
    String document,
    RegisterModel data,
    BuildContext context,
    Function onSuccess,
  ) async {
    try {
      final dbRef = FirebaseDatabase.instance.ref();
      final store =
          Provider.of<RequestStore>(context, listen: false);

      await store.fetchData('users', information: ['id']);
      
      if (store.fetchedData != []) {
        final maxId = store.fetchedData
            .map((user) => user['id'] as int)
            .reduce((a, b) => a > b ? a : b);
        data.id = maxId + 1;
      }
      dbRef.child(collection).child(document).set(data.toMap());

      _log("${data.toMap()}");
      onSuccess();
    } catch (e) {
      _log("Erro ao registrar dados do usuário: $e");
    }
  }

  @action
  Future<void> duplicityCheck(RegisterModel data, Function onSuccess) async {
    try {
      final fieldsToCheck = {
        'name': data.name?.toLowerCase(),
        'email': data.email?.toLowerCase(),
        'cpf': data.cpf?.toLowerCase(),
      };

      for (final entry in fieldsToCheck.entries) {
        if (entry.value == null) continue;

        final querySnapshot = await FirebaseFirestore.instance
            .collection('users')
            .where(entry.key, isEqualTo: entry.value)
            .get();

        if (querySnapshot.docs.isNotEmpty) {
          _log('Duplicidade encontrada para o campo ${entry.key}.');
          return;
        }
      }
      onSuccess();
    } catch (e) {
      _log('Erro ao verificar duplicidade: $e');
    }
  }

  @action
  Future<void> zipCodeVerification(
      RegisterModel data, Function onSuccess) async {
    try {
      //Temporario
      if (data.address?['zipCode'] == null ||
          data.address?['zipCode'].isEmpty) {
        _log('Nenhum CEP foi fornecido!');
        onSuccess();
        return;
      }
      //Temporario

      final rsp = await http.get(Uri.parse(
          "https://viacep.com.br/ws/${data.address?['zipCode']}/json/"));

      if (rsp.body.isEmpty) {
        _log('Nenhuma informação foi encontrada!');
        return;
      }

      if (rsp.body.contains('"erro": true')) {
        _log('CEP não encontrado!');
        return;
      }

      final responseData = json.decode(rsp.body);
      data.address = {
        'zipCode': responseData['cep'],
        'street': responseData['logradouro'],
        'district': responseData['bairro'],
        'city': responseData['localidade'],
        'state': responseData['uf'],
      };

      onSuccess();
    } catch (error) {
      _log('Erro ao buscar CEP: $error');
    }
  }
}
