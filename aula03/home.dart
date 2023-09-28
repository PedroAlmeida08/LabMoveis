import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  bool? checkbox1 = false;
  bool? checkbox2 = false;
  String? sexo = "m";
  bool switch1 = false;

  void save() {
    print("Nome: ${nameController.text}");
    print("Idade: ${ageController.text}");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Entrada de Dados"),
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Nome"),
              maxLength: 30,
              maxLengthEnforcement: MaxLengthEnforcement.none,
              style: TextStyle(fontSize: 30, color: Colors.grey),
              onChanged: (String value) {
                print("OnChanged: $value");
              },
              onSubmitted: (String value) {
                print("OnSubmitted: $value");
              },
              controller: nameController,
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Idade"),
              style: TextStyle(fontSize: 30, color: Colors.grey),
              controller: ageController,
            ),
            TextField(
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: "Senha"),
              obscureText: true,
              style: TextStyle(fontSize: 30, color: Colors.grey),
            ),
            CheckboxListTile(
              value: checkbox1,
              title: Text("Churrasco"),
              subtitle: Text("com molho à campanha"),
              activeColor: Colors.amber,
              /*selected: true,*/
              secondary: Icon(Icons.account_balance_wallet),
              onChanged: (bool? value) {
                print("Checkbox: $value");
                checkbox1 = value;
                setState(() {});
              },
            ),
            CheckboxListTile(
              value: checkbox2,
              title: Text("IceTea"),
              subtitle: Text("limão"),
              activeColor: Colors.amber,
              /*selected: true,*/
              secondary: Icon(Icons.account_balance_wallet),
              onChanged: (bool? value) {
                print("Checkbox: $value");
                checkbox2 = value;
                setState(() {});
              },
            ),
            RadioListTile(
              value: "m",
              groupValue: sexo,
              title: Text("Masculino"),
              onChanged: (String? value) {
                sexo = value;
                setState(() {});
              },
            ),
            RadioListTile(
              value: "f",
              groupValue: sexo,
              title: Text("Feminino"),
              onChanged: (String? value) {
                sexo = value;
                setState(() {});
              },
            ),
            SwitchListTile(
                value: switch1,
                title: Text("ABC"),
                onChanged: (bool value) {
                  switch1 = value;
                  setState(() {});
                }),
            ElevatedButton(
              child: Text("Salvar"),
              onPressed: save,
            )
          ],
        ),
      ),
    );
  }
}
