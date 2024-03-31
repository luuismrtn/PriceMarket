import 'package:flutter/material.dart';
import 'package:price_market/objects/AppStyle.dart';
import 'package:price_market/screens/principal.dart';
import 'package:price_market/screens/settings.dart';
import 'package:price_market/screens/shoppingCart.dart';

class DrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: AppStyle.miColorPrimario,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 40,
                  backgroundImage: AssetImage('assets/logo.png'),
                ),
                SizedBox(height: 10),
                Text(
                  'Luis Martín',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
                Text(
                  'luismartingarcia4@gmail.com',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.home),
            title: const Text('Inicio'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Principal()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.shopping_cart),
            title: const Text('Cesta de la compra'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ShoppingCart()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.info),
            title: const Text('Acerca de'),
            onTap: () {
              Navigator.pop(context);
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Acerca de',
                        style: TextStyle(fontFamily: 'ProductSans')),
                    content: const Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text('Aplicación desarrollada por',
                            style: TextStyle(fontFamily: 'ProductSans')),
                        Text('Luis Martín García',
                            style: TextStyle(
                                fontFamily: 'ProductSans',
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text('Price Market',
                            style: TextStyle(fontFamily: 'ProductSans')),
                        Text('Versión: ${AppStyle.version}',
                            style: TextStyle(fontFamily: 'ProductSans')),
                      ],
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Text('Cerrar'),
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
