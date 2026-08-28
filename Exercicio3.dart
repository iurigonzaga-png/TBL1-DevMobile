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

// 1- O Flutter vai abrir a próxima tela e, milissegundos depois, já vai tentar ler a variável resultadoDaConfirmacao e executar as próximas linhas de código. Como a tela mal abriu e o usuário não teve tempo de digitar ou confirmar nada, não existe resultado nenhum.
// 2- No Dart, a palavra await é dependente do async. A regra da linguagem é estrita: você só pode pedir para o código "esperar" (await) se você avisar o compilador antes de que aquela função tem o poder de trabalhar fora de sincronia (async). Se você remover o async, a palavra await passa a ser considerada um erro e o app nem roda.
// 3- No Dart, um Future é um objeto que representa uma promessa de que uma operação será concluída no futuro, seja com sucesso (devolvendo um valor) ou com falha (devolvendo um erro).
// 4- O valor prometido só "aterrisa" de volta na variável (e o código que estava esperando no await volta a rodar) exatamente no milissegundo em que ocorre o Navigator.pop(context, valor) na tela que estava no topo.
