#!/bin/bash

# Instalação do Flutter SDK
echo "Baixando o Flutter SDK..."
git clone https://github.com/flutter/flutter.git -b stable --depth 1

# Adicionando o Flutter ao PATH
export PATH="$PATH:`pwd`/flutter/bin"

# Verificando a versão do Flutter
flutter --version

# Instalando dependências do projeto Flutter
flutter pub get

# Executando a build para a web
flutter build web --release

# Saída de build para o diretório certo
echo "Movendo build para a pasta de publicação..."
mv build/web/* $BUILD_DIR