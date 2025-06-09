# 💰 Painel de Ativos Digitais

Aplicativo Flutter que consome a API do CoinMarketCap para exibir informações em tempo real sobre criptomoedas. O projeto adota os princípios da **Clean Architecture** e utiliza **Provider** para o gerenciamento de estado.

---

## 📦 Pré-requisitos

Antes de começar, certifique-se de que os seguintes itens estejam instalados:

* [Flutter SDK 3.0+](https://flutter.dev/docs/get-started/install)
* Dart SDK (incluso no Flutter)
* Navegador (Google Chrome recomendado)
* Editor de código como VS Code ou Android Studio

---

## 🚀 Como configurar e executar o projeto

### 1. Clone o repositório

```bash
git clone <url-do-repositorio>
cd api_market_cap_coin
```

### 2. Instale as dependências

```bash
flutter pub get
```

### 3. Execute no navegador (modo desenvolvimento)

Devido a restrições de CORS, é necessário desabilitar a segurança do navegador durante o desenvolvimento:

```bash
flutter run -d chrome --web-browser-flag "--disable-web-security"
```

> ⚠️ **Atenção:** Este comando deve ser utilizado apenas em ambiente de desenvolvimento.

### 4. Executar em outros dispositivos (opcional)

```bash
# Android (dispositivo físico ou emulador)
flutter run -d android

# iOS (apenas no macOS)
flutter run -d ios

# Windows
flutter run -d windows
```

---

## 🗂️ Estrutura do Projeto

O projeto é organizado com base na Clean Architecture:

```
lib/
├── configs/                          # Configurações gerais
│   └── network_settings.dart
├── core/                             # Componentes reutilizáveis
│   ├── library/
│   │   └── app_defaults.dart
│   └── service/
│       └── network_client.dart
├── data/                             # Camada de dados
│   ├── datasources/
│   │   └── digital_asset_remote_source.dart
│   └── repositories/
│       └── digital_asset_repository.dart
├── domain/                           # Regras de negócio
│   ├── entities/
│   │   └── digital_asset_model.dart
│   └── repositories/
│       └── i_digital_asset_repository.dart
├── ui/                               # Interface do usuário
│   ├── pages/
│   │   └── asset_dashboard_screen.dart
│   └── view_models/
│       └── digital_asset_controller.dart
└── main.dart                         # Entrada da aplicação
```

---

## ✨ Funcionalidades

* ✅ Painel com cotações em tempo real
* ✅ Exibição em USD e BRL
* ✅ Filtro por nome ou símbolo
* ✅ Atualização via pull-to-refresh
* ✅ Diálogo com informações detalhadas
* ✅ Tratamento de erros e loading states
* ✅ Layout responsivo e moderno em grid

---

## 🔑 Configuração da API CoinMarketCap

### 1. Obtenha sua chave de API

1. Acesse: [https://coinmarketcap.com/api/](https://coinmarketcap.com/api/)
2. Crie uma conta gratuita
3. Acesse o dashboard e copie sua chave (formato: `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`)

### 2. Configure no projeto

No arquivo `lib/configs/network_settings.dart`, substitua:

```dart
static const String authToken = '31322d00-32f2-4a36-9749-f8133b5661a2';
```

Por:

```dart
static const String authToken = 'SUA_CHAVE_AQUI';
```

> ⚠️ **Dica de segurança:** Para produção, armazene a chave de API em variáveis de ambiente ou utilize um backend intermediário. **Nunca exponha sua chave em apps client-side.**

### Planos da API

| Plano    | Chamadas/dia | Recursos            |
| -------- | ------------ | ------------------- |
| Free     | 333          | Dados básicos       |
| Hobbyist | 3.333        | Mais endpoints      |
| Startup  | 10.000       | Dados históricos    |
| Standard | 33.333       | Suporte prioritário |

---

## 🐞 Solução de Problemas

### Erro: `ClientException: Failed to fetch`

Esse erro ocorre por CORS. Use o comando com `--disable-web-security`.

### Erro: `No device found`

Certifique-se de que o Chrome está instalado e execute:

```bash
flutter devices
```

### Problemas com pacotes

Execute:

```bash
flutter clean
flutter pub get
```

---

## 🛠️ Tecnologias Utilizadas

* **Flutter** – Framework principal
* **Dart** – Linguagem de programação
* **Provider** – Gerenciamento de estado
* **HTTP** – Comunicação com APIs
* **Intl** – Formatação de valores
* **CoinMarketCap API** – Fonte dos dados de criptomoedas

---

## 📌 Considerações Finais

Este projeto é ideal para estudos e prototipagem. Para uso em produção, considere:

* Utilizar uma chave de API privada e segura
* Criar um backend intermediário
* Evitar o uso de `--disable-web-security` em produção
* Escolher um plano da API adequado ao seu volume
