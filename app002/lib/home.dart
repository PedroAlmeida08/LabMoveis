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
  TextEditingController cityController = TextEditingController();
  String cidade = "";
  double lat = 0, long = 0;
  List<previsao> prevs = [];
  String img_aqi = "images/bom.png";

  Future getData() async {
    getLatLong(cidade);
    getWeatherForecast();
    getCurrentAirPollutionData();
    setState(() {});
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
        "http://api.openweathermap.org/data/2.5/forecast?lat=44.34&lon=10.99&appid=$apiKey";
    http.Response response = await http.get(Uri.parse(url));

    Map<String, dynamic> dados = jsonDecode(response.body);
    previsao prev;

    for (int i = 0; i < dados.length; i++) {
      // Conversão de TimeStamp em dia/mes/ano
      DateTime dt = DateTime.fromMillisecondsSinceEpoch(
          dados["list"][i]["dt"] * 1000,
          isUtc: true);
      int ano = dt.year;
      int mes = dt.month;
      int dia = dt.day;
      String data = "$dia/$mes/$ano";

      String clima = dados["list"][i]["weather"][0]["main"];
      String climaTxt = "";
      String climaImg = "";

      if (clima == "Thunderstorm") {
        climaTxt = "Tempestade";
        climaImg = ("images/thunderstorm.png");
      } else if (clima == "Drizzle") {
        climaTxt = "Chuva Fraca";
        climaImg = ("images/drizzle.png");
      } else if (clima == "Rain") {
        climaTxt = "Chuva Forte";
        climaImg = ("images/rain.png");
      } else if (clima == "Snow") {
        climaTxt = "Neve";
        climaImg = ("images/snow.png");
      } else if (clima == "Mist" ||
          clima == "Smoke" ||
          clima == "Haze" ||
          clima == "Dust" ||
          clima == "Fog" ||
          clima == "Ash" ||
          clima == "Squall" ||
          clima == "Tornado") {
        climaTxt = "Nublado";
        climaImg = ("images/mist.png");
      } else if (clima == "Clear") {
        climaTxt = "Céu Limpo";
        climaImg = ("images/clear.png");
      } else if (clima == "Clouds") {
        climaTxt = "Encoberto";
        climaImg = ("images/clouds.png");
      }

      prev = previsao(
          data,
          dados["list"][i]["main"]["temp"] - 273,
          dados["list"][i]["main"]["temp_max"] - 273,
          dados["list"][i]["main"]["temp_min"] - 273,
          "°C",
          climaTxt,
          climaImg);
      prevs.add(prev);
    }

    for (var i = 0; i < prevs.length; i++) {
      print(prevs[i].data);
      print(prevs[i].temp);
      print(prevs[i].temp_max);
      print(prevs[i].temp_min);
      print(prevs[i].escala);
      print(prevs[i].climaTxt);
      print(prevs[i].climaImg);
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
                      print(prevs);
                    },
                    child: Text("Buscar")),
                const SizedBox(height: 25),
                Center(
                    child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Image.asset("images/clouds.png", height: 250),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Image.asset("images/data.png",
                                height: 30, width: 30),
                            Text("11/11/2023")
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset("images/temp.png",
                                height: 30, width: 30),
                            Text("37°C")
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset("images/max.png",
                                height: 20, width: 20),
                            Text(" 27°C")
                          ],
                        ),
                        Row(
                          children: [
                            Image.asset("images/min.png",
                                height: 20, width: 20),
                            Text(" 42°C")
                          ],
                        ),
                      ],
                    )
                  ],
                )),
                Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("images/clear.png",
                              height: 100, width: 100),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset("images/data.png",
                                      height: 30, width: 30),
                                  Text("11/11/2023")
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset("images/temp.png",
                                      height: 30, width: 30),
                                  Text("37°C")
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset("images/max.png",
                                      height: 20, width: 20),
                                  Text(" 27°C")
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset("images/min.png",
                                      height: 20, width: 20),
                                  Text(" 42°C")
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("images/clear.png",
                              height: 100, width: 100),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset("images/data.png",
                                      height: 30, width: 30),
                                  Text("11/11/2023")
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset("images/temp.png",
                                      height: 30, width: 30),
                                  Text("37°C")
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset("images/max.png",
                                      height: 20, width: 20),
                                  Text(" 27°C")
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset("images/min.png",
                                      height: 20, width: 20),
                                  Text(" 42°C")
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset("images/clear.png",
                              height: 100, width: 100),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset("images/data.png",
                                      height: 30, width: 30),
                                  Text("11/11/2023")
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset("images/temp.png",
                                      height: 30, width: 30),
                                  Text("37°C")
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset("images/max.png",
                                      height: 20, width: 20),
                                  Text(" 27°C")
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset("images/min.png",
                                      height: 20, width: 20),
                                  Text(" 42°C")
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset("images/clear.png",
                              height: 100, width: 100),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Image.asset("images/data.png",
                                      height: 30, width: 30),
                                  Text("11/11/2023")
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset("images/temp.png",
                                      height: 30, width: 30),
                                  Text("37°C")
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset("images/max.png",
                                      height: 20, width: 20),
                                  Text(" 27°C")
                                ],
                              ),
                              Row(
                                children: [
                                  Image.asset("images/min.png",
                                      height: 20, width: 20),
                                  Text(" 42°C")
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
