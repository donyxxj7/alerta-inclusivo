// Imports que a TelaPerfil precisa para funcionar
import 'dart:io';
import 'package:alerta_inclusivo/tela_principal.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:path/path.dart' as p;

class TelaPerfil extends StatefulWidget {
  const TelaPerfil({super.key});

  @override
  State<TelaPerfil> createState() => _TelaPerfilState();
}

class _TelaPerfilState extends State<TelaPerfil> {
  // Controllers para os campos de texto
  final _nomeController = TextEditingController();
  final _tipoSanguineoController = TextEditingController();
  final _alergiasController = TextEditingController();
  final _condicoesMedicasController = TextEditingController();
  final _contatoEmergenciaNomeController = TextEditingController();
  final _contatoEmergenciaTelefoneController = TextEditingController();
  
  // Variável de estado para o caminho da imagem
  String? _caminhoImagemPerfil;

  @override
  void initState() {
    super.initState();
    _carregarInformacoes();
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _tipoSanguineoController.dispose();
    _alergiasController.dispose();
    _condicoesMedicasController.dispose();
    _contatoEmergenciaNomeController.dispose();
    _contatoEmergenciaTelefoneController.dispose();
    super.dispose();
  }

  Future<void> _carregarInformacoes() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _nomeController.text = prefs.getString('nome') ?? '';
      _tipoSanguineoController.text = prefs.getString('tipoSanguineo') ?? '';
      _alergiasController.text = prefs.getString('alergias') ?? '';
      _condicoesMedicasController.text = prefs.getString('condicoesMedicas') ?? '';
      _contatoEmergenciaNomeController.text = prefs.getString('contatoNome') ?? '';
      _contatoEmergenciaTelefoneController.text = prefs.getString('contatoTelefone') ?? '';
      _caminhoImagemPerfil = prefs.getString('caminhoImagem');
    });
  }

  Future<void> _salvarInformacoes() async {
    // Validação para garantir que todos os campos foram preenchidos
    if (_nomeController.text.isEmpty ||
        _tipoSanguineoController.text.isEmpty ||
        _alergiasController.text.isEmpty ||
        _condicoesMedicasController.text.isEmpty ||
        _contatoEmergenciaNomeController.text.isEmpty ||
        _contatoEmergenciaTelefoneController.text.isEmpty ||
        _caminhoImagemPerfil == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor, preencha todos os campos e adicione uma foto.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Salva todos os dados
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nome', _nomeController.text);
    await prefs.setString('tipoSanguineo', _tipoSanguineoController.text);
    await prefs.setString('alergias', _alergiasController.text);
    await prefs.setString('condicoesMedicas', _condicoesMedicasController.text);
    await prefs.setString('contatoNome', _contatoEmergenciaNomeController.text);
    await prefs.setString('contatoTelefone', _contatoEmergenciaTelefoneController.text);
    
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Perfil salvo! Acessando o app...'), backgroundColor: Colors.green),
    );

    if (!mounted) return;
    // Navega para a tela principal, impedindo o usuário de "voltar" para o cadastro
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const TelaPrincipal()),
    );
  }

  Future<void> _pegarImagemDaGaleria() async {
    final picker = ImagePicker();
    final XFile? pickedFile = await picker.pickImage(source: ImageSource.gallery, imageQuality: 80);

    if (pickedFile != null) {
      final appDir = await getApplicationDocumentsDirectory();
      final nomeArquivo = p.basename(pickedFile.path);
      final caminhoSalvo = '${appDir.path}/$nomeArquivo';
      
      final arquivoSalvo = await File(pickedFile.path).copy(caminhoSalvo);
      
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('caminhoImagem', arquivoSalvo.path);

      setState(() {
        _caminhoImagemPerfil = arquivoSalvo.path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // Interface completa da tela de perfil
    return Scaffold(
      appBar: AppBar(
        title: const Text('Perfil de Emergência'),
        backgroundColor: Colors.blue[700],
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: GestureDetector(
                onTap: _pegarImagemDaGaleria,
                child: CircleAvatar(
                  radius: 60,
                  backgroundColor: Colors.grey[200],
                  backgroundImage: _caminhoImagemPerfil != null
                      ? FileImage(File(_caminhoImagemPerfil!))
                      : null,
                  child: _caminhoImagemPerfil == null
                      ? Icon(
                          Icons.camera_alt,
                          size: 50,
                          color: Colors.grey[800],
                        )
                      : null,
                ),
              ),
            ),
            const SizedBox(height: 8),
            Center(
              child: Text(
                'Toque no círculo para alterar a foto',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ),
            const SizedBox(height: 24.0),

            Text('Dados Pessoais', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8.0),
            TextField(controller: _nomeController, decoration: const InputDecoration(labelText: 'Nome Completo', border: OutlineInputBorder(), prefixIcon: Icon(Icons.person))),
            const SizedBox(height: 16.0),
            TextField(controller: _tipoSanguineoController, decoration: const InputDecoration(labelText: 'Tipo Sanguíneo (Ex: A+)', border: OutlineInputBorder(), prefixIcon: Icon(Icons.bloodtype))),
            const SizedBox(height: 24.0),
            Text('Dados Médicos', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8.0),
            TextField(controller: _alergiasController, maxLines: 3, decoration: const InputDecoration(labelText: 'Alergias', border: OutlineInputBorder(), alignLabelWithHint: true)),
            const SizedBox(height: 16.0),
            TextField(controller: _condicoesMedicasController, maxLines: 3, decoration: const InputDecoration(labelText: 'Condições Médicas Crônicas', border: OutlineInputBorder(), alignLabelWithHint: true)),
            const SizedBox(height: 24.0),
            Text('Contato de Emergência', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8.0),
            TextField(controller: _contatoEmergenciaNomeController, decoration: const InputDecoration(labelText: 'Nome do Contato', border: OutlineInputBorder(), prefixIcon: Icon(Icons.contact_emergency))),
            const SizedBox(height: 16.0),
            TextField(controller: _contatoEmergenciaTelefoneController, decoration: const InputDecoration(labelText: 'Telefone do Contato', border: OutlineInputBorder(), prefixIcon: Icon(Icons.phone)), keyboardType: TextInputType.phone),
            const SizedBox(height: 32.0),
            ElevatedButton.icon(
              onPressed: _salvarInformacoes,
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