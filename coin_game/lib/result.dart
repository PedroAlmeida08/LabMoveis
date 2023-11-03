import 'package:flutter/material.dart';
import 'moeda.dart';

class Result extends StatefulWidget {
  static String pageName = "result";

  const Result({super.key});
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context)!.settings.arguments as Moeda;

    return Scaffold(
        appBar: AppBar(title: Text("Cara ou Coroa")),
        body: Center(
          child: Image.asset("images/${args.side}.png", height: 300),
        ));
  }
}
