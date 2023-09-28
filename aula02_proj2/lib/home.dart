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

  void _play(escolhaUser, escolhaApp) {
    setState(() {
      int i = -1;
      if (escolhaUser == escolhaApp) {
        i = 2;
      } else if ((escolhaUser == 0 && escolhaApp == 2) |
          (escolhaUser == 1 && escolhaApp == 0) |
          (escolhaUser == 2 && escolhaApp == 1)) {
        i = 0;
      } else {
        i = 1;
      }
      text = resultado[i];

      if (escolhaApp == 0) {
        imgEscolhaApp = "images/pedra.png";
      } else if (escolhaApp == 1) {
        imgEscolhaApp = "images/papel.png";
      } else if (escolhaApp == 2) {
        imgEscolhaApp = "images/tesoura.png";
      }
    });
  }

  String imgEscolhaApp = "images/default.png";
  String text = "Escolha uma opção!";
  int escolhaUser = -1;
  int escolhaApp = -1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('JokenPo')),
      body: Center(
          child: Container(
        padding: EdgeInsets.only(bottom: 120),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text(
              "Escolha do App",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Image.asset(imgEscolhaApp, height: 180),
            Text(text,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              GestureDetector(
                onTap: () {
                  escolhaUser = 0;
                  escolhaApp = Random().nextInt(resultado.length);
                  _play(escolhaUser, escolhaApp);
                },
                child: Image.asset("images/pedra.png", height: 100),
              ),
              GestureDetector(
                onTap: () {
                  escolhaUser = 1;
                  escolhaApp = Random().nextInt(resultado.length);
                  _play(escolhaUser, escolhaApp);
                },
                child: Image.asset("images/papel.png", height: 100),
              ),
              GestureDetector(
                onTap: () {
                  escolhaUser = 2;
                  escolhaApp = Random().nextInt(resultado.length);
                  _play(escolhaUser, escolhaApp);
                },
                child: Image.asset("images/tesoura.png", height: 100),
              )
            ])
          ],
        ),
      )),
    );
  }
}
