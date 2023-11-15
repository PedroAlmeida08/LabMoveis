import 'package:app002/aqi.dart';
import 'package:flutter/material.dart';
import 'package:app002/home.dart';

void main() {
  runApp(MaterialApp(
    title: 'Weather App',
    debugShowCheckedModeBanner: false,
    initialRoute: '/',
    routes: {
      '/': (context) => Home(),
      AQI.routeName: (context) => AQI(),
    },
  ));
}
