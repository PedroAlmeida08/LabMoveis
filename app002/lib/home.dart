import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = '4bf127e565a6c6be161aef2985a7864f';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController cityController = TextEditingController();
  String cidade = "";
  double lat = 0, long = 0;
  List<double> temps = [0, 0, 0, 0, 0];

  Future getData() async {
    getLatLong(cidade);
    getWeatherForecast();
    getCurrentAirPollutionData();
  }

  Future getLatLong(String cidade) async {
    String url =
        "http://api.openweathermap.org/geo/1.0/direct?q=$cidade&limit=5&appid=$apiKey";
    http.Response response = await http.get(Uri.parse(url));

    List<dynamic> data = jsonDecode(response.body);
    //print(response.body);
    lat = data[0]["lat"];
    long = data[0]["lon"];

    print("Lat: $lat");
    print("Long: $long");
  }

  Future getWeatherForecast() async {
    String url =
        "http://api.openweathermap.org/data/2.5/forecast?lat=44.34&lon=10.99&appid=$apiKey";
    http.Response response = await http.get(Uri.parse(url));

    Map<String, dynamic> data = jsonDecode(response.body);

    for (int i = 0; i < data.length; i++) {
      temps[i] = data["list"][i]["main"]["temp"] - 273;
      print(temps[i].toStringAsFixed(2));
    }
  }

  Future getCurrentAirPollutionData() async {
    String url =
        "http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$long&appid=$apiKey";
    http.Response response = await http.get(Uri.parse(url));
    //print(response.body);

    Map<String, dynamic> data = jsonDecode(response.body);

    double aqi = data["list"][0]["main"]["aqi"];

    if (aqi == 1) {
      print("Good");
    } else if (aqi == 2) {
      print("Fair");
    } else if (aqi == 3) {
      print("Moderate");
    } else if (aqi == 4) {
      print("Poor");
    } else {
      print("Very poor");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Weatjer App')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextField(
                keyboardType: TextInputType.name,
                onChanged: (value) => cidade = value,
              ),
              ElevatedButton(
                  onPressed: () {
                    getData();
                  },
                  child: Text("Buscar")),
            ],
          ),
        ));
  }
}
