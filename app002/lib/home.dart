import 'package:app002/aqi.dart';
import 'package:app002/argumentos.dart';
import 'package:app002/previsao.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController cityController = TextEditingController();
  double lat = 0, long = 0;
  bool visivel = false;
  bool visivel_aviso = false;
  String imgData = "images/data.png";
  String imgTemp = "images/temp.png";
  String imgMax = "images/max.png";
  String imgMin = "images/min.png";

  List<previsao> prevs = [
    previsao("", 0, 0, 0, "°C", "", "images/fundo_branco.png"),
    previsao("", 0, 0, 0, "°C", "", "images/fundo_branco.png"),
    previsao("", 0, 0, 0, "°C", "", "images/fundo_branco.png"),
    previsao("", 0, 0, 0, "°C", "", "images/fundo_branco.png"),
    previsao("", 0, 0, 0, "°C", "", "images/fundo_branco.png")
  ];

  Future getData(String cidade) async {
    String urlLatLong =
        "http://api.openweathermap.org/geo/1.0/direct?q=$cidade&limit=5&appid=$apiKey";
    http.Response responseLatLong = await http.get(Uri.parse(urlLatLong));

    List<dynamic> dadosLatLong = jsonDecode(responseLatLong.body);

    if (dadosLatLong.length == 0) {
      visivel_aviso = true;
    } else {
      visivel_aviso = false;

      lat = dadosLatLong[0]["lat"];
      long = dadosLatLong[0]["lon"];

      String urlWeatherForecast =
          "http://api.openweathermap.org/data/2.5/forecast?lat=$lat&lon=$long&appid=$apiKey";
      http.Response responseWeatherForecast =
          await http.get(Uri.parse(urlWeatherForecast));

      Map<String, dynamic> dadosWeatherForecast =
          jsonDecode(responseWeatherForecast.body);

      for (int i = 0, j = 0;
          i < dadosWeatherForecast["list"].length;
          i = i + 8, j++) {
        //get Datas
        DateTime dt = DateTime.fromMillisecondsSinceEpoch(
            dadosWeatherForecast["list"][i]["dt"] * 1000,
            isUtc: true);
        int ano = dt.year;
        int mes = dt.month;
        int dia = dt.day;
        prevs[j].data = "$dia/$mes/$ano";

        //get Temperaturas
        prevs[j].temp = dadosWeatherForecast["list"][i]["main"]["temp"] - 273;
        prevs[j].temp_max =
            dadosWeatherForecast["list"][i]["main"]["temp_max"] - 273;
        prevs[j].temp_min =
            dadosWeatherForecast["list"][i]["main"]["temp_min"] - 273;

        //get Clima
        String clima = dadosWeatherForecast["list"][i]["weather"][0]["main"];
        if (clima == "Thunderstorm") {
          prevs[j].climaTxt = "Tempestade";
          prevs[j].climaImg = ("images/thunderstorm.png");
        } else if (clima == "Drizzle") {
          prevs[j].climaTxt = "Chuva Fraca";
          prevs[j].climaImg = ("images/drizzle.png");
        } else if (clima == "Rain") {
          prevs[j].climaTxt = "Chuva Forte";
          prevs[j].climaImg = ("images/rain.png");
        } else if (clima == "Snow") {
          prevs[j].climaTxt = "Neve";
          prevs[j].climaImg = ("images/snow.png");
        } else if (clima == "Mist" ||
            clima == "Smoke" ||
            clima == "Haze" ||
            clima == "Dust" ||
            clima == "Fog" ||
            clima == "Ash" ||
            clima == "Squall" ||
            clima == "Tornado") {
          prevs[j].climaTxt = "Nublado";
          prevs[j].climaImg = ("images/mist.png");
        } else if (clima == "Clear") {
          prevs[j].climaTxt = "Céu Limpo";
          prevs[j].climaImg = ("images/clear.png");
        } else if (clima == "Clouds") {
          prevs[j].climaTxt = "Encoberto";
          prevs[j].climaImg = ("images/clouds.png");
        }

        /*print("Data: ${prevs[j].data}");
      print("Temperatura: ${prevs[j].temp}${prevs[j].escala}");
      print("Temperatura Máxima: ${prevs[j].temp_max}${prevs[j].escala}");
      print("Temperatura Mínima: ${prevs[j].temp_min}${prevs[j].escala}");
      print("Clima: ${prevs[j].climaTxt} - ${prevs[j].climaImg}");*/
      }

      visivel = true;
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Weather App - Previsão do Tempo"),
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
                  controller: cityController,
                  decoration: new InputDecoration.collapsed(
                    hintText: 'Digite o nome de um país ou cidade',
                  ),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                    onPressed: () {
                      getData(cityController.text);
                    },
                    child: Text("Buscar")),
                const SizedBox(height: 25),
                Visibility(
                    visible: visivel_aviso,
                    child: Text("Digite um local válido!")),
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
                const SizedBox(height: 35),
                Visibility(
                    visible: visivel,
                    child: ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, 'AQI',
                              arguments: Argumentos(lat, long, apiKey,
                                  cityController.text as String));
                        },
                        child: Text("Qualidade do Ar"))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
