import 'package:flutter/material.dart';
import 'package:price_market/screens/principal.dart';

class DialogDatos extends StatelessWidget {
  final String title;
  final String content;

  const DialogDatos({
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            Principal.datosManager(title);
            Navigator.pop(context);
          },
          child: Text(title),
        ),
      ],
    );
  }
}
