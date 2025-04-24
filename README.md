
# Documentação do ExplorerApp

## 1. Visão Geral

**ExplorerApp** é um aplicativo mobile desenvolvido em Flutter como parte de um desafio técnico para demonstrar habilidades em desenvolvimento mobile, consumo de APIs REST, gerenciamento de estado, e criação de interfaces responsivas.

O aplicativo consome a [API pública do Rick and Morty](https://rickandmortyapi.com/) para listar carateres, exibir detalhes, e permitir filtros por nome e status, com suporte a paginação infinita, tratamento de erros e uma experiência de usuário moderna.

### Objetivos do Projeto

- Criar um aplicativo funcional com uma UI fluida e visualmente atraente.  
- Implementar uma arquitetura limpa com separação de responsabilidades.  
- Usar **Riverpod** para gerenciar estados assíncronos de forma robusta.  
- Demonstrar boas práticas em Flutter, como animações, responsividade, e tratamento de erros.  
- Preparar o projeto para escalabilidade com planos de cache offline e testes.  

---

## 2. Funcionalidades

### 2.1 Splash Screen

**Descrição:** Tela inicial com ícone animado (`Icons.explore`) e o texto "ExplorerApp" com gradiente branco → verde claro.

**Detalhes:**
- Animações de *fade-in* e escala com duração de 1.5 segundos.
- Transição suave (fade) após 2.5 segundos.
- Tema branco, sombras suaves e detalhes em verde.

---

### 2.2 Listagem de Carateres

**Descrição:** Lista de carateres em cartões modernos com filtros e paginação.

**Detalhes:**

**Filtros:**
- Busca por nome .
- Filtro por status (Vivo, Morto, Desconhecido) em dropdown estilizado.

**Cartões:**
- Exibe imagem arredondada, nome, status (em português) e ícone de favorito interativo.
- Animações de *fade-in* e escala.

**Paginação:**
- Carregamento incremental ao rolar a lista.
- Indicador animado: "Carregando mais carateres..."

**Tratamento de Erros:**
- Cartão estilizado com ícone vermelho, mensagem amigável e botão "Tentar Novamente".

---

### 2.3 Detalhes do Caráter

**Descrição:** Tela com informações detalhadas de um caráter.

**Detalhes:**
- Imagem grande (250x250px), cartão estilizado e favorito animado.
- Campos: nome, status, espécie, gênero e localização (com ícones).
- Animações suaves e textos em português.

---

### 2.4 UI Moderna

**Características:**
- Tema branco com gradiente branco → verde claro.
- Bordas arredondadas, sombras suaves, tipografia clara.
- Animações fluidas em todas as telas.
- AppBar com gradiente e ícone animado.
- Responsividade em dispositivos Android e iOS.

---

## 3. Estrutura do Código

Arquitetura limpa com separação de camadas:

```
lib/
├── data/
│   ├── models/
│   │   └── caracter_model.dart
│   ├── repositories/
│   │   └── caracter_repository.dart
│   └── services/
│       └── api_service.dart
├── presentation/
│   ├── providers/
│   │   └── caracter_provider.dart
│   ├── screens/
│   │   ├── splash_screen.dart
│   │   ├── caracter_list_screen.dart
│   │   └── caracter_detail_screen.dart
│   └── widgets/
│       └── caracter_card.dart
├── main.dart
```

### 3.1 Camada de Dados (`data/`)

- `caracter_model.dart`: Define o modelo de dados com método `fromJson`.
- `api_service.dart`: Integração com API Rick and Morty via Dio.
- `caracter_repository.dart`: Abstrai a lógica de acesso a dados.

### 3.2 Camada de Apresentação (`presentation/`)

- `caracter_provider.dart`: Gerencia estado com `StateNotifierProvider`.
- `splash_screen.dart`: Tela inicial com animação e transição.
- `caracter_list_screen.dart`: Filtros, lista, paginação, erros.
- `caracter_detail_screen.dart`: Tela detalhada do caráter.
- `caracter_card.dart`: Cartão com imagem, nome, status e favorito.

### 3.3 Ponto de Entrada

- `main.dart`: Inicializa o app, configura tema e tela inicial.

---

## 4. Tecnologias Utilizadas

- **Flutter 3.10.x**: Framework UI
- **Riverpod 2.4.9**: Gerenciamento de estado
- **Dio 5.4.0**: HTTP Client
- **API Rick and Morty**: Fonte de dados

---

## 5. Como Instalar e Executar

### 5.1 Pré-requisitos

- Flutter SDK >= 3.0.0  
- Dart (incluso no Flutter)  
- IDE (VS Code ou Android Studio)  
- Emulador ou dispositivo Android/iOS  

### 5.2 Passos

```bash
git clone https://github.com/seniamara/desafio-tecnico-gate.git
cd explorer_app
flutter pub get
```

Adicione a permissão de internet em:

```xml
<!-- android/app/src/main/AndroidManifest.xml -->
<uses-permission android:name="android.permission.INTERNET" />
```

Execute com:

```bash
flutter run
```

### 5.3 Testes

- **Splash**: Animações e transição.
- **Listagem**: Filtros e paginação.
- **Cartões**: Detalhes e favoritos.
- **Erros**: Desconecte a internet.
- **Responsividade**: Teste em vários tamanhos.

**Destaques:**
- `caracter_provider.dart`: Estado com Riverpod
- `caracter_list_screen.dart`: Filtros, paginação, erros
- `splash_screen.dart`: Animação e transição suave

---

## 8. Contato

Para dúvidas ou feedback: seniamraa@gmail.com

Ou abra uma **Issue** no repositório GitHub.

---

Desenvolvido por [Seu Nome] para o desafio técnico, abril de 2025.
