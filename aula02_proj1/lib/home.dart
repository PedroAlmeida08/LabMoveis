import 'package:flutter/material.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> frases = ["Bom Dia!", "Boa Tarde", "Boa Noite"];

  void _play() {
    int i = Random().nextInt(frases.length);
    print("Frase selecionada $i: ${frases[i]}");
    setState(() {
      text = frases[i];
    });
  }

  String text = "Clique aqui para gerar uma frase.";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Frases Aleatórias')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("images/title.png"),
            Text(text,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: _play,
              child: Text("Nova Frase"),
            )
          ],
        ),
      ),
    );
  }
}
