import 'package:flutter/material.dart';
import 'package:internalsystem/models/text_error_model.dart';

class ErrorMessages {
  static const Map<String, String> errorMessages = {
    'invalid-email': 'Email inválido. Tente novamente.',
    'invalid-credential': 'Email ou senha incorretos. Tente novamente.',
    'user-without-permission': 'Acesso web não permitido.',
    'network-request-failed':
        'Erro de rede. Verifique sua conexão e tente novamente.',
    'email-already-in-use':
        'Este email já está em uso. Use um email diferente.',
    'cep-not-found':
        'CEP não encontrado. Verifique o número do CEP e tente novamente.',
    'field-duplicate':
        'Duplicidade encontrada para o campo {field}. Tente novamente.',
    'unexpected-error': 'Ocorreu um erro inesperado: {field}',
  };

  static String getErrorMessage(String errorCode,
      {Map<String, String>? params}) {
    String message = errorMessages[errorCode] ??
        'Ocorreu um erro desconhecido. Tente novamente.';

    if (params != null && params.isNotEmpty) {
      params.forEach((key, value) {
        message = message.replaceAll('{$key}', value);
      });
    }

    return message;
  }
}

Widget customLoadingOrErrorWidget(
    {required bool isLoading, required TextErrorModel textError}) {
  return SizedBox(
    height: 40,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        isLoading
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : Text(
                textError.error,
                style: const TextStyle(color: Colors.red),
              ),
      ],
    ),
  );
}
