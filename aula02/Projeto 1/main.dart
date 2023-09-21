import 'dart:html';
import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: 'Frases Aleatórias',
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      appBar: AppBar(title: Text('Frases Aleatórias')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.asset("images/title.png"),
            Text("Clique aqui para gerar uma frase.",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ElevatedButton(
              onPressed: () {},
              child: Text("Nova Frase"),
            )
          ],
        ),
      ),
    ),
  ));
}
