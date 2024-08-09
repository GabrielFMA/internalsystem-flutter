class ErrorMessages {
  static const Map<String, String> errorMessages = {
    'invalid-email': 'Usuário não encontrado. Por favor, verifique suas credenciais.',
    'invalid-credential': 'Senha incorreta. Tente novamente.',
    'user-without-permission': 'Acesso web não permitido.',
    'network-request-failed': 'Erro de rede. Verifique sua conexão e tente novamente.',
    'email-already-in-use': 'Este email já está em uso. Use um email diferente.',
  };

  static String getErrorMessage(String errorCode) {
    return errorMessages[errorCode] ?? 'Ocorreu um erro desconhecido. Tente novamente.';
  }
}
