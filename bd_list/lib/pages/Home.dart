import 'dart:io';
import "dart:async";
import "dart:convert";
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> _listaTarefas = [];
  
  TextEditingController _controllerTarefa = TextEditingController();

  Future<File> _getFile() async {
    final dir = await getApplicationDocumentsDirectory();
    print("Path: ${dir.path}");

    return File("${dir.path}/data.json");
  }

  /* Implementar função abaixo  */
  _saveTarefa() {
    String taskStr = _controllerTarefa.text;

    Map<String, dynamic> task = {
      "title": taskStr,
      "done": false
    };

    setState(() {
      _listaTarefas.add(task);
    });
    
    _saveFile();
  }

  _updateTarefa(int index) {
    String taskStr = _controllerTarefa.text;

    Map<String, dynamic> task = _listaTarefas[index];
    task["title"] = taskStr;

    setState(() {
      
    });
    
    _saveFile();
  }

  _saveFile() async {
    final file = await _getFile();
    String data = jsonEncode(_listaTarefas);
    file.writeAsString(data);
  }

  _readFile() async {
    try {
      final file = await _getFile();
      return file.readAsString();
    } catch (e) {
      return null;
    }
  }

  void buildInsertUpdate(String operation, {int index = -1}) {
    String label = "Salvar";
    if (operation == "atualizar") {
      label = "Atualizar";
      _controllerTarefa.text = _listaTarefas[index]["title"];
    }

    showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text("$label Tarefa"),
        content: TextField(
            controller: _controllerTarefa,
            decoration:
                InputDecoration(labelText: "Digite sua tarefa"),
            onChanged: (text) {}),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Cancelar")),
          TextButton(
              onPressed: () {

                if (operation == "atualizar") {
                  _updateTarefa(index);
                } else {
                  _saveTarefa();
                }
                
                Navigator.pop(context);
              },
              child: Text(label)),
        ],
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _readFile().then((data) {
      setState(() {
        _listaTarefas = jsonDecode(data);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    

    return Scaffold(
      appBar: AppBar(
        title: Text("Lista de Tarefas"),
        backgroundColor: Colors.purple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Colors.purple,
        onPressed: () {
          buildInsertUpdate("inserir");
        },
      ),
      body: Container(
        padding: EdgeInsets.all(32),
        child: Column(children: [
          Expanded(
              child: ListView.builder(
                  itemCount: _listaTarefas.length,
                  itemBuilder: (context, index) {
                    
                    
                    return Dismissible(
                      key: Key(DateTime.now().microsecondsSinceEpoch.toString()),
                      background: Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.green,
                        child: Row(
                          children: [
                            Icon(
                              Icons.edit,
                              color: Colors.white,
                            )
                          ],
                        )
                      ),
                      secondaryBackground: Container(
                        padding: EdgeInsets.all(20),
                        color: Colors.red,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Icon(
                              Icons.delete,
                              color: Colors.white,
                            )
                          ],
                        )
                      ),
                      onDismissed: (direction) {
                        print(direction);

                        if (direction == DismissDirection.endToStart) {
                          // Excluir Tarefa
                          _listaTarefas.removeAt(index);
                          setState(() {
                            
                          });
                          _saveFile();
                        } else if (direction == DismissDirection.startToEnd) {
                          // Atualizar Tarefa

                          buildInsertUpdate("atualizar", index: index);
                        }
                      },
                      child: CheckboxListTile(
                        title: Text(_listaTarefas[index]["title"]),
                        value: _listaTarefas[index]["done"],
                        onChanged: (newVal) {
                          setState(() {
                            _listaTarefas[index]["done"] = newVal;
                          });
                          _saveFile();
                        },
                      )  
                    );
                    
                    
                  }))
        ]),
      ),
    );
  }
}
