import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

// 1 = Pedra
// 2 = Papel
// 3 = Tesoura

class _HomeState extends State<Home> {
  List<String> resultado = ["Você venceu :)", "Você perdeu :(", "Empate!"];

  void _play(escolha_user, escolha_app) {
    setState(() {
      int i = -1;
      if (escolha_user == escolha_app) {
        i = 2;
      } else if ((escolha_user == 0 && escolha_app == 2) |
          (escolha_user == 1 && escolha_app == 0) |
          (escolha_user == 2 && escolha_app == 1)) {
        i = 0;
      } else {
        i = 1;
      }
      text = resultado[i];
    });
  }

  String text = "Escolha uma opção!";
  int escolha_user = -1;
  int escolha_app = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('JokenPo')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text("Escolha do App"),
            Image.asset("images/default.png"),
            Text(text,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(children: [
              GestureDetector(
                onTap: () {
                  escolha_user = 0;
                  escolha_app = Random().nextInt(2);
                  _play(escolha_user, escolha_app);
                },
                child: Image.asset("images/pedra.png"),
              ),
              GestureDetector(
                onTap: () {
                  escolha_user = 1;
                  escolha_app = Random().nextInt(2);
                  _play(escolha_user, escolha_app);
                },
                child: Image.asset("images/papel.png"),
              ),
              GestureDetector(
                onTap: () {
                  escolha_user = 2;
                  escolha_app = Random().nextInt(2);
                  _play(escolha_user, escolha_app);
                },
                child: Image.asset("images/tesoura.png"),
              )
            ])
          ],
        ),
      ),
    );
  }
}
