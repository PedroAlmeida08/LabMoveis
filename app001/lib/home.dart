import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  bool? numbers = false;
  bool? letters = false;
  String card1 = "";
  String card2 = "";
  int ct = 0;
  int tentativas = 0;
  List<int> nImgCard = [
    0,
    0,
    1,
    1,
    2,
    2,
    3,
    3,
    4,
    4,
    5,
    5,
    6,
    6,
    7,
    7,
    8,
    8,
    9,
    9
  ];
  List<String> imgCard = [
    "images/fundo.png",
    "images/fundo.png",
    "images/fundo.png",
    "images/fundo.png",
    "images/fundo.png",
    "images/fundo.png",
    "images/fundo.png",
    "images/fundo.png",
    "images/fundo.png",
    "images/fundo.png",
  ];
  List<String> numbersFigures = [
    "images/0.png",
    "images/1.png",
    "images/2.png",
    "images/3.png",
    "images/4.png",
    "images/5.png",
    "images/6.png",
    "images/7.png",
    "images/8.png",
    "images/9.png"
  ];
  List<String> lettersFigures = [
    "images/a.png",
    "images/b.png",
    "images/c.png",
    "images/d.png",
    "images/e.png",
    "images/f.png",
    "images/g.png",
    "images/h.png",
    "images/i.png",
    "images/j.png"
  ];
  List<String> bothFigures = [
    "images/0.png",
    "images/1.png",
    "images/2.png",
    "images/3.png",
    "images/4.png",
    "images/a.png",
    "images/b.png",
    "images/c.png",
    "images/d.png",
    "images/e.png"
  ];

  String imgCard1 = "images/fundo.png";
  String imgCard2 = "images/fundo.png";
  String imgCard3 = "images/fundo.png";
  String imgCard4 = "images/fundo.png";
  String imgCard5 = "images/fundo.png";
  String imgCard6 = "images/fundo.png";
  String imgCard7 = "images/fundo.png";
  String imgCard8 = "images/fundo.png";
  String imgCard9 = "images/fundo.png";
  String imgCard10 = "images/fundo.png";
  String imgCard11 = "images/fundo.png";
  String imgCard12 = "images/fundo.png";
  String imgCard13 = "images/fundo.png";
  String imgCard14 = "images/fundo.png";
  String imgCard15 = "images/fundo.png";
  String imgCard16 = "images/fundo.png";
  String imgCard17 = "images/fundo.png";
  String imgCard18 = "images/fundo.png";
  String imgCard19 = "images/fundo.png";
  String imgCard20 = "images/fundo.png";

  void play() {
    String modo = "Nenhum selecionado";
    if ((numbers == true) & (letters == false)) {
      modo = "Números";
      imgCard = numbersFigures;
    } else if ((letters == true) & (numbers == false)) {
      modo = "Letras";
      imgCard = lettersFigures;
    } else if ((letters == true) & (numbers == true)) {
      modo = "Ambos";
      imgCard = bothFigures;
    }
    print("Modo: ${modo}");
    //nImgCard.shuffle();
  }

  int resultado() {
    int res = -1;
    print("Card1: ${card1}");
    print("Card2: ${card2}");
    if (card1 == card2) {
      print("Acertou!");
      res = 1;
    } else if ((card1 != card2)) {
      print("Errou!");
      res = 0;
    }
    card1 = "";
    card2 = "";

    ct = -1;

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jogo da Memória"),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Column(
                children: [
                  TextField(
                    keyboardType: TextInputType.text,
                    decoration:
                        const InputDecoration(labelText: "Digite seu apelido:"),
                    maxLength: 30,
                    maxLengthEnforcement: MaxLengthEnforcement.none,
                    style: const TextStyle(fontSize: 20, color: Colors.grey),
                    controller: nameController,
                  ),
                  CheckboxListTile(
                    value: numbers,
                    title: const Text("Números"),
                    activeColor: Colors.blue,
                    secondary: const Icon(Icons.numbers),
                    onChanged: (bool? value) {
                      print("Checkbox: $value");
                      numbers = value;
                      setState(() {});
                    },
                  ),
                  CheckboxListTile(
                    value: letters,
                    title: const Text("Letras"),
                    activeColor: Colors.blue,
                    secondary: const Icon(Icons.abc),
                    onChanged: (bool? value) {
                      print("Checkbox: $value");
                      letters = value;
                      setState(() {});
                    },
                  ),
                  ElevatedButton(
                    onPressed: play,
                    child: const Text("Iniciar"),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (ct < 2) {
                            imgCard1 = imgCard[nImgCard[0]];
                            if (ct == 0) {
                              card1 = imgCard1;
                            } else if (ct == 1) {
                              card2 = imgCard1;
                            }
                            ct++;
                          }
                          setState(() {});
                        },
                        child: Image.asset(imgCard1, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (ct < 2) {
                            imgCard2 = imgCard[nImgCard[1]];
                            if (ct == 0) {
                              card1 = imgCard2;
                            } else if (ct == 1) {
                              card2 = imgCard2;
                            }
                            ct++;
                          }
                          setState(() {});
                        },
                        child: Image.asset(imgCard2, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (ct < 2) {
                            imgCard3 = imgCard[nImgCard[2]];
                            if (ct == 0) {
                              card1 = imgCard3;
                            } else if (ct == 1) {
                              card2 = imgCard3;
                            }
                            ct++;
                          }
                          setState(() {});
                        },
                        child: Image.asset(imgCard3, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (ct < 2) {
                            imgCard4 = imgCard[nImgCard[3]];
                            if (ct == 0) {
                              card1 = imgCard4;
                            } else if (ct == 1) {
                              card2 = imgCard4;
                            }
                            ct++;
                          }
                          setState(() {});
                        },
                        child: Image.asset(imgCard4, height: 100),
                      ),
                    ],
                  ),
                  /*Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          imgCard5 = imgCard[nImgCard[4]];
                          setState(() {});
                        },
                        child: Image.asset(imgCard5, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          imgCard6 = imgCard[nImgCard[5]];
                          setState(() {});
                        },
                        child: Image.asset(imgCard6, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          imgCard7 = imgCard[nImgCard[6]];
                          setState(() {});
                        },
                        child: Image.asset(imgCard7, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          imgCard8 = imgCard[nImgCard[7]];
                          setState(() {});
                        },
                        child: Image.asset(imgCard8, height: 100),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          imgCard9 = imgCard[nImgCard[8]];
                          setState(() {});
                        },
                        child: Image.asset(imgCard9, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          imgCard10 = imgCard[nImgCard[9]];
                          setState(() {});
                        },
                        child: Image.asset(imgCard10, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          imgCard11 = imgCard[nImgCard[10]];
                          setState(() {});
                        },
                        child: Image.asset(imgCard11, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          imgCard12 = imgCard[nImgCard[11]];
                          setState(() {});
                        },
                        child: Image.asset(imgCard12, height: 100),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          imgCard13 = imgCard[nImgCard[12]];
                          setState(() {});
                        },
                        child: Image.asset(imgCard13, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          imgCard14 = imgCard[nImgCard[13]];
                          setState(() {});
                        },
                        child: Image.asset(imgCard14, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          imgCard15 = imgCard[nImgCard[14]];
                          setState(() {});
                        },
                        child: Image.asset(imgCard15, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          imgCard16 = imgCard[nImgCard[15]];
                          setState(() {});
                        },
                        child: Image.asset(imgCard16, height: 100),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          imgCard17 = imgCard[nImgCard[16]];
                          setState(() {});
                        },
                        child: Image.asset(imgCard17, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          imgCard18 = imgCard[nImgCard[17]];
                          setState(() {});
                        },
                        child: Image.asset(imgCard18, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          imgCard19 = imgCard[nImgCard[18]];
                          setState(() {});
                        },
                        child: Image.asset(imgCard19, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          imgCard20 = imgCard[nImgCard[19]];
                          setState(() {});
                        },
                        child: Image.asset(imgCard20, height: 100),
                      ),
                    ],
                  )*/
                ],
              ),
              SizedBox(height: 20),
              Text("Developed by JP Almeida",
                  style: TextStyle(color: Colors.grey)),
            ],
          )),
    );
  }
}
