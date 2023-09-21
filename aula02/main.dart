import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    title: "Hello App",
    debugShowCheckedModeBanner: false,
    home: Container(
      padding: EdgeInsets.only(left: 30, top: 20),
      margin: EdgeInsets.all(15),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Hello World!",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold)),
          Text("Texto 2"),
          GestureDetector(
            onTap: () {
              print("Gesture Detector clicado!");
            },
            child: Image.asset("images/title.png"),
          ),
          ElevatedButton(
              /*onPressed: () {
                print("Cliquei!");
              }, // Função Anônima*/
              onPressed: () => (print("Cliquei!")), //Arrow Function
              child: Text("Clique aqui!"))
        ],
      ),
      decoration:
          BoxDecoration(border: Border.all(color: Colors.blue, width: 10)),
    ),
  ));
}
