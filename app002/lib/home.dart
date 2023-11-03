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
  TextEditingController cepController = TextEditingController();
  String logradouro = "", bairro = "", uf = "";

  String latitude = "33.223191";
  String longitude = "43.679291";

  Future getAirPollutionData() async {
    String url =
        "http://api.openweathermap.org/data/2.5/air_pollution?lat=$latitude&lon=$longitude&appid=$apiKey";
    print(url);
    http.Response response = await http.get(Uri.parse(url));
    print(response.body);

    Map<String, dynamic> data = jsonDecode(response.body);

    double so2 = data["list"][0]["components"]["so2"];
    double no2 = data["list"][0]["components"]["no2"];
    double pm10 = data["list"][0]["components"]["pm10"];
    double pm2_5 = data["list"][0]["components"]["pm2_5"];
    double o3 = data["list"][0]["components"]["o3"];
    double co = data["list"][0]["components"]["co"];

    if (so2 < 20 &&
        no2 < 40 &&
        pm10 < 20 &&
        pm2_5 < 10 &&
        o3 < 60 &&
        co < 4400) {
      print("Good");
    } else if (so2 < 80 &&
        no2 < 70 &&
        pm10 < 50 &&
        pm2_5 < 25 &&
        o3 < 100 &&
        co < 9400) {
      print("Fair");
    } else if (so2 < 250 &&
        no2 < 150 &&
        pm10 < 100 &&
        pm2_5 < 50 &&
        o3 < 140 &&
        co < 12400) {
      print("Moderate");
    } else if (so2 < 350 &&
        no2 < 200 &&
        pm10 < 200 &&
        pm2_5 < 75 &&
        o3 < 180 &&
        co < 15400) {
      print("Poor");
    } else {
      print("Very poor");
    }

    print("SO2: ${so2}");
    print("NO2: ${no2}");
    print("PM10: ${pm10}");
    print("PM2.5: ${pm2_5}");
    print("O3: ${o3}");
    print("CO: ${co}");
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
                keyboardType: TextInputType.number,
                controller: cepController,
              ),
              ElevatedButton(
                  onPressed: () {
                    getAirPollutionData();
                  },
                  child: Text("Buscar")),
            ],
          ),
        ));
  }
}
