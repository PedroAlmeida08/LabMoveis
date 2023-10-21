import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:app001/cardObj.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameController = TextEditingController();
  bool? numbers = false;
  bool? letters = false;
  bool iniciar = false;
  CardObj cartaLimpa = CardObj(-1, "", false);
  CardObj card1 = CardObj(-1, "", false);
  CardObj card2 = CardObj(-1, "", false);
  int ct = 0;
  int tentativas = 0;
  int pares = 0;
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

  List<String> imgCard = [
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

  String imgFundo = "images/fundo.png";

  List<CardObj> cartas = [
    CardObj(0, "images/fundo.png", false),
    CardObj(1, "images/fundo.png", false),
    CardObj(2, "images/fundo.png", false),
    CardObj(3, "images/fundo.png", false),
    CardObj(4, "images/fundo.png", false),
    CardObj(5, "images/fundo.png", false),
    CardObj(6, "images/fundo.png", false),
    CardObj(8, "images/fundo.png", false),
    CardObj(9, "images/fundo.png", false),
    CardObj(10, "images/fundo.png", false),
    CardObj(11, "images/fundo.png", false),
    CardObj(12, "images/fundo.png", false),
    CardObj(13, "images/fundo.png", false),
    CardObj(14, "images/fundo.png", false),
    CardObj(15, "images/fundo.png", false),
    CardObj(16, "images/fundo.png", false),
    CardObj(17, "images/fundo.png", false),
    CardObj(18, "images/fundo.png", false),
    CardObj(19, "images/fundo.png", false),
    CardObj(20, "images/fundo.png", false),
  ];

  Future<void> showGame() async {
    setState(() {
      for (int i = 0; i < cartas.length; i++) {
        cartas[i].img = imgCard[nImgCard[i]];
      }
    });
    await Future.delayed(Duration(seconds: 4));
    setState(() {
      for (int i = 0; i < cartas.length; i++) {
        cartas[i].img = imgFundo;
      }
    });
  }

  void init() {
    if ((numbers == true) & (letters == false)) {
      imgCard = numbersFigures;
    } else if ((letters == true) & (numbers == false)) {
      imgCard = lettersFigures;
    } else if ((letters == true) & (numbers == true)) {
      imgCard = imgCard;
    }
    iniciar = true;
    nImgCard.shuffle();
    showGame();
  }

  void flip(CardObj card1, CardObj card2) {
    for (int i = 0; i < cartas.length; i++) {
      if ((card1.pos == cartas[i].pos) | (card2.pos == cartas[i].pos)) {
        cartas[i].img = imgFundo;
        cartas[i].isFlipped = false;
      }
    }
  }

  Future<void> play(CardObj carta, int pos) async {
    if ((carta.isFlipped == false) & (ct < 2)) {
      setState(() {
        carta.img = imgCard[nImgCard[pos]];
        carta.isFlipped = true;
        ct++;
      });
      if ((card1.isFlipped == false) & (card2.isFlipped == false)) {
        setState(() {
          card1 = carta;
        });
      } else if ((card1.isFlipped == true) &
          (card2.isFlipped == false) &
          (card1.pos != card2.pos)) {
        setState(() {
          card2 = carta;
        });
      }
      if ((card1.isFlipped == true) & (card2.isFlipped == true)) {
        if ((card1.img != "") & (card2.img != "") & (card1.img == card2.img)) {
          setState(() {
            pares++;
          });
        } else if ((card1.img != "") &
            (card2.img != "") &
            (card1.img != card2.img)) {
          await Future.delayed(Duration(milliseconds: 850));
          setState(() {
            flip(card1, card2);
          });
        }
        card1 = cartaLimpa;
        card2 = cartaLimpa;
        tentativas++;
        ct = 0;
      }
    }
    if (pares == 10) {
      print("Acabou!");
    }
  }

  void resetar() {
    setState(() {
      for (int i = 0; i < cartas.length; i++) {
        cartas[i].img = imgFundo;
        cartas[i].isFlipped = false;
      }
    });
    tentativas = 0;
    init();
  }

  void trocarModo() {
    setState(() {
      for (int i = 0; i < cartas.length; i++) {
        cartas[i].img = imgFundo;
        cartas[i].isFlipped = false;
      }
    });
    tentativas = 0;
    iniciar = false;
    numbers = false;
    letters = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Jogo da Memória"),
      ),
      body: Container(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
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
                      letters = value;
                      setState(() {});
                    },
                  ),
                  const SizedBox(height: 10),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            if (iniciar == false) {
                              init();
                            }
                          },
                          child: const Text("Iniciar"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (iniciar == true) {
                              resetar();
                            }
                          },
                          child: const Text("Resetar"),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (iniciar == true) {
                              trocarModo();
                            }
                          },
                          child: const Text("Trocar modo"),
                        ),
                      ]),
                  const SizedBox(height: 20),
                  Text("Tentativas: $tentativas",
                      style: const TextStyle(color: Colors.black)),
                ],
              ),
              const SizedBox(height: 20),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (iniciar == true) {
                            play(cartas[0], 0);
                          }
                        },
                        child: Image.asset(cartas[0].img, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (iniciar == true) {
                            play(cartas[1], 1);
                          }
                        },
                        child: Image.asset(cartas[1].img, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (iniciar == true) {
                            play(cartas[2], 2);
                          }
                        },
                        child: Image.asset(cartas[2].img, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (iniciar == true) {
                            play(cartas[3], 3);
                          }
                        },
                        child: Image.asset(cartas[3].img, height: 100),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (iniciar == true) {
                            play(cartas[4], 4);
                          }
                        },
                        child: Image.asset(cartas[4].img, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (iniciar == true) {
                            play(cartas[5], 5);
                          }
                        },
                        child: Image.asset(cartas[5].img, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (iniciar == true) {
                            play(cartas[6], 6);
                          }
                        },
                        child: Image.asset(cartas[6].img, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (iniciar == true) {
                            play(cartas[7], 7);
                          }
                        },
                        child: Image.asset(cartas[7].img, height: 100),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (iniciar == true) {
                            play(cartas[8], 8);
                          }
                        },
                        child: Image.asset(cartas[8].img, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (iniciar == true) {
                            play(cartas[9], 9);
                          }
                        },
                        child: Image.asset(cartas[9].img, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (iniciar == true) {
                            play(cartas[10], 10);
                          }
                        },
                        child: Image.asset(cartas[10].img, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (iniciar == true) {
                            play(cartas[11], 11);
                          }
                        },
                        child: Image.asset(cartas[11].img, height: 100),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (iniciar == true) {
                            play(cartas[12], 12);
                          }
                        },
                        child: Image.asset(cartas[12].img, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (iniciar == true) {
                            play(cartas[13], 13);
                          }
                        },
                        child: Image.asset(cartas[13].img, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (iniciar == true) {
                            play(cartas[14], 14);
                          }
                        },
                        child: Image.asset(cartas[14].img, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (iniciar == true) {
                            play(cartas[15], 15);
                          }
                        },
                        child: Image.asset(cartas[15].img, height: 100),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (iniciar == true) {
                            play(cartas[16], 16);
                          }
                        },
                        child: Image.asset(cartas[16].img, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (iniciar == true) {
                            play(cartas[17], 17);
                          }
                        },
                        child: Image.asset(cartas[17].img, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (iniciar == true) {
                            play(cartas[18], 18);
                          }
                        },
                        child: Image.asset(cartas[18].img, height: 100),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (iniciar == true) {
                            play(cartas[19], 19);
                          }
                        },
                        child: Image.asset(cartas[19].img, height: 100),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 20),
              const Text("Developed by JP Almeida",
                  style: TextStyle(color: Colors.grey)),
            ],
          ))),
    );
  }
}
