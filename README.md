# 🌵 Meu Cacto (My Cactus)

![Flutter](https://img.shields.io/badge/Flutter-%2302569B.svg?style=for-the-badge&logo=Flutter&logoColor=white)
![Dart](https://img.shields.io/badge/dart-%230175C2.svg?style=for-the-badge&logo=dart&logoColor=white)
![Android](https://img.shields.io/badge/Android-3DDC84?style=for-the-badge&logo=android&logoColor=white)

**Meu Cacto** é um aplicativo móvel desenvolvido em Flutter para ajudar amantes de plantas a gerenciar e cuidar de seus cactos e suculentas. Com uma interface amigável e notificações inteligentes, você nunca mais esquecerá de regar suas plantas!

---

## 📱 Download do App

Experimente a versão mais recente do aplicativo agora mesmo!

[<img src="https://img.shields.io/badge/Download-APK-success?style=for-the-badge&logo=android" height="40">](https://github.com/felipegatoloko10/My_Cactus/raw/main/releases/app-release.apk)

**[Clique aqui para baixar o APK (app-release.apk)](https://github.com/felipegatoloko10/My_Cactus/raw/main/releases/app-release.apk)**

> **Nota:** Para instalar, você pode precisar habilitar a instalação de fontes desconhecidas nas configurações do seu dispositivo Android.

---

## ✨ Funcionalidades

* **🌱 Gerenciamento de Plantas:** Adicione, edite e remova seus cactos e plantas da coleção.
* **💧 Lembretes de Rega:** Receba notificações locais para lembrar de regar cada planta individualmente.
* **📅 Histórico:** Acompanhe a última vez que você regou suas plantas.
* **📷 Fotos Personalizadas:** Adicione fotos das suas próprias plantas ou use ícones padrão.
* **🌐 Suporte a Idiomas:** Disponível em Português e Inglês (Internacionalização).
* **💎 Modelo Freemium:** Gerencie até 5 plantas gratuitamente ou desbloqueie a versão Premium (simulação) para plantas ilimitadas.

---

## 🛠️ Tecnologias Utilizadas

Este projeto foi construído utilizando as melhores práticas e bibliotecas do ecossistema Flutter:

* **[Flutter](https://flutter.dev/):** Framework UI do Google para criar aplicativos nativos compilados.
* **[Provider](https://pub.dev/packages/provider):** Gerenciamento de estado eficiente e reativo.
* **[SQFlite](https://pub.dev/packages/sqflite):** Persistência de dados local (banco de dados SQLite).
* **[Flutter Local Notifications](https://pub.dev/packages/flutter_local_notifications):** Agendamento e exibição de notificações locais.
* **[Image Picker](https://pub.dev/packages/image_picker):** Captura e seleção de imagens da galeria ou câmera.
* **[Intl](https://pub.dev/packages/intl):** Internacionalização e formatação de datas.

---

## 🚀 Como Rodar o Projeto Localmente

Se você é um desenvolvedor e deseja contribuir ou testar o código:

### Pré-requisitos

* [Flutter SDK](https://flutter.dev/docs/get-started/install) instalado.
* Dispositivo Android ou Emulador configurado.

### Passos

1. **Clone o repositório:**

    ```bash
    git clone https://github.com/felipegatoloko10/My_Cactus.git
    cd My_Cactus
    ```

2. **Instale as dependências:**

    ```bash
    flutter pub get
    ```

3. **Gere os arquivos de tradução (se necessário):**

    ```bash
    flutter gen-l10n
    ```

4. **Execute o aplicativo:**

    ```bash
    flutter run
    ```

---

## 📂 Estrutura do Projeto

```
lib/
├── l10n/          # Arquivos de tradução (.arb)
├── models/        # Modelos de dados (ex: Plant.dart)
├── providers/     # Gerenciamento de estado (ex: PlantProvider.dart)
├── screens/       # Telas do aplicativo (ex: HomeScreen.dart)
├── utils/         # Utilitários e Banco de Dados (ex: DatabaseHelper.dart)
├── widgets/       # Componentes de UI reutilizáveis
└── main.dart      # Ponto de entrada da aplicação
```

---

## 👨‍💻 Autor

Desenvolido por **[Felipe](https://github.com/felipegatoloko10)**.

---
