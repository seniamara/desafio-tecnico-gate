
Sobre o Projeto
O ExplorerApp é um aplicativo Flutter que lista personagens da API do Rick and Morty. Ele permite buscar por nome ou status, ver detalhes de cada personagem, e marcar favoritos. A interface é moderna, com uma Splash Screen animada, cartões estilizados, gradientes verdes, e animações suaves, tudo em português.
Como Instalar no Dispositivo

Pré-requisitos:

Instale o Flutter SDK (versão 3.0.0 ou superior).
Configure um editor (VS Code ou Android Studio) com plugins Flutter/Dart.
Tenha um emulador ou dispositivo físico (Android/iOS).


Clone o Projeto:
git clone https://github.com/seniamara/desafio-tecnico-gate.git
cd explorer_app


Instale Dependências:

Verifique o pubspec.yaml:dependencies:
  flutter:
    sdk: flutter
  dio: ^5.4.0
  flutter_riverpod: ^2.4.9


Execute:flutter pub get




Configure o Android (se necessário):

Adicione a permissão de internet em android/app/src/main/AndroidManifest.xml:<uses-permission android:name="android.permission.INTERNET" />




Execute o App:

Conecte um dispositivo ou inicie um emulador.
Rode:flutter run


A Splash Screen aparecerá, seguida da lista de personagens.



Estrutura: Projeto Flutter com pastas organizadas e dependências (dio, flutter_riverpod).
API: Consumo da API do Rick and Morty com modelo CharacterModel.
Estado: Gerenciamento com Riverpod para lista, filtros, e erros.
Telas:
Splash Screen com ícone animado e texto "ExplorerApp".
Lista de personagens com filtros (nome/status), cartões animados, e paginação.
Cartões com imagem arredondada, status em português, e ícone de favorito.
Tela de detalhes com imagem grande, informações, e favorito animado.


Notas
O app foi feito para o desafio técnico, com foco em uma UI moderna e fluida. A Splash Screen e os cartões estilizados são destaques para a apresentação.


Contato
Para dúvidas ou feedback, entre em contato com seniamaraa@gmail.com ou abra uma issue no repositório.

Desenvolvido por Senimara BEnedito para o desafio técnico.
