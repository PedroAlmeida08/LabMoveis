import 'package:flutter/material.dart';
import 'package:helloworld/home.dart';
import 'package:helloworld/result.dart';

void main() {
  runApp(MaterialApp(
    initialRoute: "/",
    routes: {Result.pageName: (context) => Result()},
    title: 'Cara ou Coroa',
    debugShowCheckedModeBanner: false,
    home: Home(),
  ));
}
