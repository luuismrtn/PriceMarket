import 'package:flutter/material.dart';
import 'package:price_market/screens/principal.dart';
import 'objects/AppStyle.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PriceMarket',
      theme: ThemeData(
        primaryColor: AppStyle.miColorPrimario,
        useMaterial3: true,
      ),
      home: const Principal(),
    );
  }
}
