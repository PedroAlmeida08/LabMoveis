import 'package:flutter/material.dart';
import 'card_widget.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Memory Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MemoryGame(),
    );
  }
}

class MemoryGame extends StatefulWidget {
  @override
  _MemoryGameState createState() => _MemoryGameState();
}

class _MemoryGameState extends State<MemoryGame> {
  List<String> cards = [
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H',
    'A',
    'B',
    'C',
    'D',
    'E',
    'F',
    'G',
    'H'
  ];
  List<bool> cardFlips = List.filled(16, false);
  int? firstFlippedIndex;

  void flipCard(int index) {
    setState(() {
      if (firstFlippedIndex == null) {
        firstFlippedIndex = index;
      } else {
        if (cards[firstFlippedIndex!] == cards[index]) {
          cardFlips[firstFlippedIndex!] = true;
          cardFlips[index] = true;
        }
        firstFlippedIndex = null;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Memory Game'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 4.0,
          crossAxisSpacing: 4.0,
        ),
        itemCount: cards.length,
        itemBuilder: (context, index) {
          return CardWidget(
            isFlipped: cardFlips[index],
            value: cards[index],
            onTap: () {
              if (!cardFlips[index]) {
                flipCard(index);
              }
            },
          );
        },
      ),
    );
  }
}
