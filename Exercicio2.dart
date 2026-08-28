import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navegação com Retorno',
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
  int _valorAtual = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela 1'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Valor atual: $_valorAtual',
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final resultado = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const Tela2()),
                );

                if (resultado != null) {
                  setState(() {
                    _valorAtual = resultado;
                  });
                }
              },
              child: const Text('Escolher Número'),
            ),
          ],
        ),
      ),
    );
  }
}
class Tela2 extends StatelessWidget {
  const Tela2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela 2'),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 10);
              },
              child: const Text('Enviar 10'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context, 20);
              },
              child: const Text('Enviar 20'),
            ),
          ],
        ),
      ),
    );
  }
}
