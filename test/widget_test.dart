import 'package:flutter/material.dart';

void main() {
  runApp(const AlertaInclusivoApp());
}

class AlertaInclusivoApp extends StatelessWidget {
  const AlertaInclusivoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alerta Inclusivo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const TelaPerfil(),
    );
  }
}

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  // 1. DECLARAÇÃO DOS CONTROLLERS
  // Criamos um controller para cada campo de texto.
  final _nomeController = TextEditingController();
  final _tipoSanguineoController = TextEditingController();
  final _alergiasController = TextEditingController();

  // 2. O MÉTODO dispose()
  // É uma boa prática de programação descartar os controllers quando a tela não está mais sendo usada para liberar memória.
  @override
  void dispose() {
    _nomeController.dispose();
    _tipoSanguineoController.dispose();
    _alergiasController.dispose();
    super.dispose();
  }

  // 3. A LÓGICA DO BOTÃO SALVAR
  void _salvarInformacoes() {
    // Usamos .text para pegar o texto atual de cada controller.
    // final nome = _nomeController.text; // Removido pois não estava sendo usado
    // final tipoSanguineo = _tipoSanguineoController.text; // Removido pois não estava sendo usado
    // final alergias = _alergiasController.text; // Removido pois não estava sendo usado

    // Em um teste real, você usaria 'expect' para verificar os valores.
    // Ex: expect(nome, 'Texto Esperado');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Emergência'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // --- CAMPO NOME COMPLETO ---
            TextField(
              controller: _nomeController, // 4. CONECTANDO O CONTROLLER
              decoration: const InputDecoration(
                labelText: 'Nome Completo',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
            ),
            const SizedBox(height: 16.0),

            // --- CAMPO TIPO SANGUÍNEO ---
            TextField(
              controller: _tipoSanguineoController, // 4. CONECTANDO O CONTROLLER
              decoration: const InputDecoration(
                labelText: 'Tipo Sanguíneo (Ex: A+)',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.bloodtype),
              ),
            ),
            const SizedBox(height: 16.0),
            
            // --- CAMPO ALERGIAS ---
            TextField(
              controller: _alergiasController, // 4. CONECTANDO O CONTROLLER
              maxLines: 4,
              decoration: const InputDecoration(
                labelText: 'Alergias (medicamentos, alimentos, etc.)',
                hintText: 'Descreva aqui suas alergias conhecidas...',
                border: OutlineInputBorder(),
                alignLabelWithHint: true,
              ),
            ),
            const SizedBox(height: 24.0),

            // --- BOTÃO DE SALVAR ---
            ElevatedButton.icon(
              onPressed: _salvarInformacoes, // 5. CONECTANDO A LÓGICA AO BOTÃO
              icon: const Icon(Icons.save),
              label: const Text('Salvar Informações'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                backgroundColor: Colors.blue[700],
                foregroundColor: Colors.white,
                textStyle: const TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}