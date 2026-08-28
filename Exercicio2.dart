import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Passagem de Dados',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Tela1(), 
    );
  }
}
class Tela1 extends StatefulWidget {
  const Tela1({super.key});

  @override
  State<Tela1> createState() => _Tela1State();
}
 class _Tela1State extends State<Tela1> {
  final TextEditingController _nomeController = TextEditingController();
  @override
  void dispose() {
    _nomeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela 1'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Digite seu nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 5),
            ElevatedButton(
              onPressed: () {
                String nomeDigitado = _nomeController.text;
                if (nomeDigitado.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Tela2(nome: nomeDigitado),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Por favor, digite um nome!')),
                  );
                }
              },
              child: const Text('Enviar Nome'),
            ),
          ],
        ),
      ),
    );
  }
}
class Tela2 extends StatelessWidget {
  final String nome;
  const Tela2({super.key, required this.nome});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela 2'),
      ),
      body: Center(
        child: Text(
          'Olá, $nome',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
