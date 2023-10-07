import 'package:flutter/material.dart';

class CardWidget extends StatelessWidget {
  final bool isFlipped;
  final String value;
  final VoidCallback onTap;

  CardWidget({
    required this.isFlipped,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(4),
        color: isFlipped ? Colors.blue : Colors.grey,
        child: Center(
          child: isFlipped ? Text(value) : null,
        ),
      ),
    );
  }
}
