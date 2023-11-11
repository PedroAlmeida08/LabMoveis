import 'package:app002/previsao.dart';
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
  String cidade = "";
  double lat = 0, long = 0;
  bool visivel = false;
  String imgData = "images/data.png";
  String imgTemp = "images/temp.png";
  String imgMax = "images/min.png";
  String imgMin = "images/max.png";

  List<previsao> prevs = [
    previsao("", 0, 0, 0, "°C", "", "images/fundo_branco.png"),
    previsao("", 0, 0, 0, "°C", "", "images/fundo_branco.png"),
    previsao("", 0, 0, 0, "°C", "", "images/fundo_branco.png"),
    previsao("", 0, 0, 0, "°C", "", "images/fundo_branco.png"),
    previsao("", 0, 0, 0, "°C", "", "images/fundo_branco.png")
  ];

  String img_aqi = "images/fundo_branco.png";

  reset() {
    lat = 0;
    long = 0;
    cidade = "";
    for (int i = 0; i < prevs.length; i++) {
      prevs[i].data = "";
      prevs[i].temp = 0;
      prevs[i].temp_max = 0;
      prevs[i].temp_min = 0;
      prevs[i].climaTxt = "";
      prevs[i].climaImg = "images/fundo_branco.png";
    }
  }

  Future getData() async {
    reset();
    //getLatLong(cidade);
    getWeatherForecast();
    getCurrentAirPollutionData();
    setState(() {});
    visivel = true;
  }

  Future getLatLong(String cidade) async {
    String url =
        "http://api.openweathermap.org/geo/1.0/direct?q=$cidade&limit=5&appid=$apiKey";
    http.Response response = await http.get(Uri.parse(url));

    List<dynamic> data = jsonDecode(response.body);
    lat = data[0]["lat"];
    long = data[0]["lon"];
  }

  Future getWeatherForecast() async {
    String url =
        "http://api.openweathermap.org/data/2.5/forecast?lat=$lat.34&lon=$long&appid=$apiKey";
    http.Response response = await http.get(Uri.parse(url));

    Map<String, dynamic> dados = jsonDecode(response.body);

    for (int i = 0; i < dados.length; i++) {
      // Conversão de TimeStamp em dia/mes/ano
      DateTime dt = DateTime.fromMillisecondsSinceEpoch(
          dados["list"][i]["dt"] * 1000,
          isUtc: true);
      int ano = dt.year;
      int mes = dt.month;
      int dia = dt.day;
      prevs[i].data = "$dia/$mes/$ano";

      prevs[i].temp = dados["list"][i]["main"]["temp"] - 273;
      prevs[i].temp_max = dados["list"][i]["main"]["temp_max"] - 273;
      prevs[i].temp_min = dados["list"][i]["main"]["temp_min"] - 273;

      String clima = dados["list"][i]["weather"][0]["main"];

      if (clima == "Thunderstorm") {
        prevs[i].climaTxt = "Tempestade";
        prevs[i].climaImg = ("images/thunderstorm.png");
      } else if (clima == "Drizzle") {
        prevs[i].climaTxt = "Chuva Fraca";
        prevs[i].climaImg = ("images/drizzle.png");
      } else if (clima == "Rain") {
        prevs[i].climaTxt = "Chuva Forte";
        prevs[i].climaImg = ("images/rain.png");
      } else if (clima == "Snow") {
        prevs[i].climaTxt = "Neve";
        prevs[i].climaImg = ("images/snow.png");
      } else if (clima == "Mist" ||
          clima == "Smoke" ||
          clima == "Haze" ||
          clima == "Dust" ||
          clima == "Fog" ||
          clima == "Ash" ||
          clima == "Squall" ||
          clima == "Tornado") {
        prevs[i].climaTxt = "Nublado";
        prevs[i].climaImg = ("images/mist.png");
      } else if (clima == "Clear") {
        prevs[i].climaTxt = "Céu Limpo";
        prevs[i].climaImg = ("images/clear.png");
      } else if (clima == "Clouds") {
        prevs[i].climaTxt = "Encoberto";
        prevs[i].climaImg = ("images/clouds.png");
      }
    }

    setState(() {});
  }

  Future getCurrentAirPollutionData() async {
    String url =
        "http://api.openweathermap.org/data/2.5/air_pollution?lat=$lat&lon=$long&appid=$apiKey";
    http.Response response = await http.get(Uri.parse(url));
    //print(response.body);

    Map<String, dynamic> data = jsonDecode(response.body);

    double aqi = data["list"][0]["main"]["aqi"];

    if (aqi == 1) {
      img_aqi = "images/bom.png";
    } else if (aqi == 2) {
      img_aqi = "images/aceitavel.png";
    } else if (aqi == 3) {
      img_aqi = "images/moderado.png";
    } else if (aqi == 4) {
      img_aqi = "images/ruim.png";
    } else {
      img_aqi = "images/pessimo.png";
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App"),
      ),
      body: Container(
        padding:
            const EdgeInsets.only(top: 30, right: 20, bottom: 20, left: 20),
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  keyboardType: TextInputType.name,
                  onChanged: (value) => cidade = value,
                  decoration: new InputDecoration.collapsed(
                    hintText: 'Digite o nome de um país ou cidade',
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                    onPressed: () {
                      getData();
                    },
                    child: Text("Buscar")),
                const SizedBox(height: 25),
                Visibility(
                  visible: visivel,
                  child: Center(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Image.asset(prevs[0].climaImg, height: 250),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Image.asset(imgData, height: 30, width: 30),
                              Text(prevs[0].data)
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(imgTemp, height: 30, width: 30),
                              Text("${prevs[0].temp.toStringAsFixed(2)} °C")
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(imgMax, height: 20, width: 20),
                              Text("${prevs[0].temp_max.toStringAsFixed(2)} °C")
                            ],
                          ),
                          Row(
                            children: [
                              Image.asset(imgMin, height: 20, width: 20),
                              Text("${prevs[0].temp_min.toStringAsFixed(2)} °C")
                            ],
                          ),
                        ],
                      )
                    ],
                  )),
                ),
                Visibility(
                    visible: visivel,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(prevs[1].climaImg,
                                  height: 100, width: 100),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(imgData,
                                          height: 30, width: 30),
                                      Text(prevs[1].data)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(imgTemp,
                                          height: 30, width: 30),
                                      Text(
                                          "${prevs[1].temp.toStringAsFixed(2)} °C")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(imgMax,
                                          height: 20, width: 20),
                                      Text(
                                          "${prevs[1].temp_max.toStringAsFixed(2)} °C")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(imgMin,
                                          height: 20, width: 20),
                                      Text(
                                          "${prevs[1].temp_min.toStringAsFixed(2)} °C")
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(prevs[2].climaImg,
                                  height: 100, width: 100),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(imgData,
                                          height: 30, width: 30),
                                      Text(prevs[2].data)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(imgTemp,
                                          height: 30, width: 30),
                                      Text(
                                          "${prevs[2].temp.toStringAsFixed(2)} °C")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(imgMax,
                                          height: 20, width: 20),
                                      Text(
                                          "${prevs[2].temp_max.toStringAsFixed(2)} °C")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(imgMin,
                                          height: 20, width: 20),
                                      Text(
                                          "${prevs[2].temp_min.toStringAsFixed(2)} °C")
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(prevs[3].climaImg,
                                  height: 100, width: 100),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(imgData,
                                          height: 30, width: 30),
                                      Text(prevs[3].data)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(imgTemp,
                                          height: 30, width: 30),
                                      Text(
                                          "${prevs[3].temp.toStringAsFixed(2)} °C")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(imgMax,
                                          height: 20, width: 20),
                                      Text(
                                          "${prevs[3].temp_max.toStringAsFixed(2)} °C")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(imgMin,
                                          height: 20, width: 20),
                                      Text(
                                          "${prevs[3].temp_min.toStringAsFixed(2)} °C")
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(prevs[4].climaImg,
                                  height: 100, width: 100),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset(imgData,
                                          height: 30, width: 30),
                                      Text(prevs[4].data)
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(imgTemp,
                                          height: 30, width: 30),
                                      Text(
                                          "${prevs[4].temp.toStringAsFixed(2)} °C")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(imgMax,
                                          height: 20, width: 20),
                                      Text(
                                          "${prevs[4].temp_max.toStringAsFixed(2)} °C")
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Image.asset(imgMin,
                                          height: 20, width: 20),
                                      Text(
                                          "${prevs[4].temp_min.toStringAsFixed(2)} °C")
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
