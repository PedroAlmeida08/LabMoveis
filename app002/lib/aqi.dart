import 'package:flutter/material.dart';

class AQI extends StatefulWidget {
  AQI(double lat, double long);

  @override
  State<AQI> createState() => _AQIState();
}

class _AQIState extends State<AQI> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Weather App - Qualidade do Ar')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Voltar'),
            )
          ],
        ),
      ),
    );
  }
}
