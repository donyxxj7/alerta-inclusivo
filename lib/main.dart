// Conteúdo final para: lib/main.dart

import 'package:alerta_inclusivo/tela_principal.dart';
import 'package:alerta_inclusivo/tela_perfil.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Este import não é mais necessário aqui, mas sim no tela_principal
// import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // A inicialização do Firebase foi movida para o futuro, quando implementarmos o backend.
  // Por enquanto, esta é a versão que funciona com o envio via WhatsApp/SMS.
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  final prefs = await SharedPreferences.getInstance();
  final bool perfilCompleto = _verificarPerfilCompleto(prefs);
  runApp(AlertaInclusivoApp(perfilCompleto: perfilCompleto));
}

bool _verificarPerfilCompleto(SharedPreferences prefs) {
  final nome = prefs.getString('nome') ?? '';
  final tipoSanguineo = prefs.getString('tipoSanguineo') ?? '';
  final alergias = prefs.getString('alergias') ?? '';
  final condicoesMedicas = prefs.getString('condicoesMedicas') ?? '';
  final contatoNome = prefs.getString('contatoNome') ?? '';
  final contatoTelefone = prefs.getString('contatoTelefone') ?? '';
  final caminhoImagem = prefs.getString('caminhoImagem') ?? '';

  return nome.isNotEmpty &&
      tipoSanguineo.isNotEmpty &&
      alergias.isNotEmpty &&
      condicoesMedicas.isNotEmpty &&
      contatoNome.isNotEmpty &&
      contatoTelefone.isNotEmpty &&
      caminhoImagem.isNotEmpty;
}

class AlertaInclusivoApp extends StatelessWidget {
  final bool perfilCompleto;
  const AlertaInclusivoApp({super.key, required this.perfilCompleto});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alerta Inclusivo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: perfilCompleto ? const TelaPrincipal() : const TelaPerfil(),
    );
  }
}