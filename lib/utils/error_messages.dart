class ErrorMessages {
  static const Map<String, String> errorMessages = {
    'invalid-email': 'Email inválido. Tente novamente.',
    'invalid-credential': 'Email ou senha incorretos. Tente novamente.',
    'user-without-permission': 'Acesso web não permitido.',
    'network-request-failed': 'Erro de rede. Verifique sua conexão e tente novamente.',
    'email-already-in-use': 'Este email já está em uso. Use um email diferente.',
  };

  static String getErrorMessage(String errorCode) {
    return errorMessages[errorCode] ?? 'Ocorreu um erro desconhecido. Tente novamente.';
  }
}
