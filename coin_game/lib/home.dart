import 'dart:math';
import 'package:flutter/material.dart';
import 'package:helloworld/result.dart';

import 'moeda.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> sides = ["cara", "coroa"];
  void play() {
    int i = Random().nextInt(sides.length);
    print("Escolha: ${sides[i]}");

    /*Navigator.push(
        context, MaterialPageRoute(builder: (context) => Result(sides[i])));*/

    Navigator.pushNamed(context, Result.pageName, arguments: Moeda(sides[i]));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada de Dados"),
      ),
      body: Center(
        child: ElevatedButton(onPressed: play, child: Text("Jogar")),
      ),
    );
  }
}
