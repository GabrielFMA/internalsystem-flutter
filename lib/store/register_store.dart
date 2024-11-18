// ignore_for_file: library_private_types_in_public_api, avoid_print

import 'dart:convert';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:internalsystem/models/register_model.dart';
import 'package:internalsystem/models/text_error_model.dart';
import 'package:internalsystem/store/request_store.dart';
import 'package:internalsystem/utils/error_messages.dart';
import 'package:mobx/mobx.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

part 'register_store.g.dart';

class RegisterStore = _RegisterStore with _$RegisterStore;

void _log(String message) {
  print("[RegisterStore] $message");
}

abstract class _RegisterStore with Store {
  @action
  Future<void> signUpWithEmailAndPassword(
      RegisterModel data,
      TextErrorModel textError,
      BuildContext context,
      Function onSuccess) async {
    try {
      // Passo 1: Verificação do CEP, Verificação de duplicidade de dados e Geração de ID para o novo usuário
      if (await zipCodeVerification(data, textError) &&
          await duplicityCheck(data, textError) &&
          await verificateId(context, data, textError)) {
        _log(
            "CEP verificado com sucesso, duplicidade verificada com sucesso e Id verificado com sucesso.");

        // Passo 2: Registro no Firebase Authentication
        final response = await http.post(
          Uri.parse(
            'https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyDn7WXMzqT6kj_PgFC800zLgLsjSjXQpio',
          ),
          body: jsonEncode({
            'email': data.email,
            'password': data.password,
            'returnSecureToken': true,
          }),
        );

        // Passo 3: Verificar se existe o token e registro de dados no Firebase Realtime Database
        if (jsonDecode(response.body).containsKey('idToken')) {
          await registerData('users', jsonDecode(response.body)['localId'],
              data, context, textError);

          _log("Novo usuário registrado com sucesso.");
          onSuccess();
        } else {
          _log("Token de autenticação não encontrado.");
          textError.error =
              ErrorMessages.getErrorMessage('email-already-in-use');
        }
      }
    } catch (e) {
      _log("Erro ao registrar usuário: $e");
      textError.error = ErrorMessages.getErrorMessage('unexpected-error',
          params: {'field': e.toString()});
    }
  }

  Future<bool> zipCodeVerification(
      RegisterModel data, TextErrorModel textError) async {
    try {
      // Temporário: verifica se o campo zipCode está vazio
      if (data.address?['zipCode'] == null ||
          data.address?['zipCode'].isEmpty) {
        _log('Nenhum CEP foi fornecido!');
        return true;
      }
      // Temporário: verifica se o campo zipCode está vazio

      final rsp = await http.get(Uri.parse(
          "https://viacep.com.br/ws/${data.address?['zipCode']}/json/"));

      if (rsp.body.isEmpty || rsp.body.contains('"erro": true')) {
        _log('CEP não encontrado!');
        textError.error = ErrorMessages.getErrorMessage('cep-not-found');
        return false;
      }

      final responseData = json.decode(rsp.body);
      data.address = {
        'zipCode': responseData['cep'],
        'street': responseData['logradouro'],
        'district': responseData['bairro'],
        'city': responseData['localidade'],
        'state': responseData['uf'],
      };

      return true;
    } catch (e) {
      _log('Erro ao buscar CEP: $e');
      textError.error = ErrorMessages.getErrorMessage('unexpected-error',
          params: {'field': e.toString()});
      return false;
    }
  }

  Future<bool> duplicityCheck(
      RegisterModel data, TextErrorModel textError) async {
    try {
      final fieldsToCheck = {
        'name': data.name?.toLowerCase(),
        'cpf': data.cpf,
      };

      for (final entry in fieldsToCheck.entries) {
        if (entry.value == null) continue;

        final snapshot = await FirebaseDatabase.instance
            .ref()
            .child('users')
            .orderByChild(entry.key)
            .equalTo(entry.value)
            .get();

        if (snapshot.exists) {
          _log('Duplicidade encontrada para o campo ${entry.key}.');
          textError.error = ErrorMessages.getErrorMessage('field-duplicate',
              params: {'field': entry.key});
          return false;
        }
      }

      return true;
    } catch (e) {
      _log('Erro ao verificar duplicidade: $e');
      textError.error = ErrorMessages.getErrorMessage('unexpected-error',
          params: {'field': e.toString()});
      return false;
    }
  }

  Future<bool> verificateId(BuildContext context, RegisterModel data,
      TextErrorModel textError) async {
    try {
      final store = Provider.of<RequestStore>(context, listen: false);
      await store.fetchData('users', information: ['id']);

      if (store.fetchedData.isNotEmpty) {
        final maxId = store.fetchedData
            .map((user) => user['id'] as int)
            .reduce((a, b) => a > b ? a : b);
        data.id = maxId + 1;
      }

      return true;
    } catch (e) {
      _log("Erro em gerar o próximo Id: $e");
      textError.error = ErrorMessages.getErrorMessage('unexpected-error',
          params: {'field': e.toString()});
      return false;
    }
  }

  Future<void> registerData(
    String collection,
    String document,
    dynamic data,
    BuildContext context,
    TextErrorModel textError,
  ) async {
    try {
      final dbRef = FirebaseDatabase.instance.ref();
      final dataMap = data is RegisterModel ? data.toMap() : data;

      await dbRef.child(collection).child(document).set(dataMap);
      _log("$dataMap");
    } catch (e) {
      _log("Erro ao registrar dados do usuário: $e");
    }
  }
}
