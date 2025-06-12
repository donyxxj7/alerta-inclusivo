# 🚨 Alerta Inclusivo

![Versão](https://img.shields.io/badge/versão-1.0.0-blue) ![Status](https://img.shields.io/badge/status-MVP%20Completo-success)

Um aplicativo de emergência desenvolvido em Flutter, projetado para auxiliar a comunicação de pessoas com deficiência auditiva e dificuldades de fala em momentos críticos.

## 🎯 Conceito do Projeto

O Alerta Inclusivo nasceu da necessidade de criar um canal de comunicação rápido e eficaz para pessoas que podem ter dificuldade em usar uma linha telefônica de emergência tradicional. O aplicativo permite que o usuário pré-cadastre suas informações vitais e, com poucos toques, acione contatos de emergência e serviços oficiais.

## ✨ Funcionalidades Principais

* **Perfil de Emergência Completo:** Cadastro de nome, tipo sanguíneo, alergias, condições médicas, contato de emergência e foto de perfil.
* **Persistência de Dados:** Todas as informações são salvas localmente no dispositivo, garantindo que estejam sempre disponíveis, mesmo após fechar o app.
* **Fluxo de Cadastro Obrigatório:** O aplicativo garante que o usuário preencha completamente seu perfil antes de liberar o acesso à tela principal de emergência.
* **Tela de Ação Rápida:** Uma interface limpa e direta com botões grandes para chamar serviços de emergência (Polícia, SAMU, Bombeiros).
* **Alerta para Contato Pessoal:** Uma função secundária que coleta todos os dados do perfil, adiciona a localização GPS em tempo real e prepara uma mensagem completa para ser enviada via WhatsApp para um contato de confiança.
* **UX Robusta:** O aplicativo fornece feedback visual claro, como indicadores de carregamento e mensagens de erro na tela, para guiar o usuário em momentos de estresse.

## 🖼️ Telas do Aplicativo

| Tela Principal (Ação) | Tela de Perfil (Dados) |
| :---: | :---: |
| ![Tela Principal do Alerta Inclusivo](https://github.com/user-attachments/assets/23ffbcd5-68f2-4a0d-916b-6a0ed16381cd)| ![Tela de Perfil do Alerta Inclusivo](https://github.com/user-attachments/assets/c7b90486-c345-45bf-b4a9-ede88fd42875) |

## 🛠️ Tecnologias e Pacotes Utilizados

* **Framework:** Flutter
* **Linguagem:** Dart
* **Banco de Dados Local:** `shared_preferences`
* **Hardware e APIs:**
    * `geolocator` para acesso ao GPS.
    * `image_picker` e `path_provider` para seleção e armazenamento de imagens.
    * `url_launcher` para integração com o discador do celular e o WhatsApp.

## 🚀 Como Executar o Projeto

1.  Clone este repositório.
2.  Garanta que o Flutter SDK esteja instalado e configurado corretamente.
3.  Execute `flutter pub get` no terminal para baixar as dependências.
4.  Conecte um dispositivo físico ou inicie um emulador.
5.  Execute `flutter run` para iniciar o aplicativo.

## 🔮 Próximos Passos
* Implementação de uma tela de "Cartões de Comunicação" com frases prontas e Text-to-Speech.
* Desenvolvimento de um backend com Cloud Functions e Twilio para o envio automático de alertas via SMS.
* Refinamento do design e da experiência do usuário.