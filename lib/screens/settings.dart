import 'package:flutter/material.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuración'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Lógica para importar datos
                
              },
              child: const Text('Importar datos'),
            ),
            ElevatedButton(
              onPressed: () {
                // Lógica para exportar datos
               
              },
              child: const Text('Exportar datos'),
            ),
          ],
        ),
      ),
    );
  }

  
}
