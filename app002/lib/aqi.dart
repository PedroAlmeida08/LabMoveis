import 'dart:convert';

import 'package:app002/argumentos.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AQI extends StatefulWidget {
  static const routeName = 'AQI';

  const AQI({super.key});

  @override
  State<AQI> createState() => _AQIState();
}

class _AQIState extends State<AQI> {
  String img_aqi = "images/fundo_branco.png";
  String txt_aqi = '';
  double SO2 = 0, NO2 = 0, PM10 = 0, PM25 = 0, O3 = 0, CO = 0;
  bool visivel = false;

  Future getCurrentAirPollutionData(
      double lat, double long, String apiKey) async {
    String url =
        "http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$long&appid=$apiKey";
    http.Response response = await http.get(Uri.parse(url));

    Map<String, dynamic> data = jsonDecode(response.body);

    double aqi = data["list"][0]["main"]["aqi"];
    SO2 = data["list"][0]["components"]["so2"];
    NO2 = data["list"][0]["components"]["no2"];
    PM10 = data["list"][0]["components"]["pm10"];
    PM25 = data["list"][0]["components"]["pm2_5"];
    O3 = data["list"][0]["components"]["o3"];
    CO = data["list"][0]["components"]["co"];

    if (aqi == 1) {
      img_aqi = "images/bom.png";
      txt_aqi = 'bom';
    } else if (aqi == 2) {
      img_aqi = "images/aceitavel.png";
      txt_aqi = 'aceitável';
    } else if (aqi == 3) {
      img_aqi = "images/moderado.png";
      txt_aqi = 'moderado';
    } else if (aqi == 4) {
      img_aqi = "images/ruim.png";
      txt_aqi = 'ruim';
    } else {
      img_aqi = "images/pessimo.png";
      txt_aqi = 'péssimo';
    }

    visivel = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final argumentos = ModalRoute.of(context)!.settings.arguments as Argumentos;
    return Scaffold(
      appBar: AppBar(title: Text('Weather App - Qualidade do Ar')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {
                getCurrentAirPollutionData(
                    argumentos.lat, argumentos.long, argumentos.apiKey);
              },
              child: Text('Buscar'),
            ),
            Visibility(
                visible: visivel,
                child: Center(
                  child: Column(
                    children: [
                      Text(
                          "O índice que mede a qualidade do ar em ${argumentos.cidade} está ${txt_aqi}"),
                      const SizedBox(height: 25),
                      Image.asset(img_aqi),
                      const SizedBox(height: 25),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("SO2: ${SO2}   "),
                          Text("NO2: ${NO2}   "),
                          Text("PM10: ${PM10}   "),
                          Text("PM2.5: ${PM25}   "),
                          Text("O32: ${O3}   "),
                          Text("CO: ${CO}"),
                        ],
                      )
                    ],
                  ),
                )),
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
