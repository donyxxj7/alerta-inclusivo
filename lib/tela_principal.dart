// Conteúdo final para: lib/tela_principal.dart

import 'package:alerta_inclusivo/tela_perfil.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class TelaPrincipal extends StatefulWidget {
  const TelaPrincipal({super.key});

  @override
  State<TelaPrincipal> createState() => _TelaPrincipalState();
}

class _TelaPrincipalState extends State<TelaPrincipal> {
  bool _estaCarregando = false;

  void _mostrarAviso(String mensagem, {bool isError = true}) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensagem), backgroundColor: isError ? Colors.redAccent : Colors.green),
    );
  }

  // RENOMEADO para maior clareza
  Future<void> _dispararAlertaContato() async {
    setState(() { _estaCarregando = true; });
    try {
      // ... (toda a lógica para buscar GPS, perfil e abrir o WhatsApp)
      // Esta função continua a mesma de antes.
       bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        _mostrarAviso('Por favor, ative o serviço de localização (GPS).');
        return;
      }
      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          _mostrarAviso('A permissão de localização é necessária.');
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        _mostrarAviso('Permissão de localização negada permanentemente.');
        return;
      }
      Position position = await Geolocator.getCurrentPosition();
      final prefs = await SharedPreferences.getInstance();
      final contatoTelefone = prefs.getString('contatoTelefone') ?? '';
      if (contatoTelefone.isEmpty) {
        _mostrarAviso('Nenhum telefone de contato salvo no perfil.');
        return;
      }
      final nome = prefs.getString('nome') ?? 'Não informado';
      final alertaCompleto = '''ALERTA DE EMERGÊNCIA:\n- NOME: $nome\n- LOCALIZAÇÃO: https://www.google.com/maps/search/?api=1&query=${position.latitude},${position.longitude}''';
      final Uri whatsappUri = Uri.parse('https://wa.me/$contatoTelefone?text=${Uri.encodeComponent(alertaCompleto)}');
      if (await canLaunchUrl(whatsappUri)) {
        await launchUrl(whatsappUri);
      } else {
        _mostrarAviso('Não foi possível abrir o WhatsApp.');
      }
    } catch (e) {
      _mostrarAviso('Ocorreu um erro: ${e.toString()}');
    } finally {
      if (mounted) {
        setState(() { _estaCarregando = false; });
      }
    }
  }

  // RENOMEADO para maior clareza
  Future<void> _mostrarDialogoConfirmacaoContato() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Avisar Contato de Emergência?'),
          content: const Text('Uma mensagem será preparada no WhatsApp para seu contato de emergência.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('Continuar', style: TextStyle(color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
                _dispararAlertaContato();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _fazerLigacao(String numero) async {
    final Uri url = Uri(scheme: 'tel', path: numero);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      _mostrarAviso('Não foi possível iniciar a chamada.');
    }
  }

  Future<void> _mostrarDialogoDeLigacao(String nomeServico, String numero) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Ligar para $nomeServico?'),
          content: Text('O discador do seu celular será aberto com o número $numero pronto para chamar.'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: Text('LIGAR', style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
              onPressed: () {
                Navigator.of(context).pop();
                _fazerLigacao(numero);
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // AQUI ESTÁ O NOVO LAYOUT DA TELA
    return Scaffold(
      appBar: AppBar(
        title: const Text('Alerta Inclusivo'),
        backgroundColor: Colors.blue[800],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) => const TelaPerfil()));
            },
            tooltip: 'Ver/Editar Perfil',
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                'Ligar para Emergência',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              SizedBox(
                height: 64,
                child: ElevatedButton.icon(
                  onPressed: () => _mostrarDialogoDeLigacao('SAMU', '192'),
                  icon: const Icon(Icons.emergency, size: 32),
                  label: const Text('SAMU (192)'),
                  style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      backgroundColor: Colors.red[700],
                      foregroundColor: Colors.white),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 64,
                child: ElevatedButton.icon(
                  onPressed: () => _mostrarDialogoDeLigacao('Polícia', '190'),
                  icon: const Icon(Icons.local_police, size: 32),
                  label: const Text('Polícia (190)'),
                  style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 64,
                child: ElevatedButton.icon(
                  onPressed: () => _mostrarDialogoDeLigacao('Bombeiros', '193'),
                  icon: const Icon(Icons.local_fire_department, size: 32),
                  label: const Text('Bombeiros (193)'),
                  style: ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20)),
                ),
              ),
              const Spacer(),
              SizedBox(
                height: 60,
                child: OutlinedButton.icon(
                  onPressed: _estaCarregando ? null : _mostrarDialogoConfirmacaoContato,
                  icon: _estaCarregando
                      ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 3))
                      : const Icon(Icons.send_to_mobile, size: 28),
                  label: Text(_estaCarregando ? 'Preparando...' : 'Avisar Contato Pessoal'),
                  style: OutlinedButton.styleFrom(
                    textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    side: BorderSide(width: 2, color: Theme.of(context).primaryColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}