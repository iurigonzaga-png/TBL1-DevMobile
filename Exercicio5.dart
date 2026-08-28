// iuri, wilson, pedro

import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fluxo Completo',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const TelaInicial(),
    );
  }
}
class TelaInicial extends StatefulWidget {
  const TelaInicial({super.key});

  @override
  State<TelaInicial> createState() => _TelaInicialState();
}

class _TelaInicialState extends State<TelaInicial> {
  String _mensagemResultado = "Nenhum cadastro realizado ainda.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tela Inicial')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              _mensagemResultado,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                final resultado = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const TelaCadastro()),
                );
                if (resultado != null) {
                  setState(() {
                    _mensagemResultado = resultado;
                  });
                }
              },
              child: const Text('Iniciar Cadastro'),
            ),
          ],
        ),
      ),
    );
  }
}
class TelaCadastro extends StatefulWidget {
  const TelaCadastro({super.key});

  @override
  State<TelaCadastro> createState() => _TelaCadastroState();
}

class _TelaCadastroState extends State<TelaCadastro> {
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();

  @override
  void dispose() {
    _nomeController.dispose();
    _idadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: _nomeController,
              decoration: const InputDecoration(
                labelText: 'Nome',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _idadeController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Idade',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () async {
                String nome = _nomeController.text;
                String idade = _idadeController.text;

                if (nome.isNotEmpty && idade.isNotEmpty) {
                  final resultadoDaConfirmacao = await Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => TelaConfirmacao(
                        nome: nome,
                        idade: idade,
                      ),
                    ),
                  );
                  if (resultadoDaConfirmacao != null) {
                    if (context.mounted) {
                      Navigator.pop(context, resultadoDaConfirmacao);
                    }
                  }
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Preencha todos os campos!')),
                  );
                }
              },
              child: const Text('Avançar para Confirmação'),
            ),
          ],
        ),
      ),
    );
  }
}
class TelaConfirmacao extends StatelessWidget {
  final String nome;
  final String idade;
  const TelaConfirmacao({super.key, required this.nome, required this.idade});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirmação')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Confirme os dados informados:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            Text('Nome: $nome', style: const TextStyle(fontSize: 18)),
            Text('Idade: $idade anos', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OutlinedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Voltar'),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                  onPressed: () {
                    String mensagemSucesso = "Cadastro de $nome confirmado com sucesso!";
                    Navigator.pop(context, mensagemSucesso);
                  },
                  child: const Text('Confirmar'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
