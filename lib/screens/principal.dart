import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  final List<String> miListaDeObjetos = [
    'Objeto 1',
    'Objeto 2',
    'Objeto 3',
    'Objeto 4',
    'Objeto 5',
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lista de Objetos'),
        ),
        body: ListaDeObjetos(miListaDeObjetos),
      ),
    );
  }
}

class ListaDeObjetos extends StatelessWidget {
  final List<String> lista;

  ListaDeObjetos(this.lista);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(lista[index]),
          ),
        );
      },
    );
  }
}