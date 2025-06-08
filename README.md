# Painel de Ativos Digitais

Um aplicativo Flutter que consome a API do CoinMarketCap para exibir informações sobre ativos digitais em tempo real. O projeto segue os princípios da Clean Architecture e utiliza Provider para gerenciamento de estado.

## 📋 Pré-requisitos

Antes de começar, certifique-se de ter instalado:

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (versão 3.0 ou superior)
- [Dart SDK](https://dart.dev/get-dart) (incluído com Flutter)
- Um navegador web (Chrome recomendado)
- Editor de código (VS Code, Android Studio, ou similar)

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

### 3. Execute o projeto

**IMPORTANTE:** Para executar este projeto no navegador, você deve usar o comando específico abaixo(para evitar problemas com cors ):

```bash
flutter run -d chrome --web-browser-flag "--disable-web-security"
```

#### Por que usar `--disable-web-security`?

Este projeto consome a API do CoinMarketCap diretamente do navegador. Por questões de segurança, os navegadores implementam uma política chamada **CORS (Cross-Origin Resource Sharing)** que bloqueia requisições entre diferentes domínios.

Como a API do CoinMarketCap não possui configuração CORS adequada para aplicações web client-side, precisamos desabilitar temporariamente essa verificação no Chrome durante o desenvolvimento.


### 4. Comandos alternativos

Se você quiser executar em outros dispositivos:

```bash
# Para Android (com dispositivo conectado)
flutter run -d android

# Para iOS (apenas no macOS)
flutter run -d ios

# Para Windows desktop
flutter run -d windows
```

## Estrutura do Projeto

O projeto segue a Clean Architecture com a seguinte estrutura:

```
lib/
├── configs/
│   └── network_settings.dart       # Configurações de rede
├── core/
│   ├── library/
│   │   └── app_defaults.dart        # Padrões da aplicação
│   └── service/
│       └── network_client.dart      # Cliente de rede
├── data/
│   ├── datasources/
│   │   └── digital_asset_remote_source.dart  # Fonte de dados remota
│   └── repositories/
│       └── digital_asset_repository.dart     # Implementação do repositório
├── domain/
│   ├── entities/
│   │   └── digital_asset_model.dart          # Modelos de domínio
│   └── repositories/
│       └── i_digital_asset_repository.dart   # Interface do repositório
├── ui/
│   ├── pages/
│   │   └── asset_dashboard_screen.dart       # Tela principal
│   └── view_models/
│       └── digital_asset_controller.dart     # Controlador
└── main.dart                                 # Ponto de entrada
```

## Funcionalidades

- ✅ Painel de ativos digitais em tempo real
- ✅ Exibição de preços em USD e BRL
- ✅ Filtro por nome ou símbolo do ativo
- ✅ Pull-to-refresh para atualizar dados
- ✅ Dialog com detalhes do ativo digital
- ✅ Tratamento de erros e estados de carregamento
- ✅ Interface responsiva e moderna com layout em grade

## 🔑 Configuração da API

### Obtendo sua própria chave da API

**IMPORTANTE:** Este projeto inclui uma chave de API de demonstração que pode ter limitações. Para uso completo, você deve obter sua própria chave:

1. **Acesse o site do CoinMarketCap:**
   - Vá para [https://coinmarketcap.com/api/](https://coinmarketcap.com/api/)
   - Clique em "Get Your API Key Now"

2. **Crie uma conta gratuita:**
   - Faça o cadastro com seu email
   - Confirme sua conta
   - Acesse o dashboard da API

3. **Copie sua chave da API:**
   - No dashboard, você verá sua API Key
   - Copie a chave (formato: `xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx`)

### Configurando sua chave no projeto

**Substitua a chave padrão pela sua própria chave:**

1. Abra o arquivo `lib/configs/network_settings.dart`
2. Localize a linha:
   ```dart
   static const String authToken = '31322d00-32f2-4a36-9749-f8133b5661a2';
   ```
3. Substitua pela sua chave:
   ```dart
   static const String authToken = 'SUA_CHAVE_AQUI';
   ```

### Planos disponíveis

- **Basic (Gratuito):** 333 chamadas/dia, dados básicos
- **Hobbyist ($29/mês):** 3.333 chamadas/dia, mais endpoints
- **Startup ($79/mês):** 10.000 chamadas/dia, dados históricos
- **Standard ($249/mês):** 33.333 chamadas/dia, suporte prioritário

**Nota:** Para uso em produção, recomenda-se:
1. Mover a chave da API para variáveis de ambiente
2. Implementar um backend intermediário
3. Nunca expor chaves de API no código client-side
4. Usar um plano pago adequado ao volume de uso



## 🐛 Solução de Problemas

### Erro: "ClientException: Failed to fetch"

Este erro indica problema com CORS. Certifique-se de estar usando o comando correto:

```bash
flutter run -d chrome --web-browser-flag "--disable-web-security"
```

### Erro: "No device found"

Verifique se o Chrome está instalado e execute:

```bash
flutter devices
```

### Problemas com dependências

Limpe o cache e reinstale:

```bash
flutter clean
flutter pub get
```

## 🛠️ Tecnologias Utilizadas

- **Flutter** - Framework de desenvolvimento
- **Provider** - Gerenciamento de estado
- **HTTP** - Requisições de rede
- **Intl** - Formatação de números e datas
- **CoinMarketCap API** - Dados de criptomoedas