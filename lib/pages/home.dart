import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:band_names/models/banda.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Banda> bandas = [
    Banda(id: '1', name: 'Limão com Mel', votes: 15),
    Banda(id: '2', name: 'Pedra Leticia', votes: 2),
    Banda(id: '3', name: 'Sambô', votes: 1),
    Banda(id: '4', name: 'Sorriso Maroto', votes: 4)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:
            const Text('Band Names', style: TextStyle(color: Colors.black87)),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: ListView.builder(
        itemCount: bandas.length,
        itemBuilder: (BuildContext context, int index) =>
            _bandaTile(bandas[index]),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        elevation: 1,
        onPressed: addNewBanda,
      ),
    );
  }

  Widget _bandaTile(Banda banda) {
    return Dismissible(
      key: Key(banda.id!),
      direction: DismissDirection.startToEnd,
      onDismissed: (direction) {
        print('direction: $direction');
        print('id: ${banda.id}');
      },
      background: Container(
          padding: const EdgeInsets.only(left: 8.0),
          color: Colors.red,
          child: const Align(
            alignment: Alignment.centerLeft,
            child: Text('Apagar banda'),
          )),
      child: ListTile(
        leading: CircleAvatar(
          child: Text(banda.name!.substring(0, 2)),
          backgroundColor: Colors.blue[100],
        ),
        title: Text(banda.name!),
        trailing: Text(
          '${banda.votes}',
          style: const TextStyle(fontSize: 18),
        ),
        onTap: () {
          print(banda.name!);
        },
      ),
    );
  }

  addNewBanda() {
    final textController = TextEditingController();

    if (Platform.isAndroid) {
      return showDialog(
        context: context,
        builder: (content) {
          return AlertDialog(
            title: const Text('Adicionar nova banda:'),
            content: TextField(
              controller: textController,
            ),
            actions: <Widget>[
              MaterialButton(
                child: const Text('Add'),
                elevation: 5,
                onPressed: () => addBandaToList(textController.text),
              ),
            ],
          );
        },
      );
    }
    showCupertinoDialog(
        context: context,
        builder: (_) {
          return CupertinoAlertDialog(
            title: Text('Add nova banda:'),
            content: CupertinoTextField(
              controller: textController,
            ),
            actions: <Widget>[
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Text('Add'),
                onPressed: () => addBandaToList(textController.text),
              ),
              CupertinoDialogAction(
                isDestructiveAction: true,
                child: Text('Dismiss'),
                onPressed: () => addBandaToList(textController.text),
              )
            ],
          );
        });
  }

  void addBandaToList(String name) {
    print(name);

    if (name.length > 1) {
      this
          .bandas
          .add(Banda(id: DateTime.now().toString(), name: name, votes: 0));
      setState(() {});
    }

    Navigator.pop(context);
  }
}
