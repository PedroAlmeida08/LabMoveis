import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController cepController = TextEditingController();
  String logradouro = "", bairro = "", uf = "";

  void getCep() async {
    String url = "https://viacep.com.br/ws/${cepController.text}/json/";
    print(url);

    http.Response response = await http.get(Uri.parse(url));
    print(response.statusCode);
    print(response.body);

    Map<String, dynamic> data = jsonDecode(response.body);
    print("${data["logradouro"]}, ${data["bairro"]}, ${data["uf"]}");
    logradouro = data["logradouro"];
    bairro = data["bairro"];
    uf = data["uf"];

    setState(() {});
  }

  Future<Map<String, dynamic>> getFutureCep() async {
    TextEditingController cepController = TextEditingController();
    String logradouro = "", bairro = "", uf = "";
    if (cepController.text.isNotEmpty) {
      String url = "https://viacep.com.br/ws/${cepController.text}/json/";
      print(url);

      http.Response response = await http.get(Uri.parse(url));
      print(response.statusCode);
      print(response.body);

      Map<String, dynamic> data = jsonDecode(response.body);

      return data;
    } else {
      return {"logradouro": "", "bairro": "", "uf": ""};
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Via CEP')),
      body: FutureBuilder(
        future: getFutureCep(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            logradouro = snapshot.data!["logradouro"];
            bairro = snapshot.data!["bairro"];
            uf = snapshot.data!["uf"];
          } else if (snapshot.hasError) {
            logradouro = snapshot.error.toString();
          } else {
            return Center(child: CircularProgressIndicator());
          }

          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextField(
                  keyboardType: TextInputType.number,
                  controller: cepController,
                ),
                ElevatedButton(
                    onPressed: () {
                      setState(() {});
                    },
                    child: Text("Buscar")),
                Text(logradouro),
                Text(bairro),
                Text(uf),
              ],
            ),
          );
        },
      ),
    );
  }
}
