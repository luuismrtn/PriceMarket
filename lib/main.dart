import 'package:flutter/material.dart';
import 'package:price_market/screens/principal.dart';
import 'objects/AppStyle.dart';

Future<void> main() async {
  runApp(const PriceMarket());
}

class PriceMarket extends StatelessWidget {
  const PriceMarket({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PriceMarket',
      theme: ThemeData(
        primaryColor: AppStyle.miColorPrimario,
        scaffoldBackgroundColor: AppStyle.backgroundColor,
        useMaterial3: true,
      ),
      home: Principal(),
    );
  }
}
