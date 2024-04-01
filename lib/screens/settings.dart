import 'package:flutter/material.dart';
import 'package:price_market/components/dialogDatos.dart';
import 'package:price_market/objects/AppStyle.dart';
import 'package:price_market/screens/shoppingCart.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Configuración',
          style: TextStyle(
              fontSize: 25, fontFamily: 'ProductSans', color: Colors.black),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                'Importante: Cambiar la configuración de la aplicación puede afectar su funcionamiento. Por favor, no cambie la configuración si no está seguro de lo que está haciendo.',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 14,
                    fontFamily: 'ProductSans',
                    color: Colors.red,
                    fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
              child: const Text(
                'Importar datos',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'ProductSans',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 3,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 215, 215),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(10),
                        elevation: 5),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const DialogDatos(
                              title: 'Importar datosMIOS.txt',
                              content:
                                  '¿Está seguro de que desea importar sus datos?');
                        },
                      );
                    },
                    child: const Text('Importar datos MIOS',
                        style: TextStyle(color: AppStyle.miColorPrimario)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 215, 215),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(10),
                        elevation: 5),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const DialogDatos(
                              title: 'Importar Datos.txt',
                              content:
                                  '¿Está seguro de que desea importar datos del mercadona?');
                        },
                      );
                    },
                    child: const Text('Importar datos Mercadona',
                        style: TextStyle(color: AppStyle.miColorPrimario)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 215, 215),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(10),
                        elevation: 5),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const DialogDatos(
                              title: 'Importar categorias',
                              content:
                                  '¿Está seguro de que desea importar las categorías?');
                        },
                      );
                    },
                    child: const Text('Importar categorías',
                        style: TextStyle(color: AppStyle.miColorPrimario)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 215, 215),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(10),
                        elevation: 5),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Importar lista de la compra'),
                            content: Text(
                                '¿Está seguro de que desea importar la lista de la compra?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  ShoppingCart.datosManager('Importar');
                                  Navigator.pop(context);
                                },
                                child: Text('Importar lista de la compra'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Importar lista de la compra',
                        style: TextStyle(color: AppStyle.miColorPrimario)),
                  ),
                ],
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.fromLTRB(20, 10, 10, 0),
              child: const Text(
                'Exportar datos',
                textAlign: TextAlign.justify,
                style: TextStyle(
                    fontSize: 25,
                    fontFamily: 'ProductSans',
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
            ),
            const Divider(
              color: Colors.black,
              thickness: 3,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(10, 5, 5, 10),
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 215, 215),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(10),
                        elevation: 5),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const DialogDatos(
                              title: 'Exportar datosMIOS.txt',
                              content:
                                  '¿Está seguro de que desea exportar sus datos?');
                        },
                      );
                    },
                    child: const Text('Exportar datos MIOS',
                        style: TextStyle(color: AppStyle.miColorPrimario)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 215, 215),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(10),
                        elevation: 5),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const DialogDatos(
                              title: 'Combinar datos',
                              content:
                                  '¿Está seguro de que deseas combinar los datos del mercadona y los tuyos?');
                        },
                      );
                    },
                    child: const Text('Combinar datos',
                        style: TextStyle(color: AppStyle.miColorPrimario)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 215, 215),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(10),
                        elevation: 5),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const DialogDatos(
                              title: 'Exportar categorías',
                              content:
                                  '¿Está seguro de que desea exportar las categorias?');
                        },
                      );
                    },
                    child: const Text('Exportar categorías',
                        style: TextStyle(color: AppStyle.miColorPrimario)),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 255, 215, 215),
                        minimumSize: const Size(double.infinity, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        padding: const EdgeInsets.all(10),
                        elevation: 5),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: Text('Exportar lista de la compra'),
                            content: Text(
                                '¿Está seguro de que desea exportar la lista de la compra?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  ShoppingCart.datosManager('Exportar');
                                  Navigator.pop(context);
                                },
                                child: Text('Exportar lista de la compra'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                    child: const Text('Exportar lista de la compra',
                        style: TextStyle(color: AppStyle.miColorPrimario)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
