#!/bin/bash

# Saindo imediatamente se algum comando falhar
set -e

# Instalação do Flutter SDK
echo "Baixando o Flutter SDK..."
git clone https://github.com/flutter/flutter.git -b stable --depth 1

# Adicionando o Flutter ao PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Verificando a versão do Flutter
flutter --version

# Instalando dependências do projeto Flutter
echo "Instalando dependências do Flutter..."
flutter pub get

# Executando a build para a web
echo "Iniciando build para web..."
flutter build web --release

# Verificando se o build foi bem-sucedido
if [ -d "build/web" ]; then
  echo "Build concluído com sucesso!"
else
  echo "Erro: diretório de build 'build/web' não encontrado."
  exit 1
fi
