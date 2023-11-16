import 'package:flutter/material.dart';
import '../objects/Categorias.dart';
import '../objects/Producto.dart';
import '../objects/AppStyle.dart';

class FormularioProducto extends StatefulWidget {
  final Function(Producto) onProductoAgregado;

  const FormularioProducto({Key? key, required this.onProductoAgregado})
      : super(key: key);

  @override
  _FormularioProductoState createState() => _FormularioProductoState();
}

class _FormularioProductoState extends State<FormularioProducto> {
  final TextEditingController _nombreController = TextEditingController();
  final TextEditingController _precio1Controller = TextEditingController();
  final TextEditingController _precio2Controller = TextEditingController();
  String _selectedCategoria = Categorias.listaCategorias[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 5,
        elevation: 2,
        iconTheme: const IconThemeData(color: AppStyle.miColorPrimario),
        backgroundColor: Colors.white,
        title: const Text(
              'Añadir Producto',
              style: TextStyle(
                  color: AppStyle.miColorPrimario,
                  fontFamily: 'ProductSans',
              ),
            ),
        ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _nombreController,
              style: const TextStyle(
                fontFamily: 'ProductSans',
              ),
              decoration: const InputDecoration(labelText: 'Nombre del Producto',
                  labelStyle: TextStyle(fontFamily: 'ProductSans'),
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _precio1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Precio 1'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _precio2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Precio 2'),
            ),
            SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedCategoria,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategoria = newValue!;
                });
              },
              items: Categorias.listaCategorias
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              hint: const Text('Seleccione una categoría'),
            ),
            SizedBox(height: 16),
            FilledButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor),
              ),
              onPressed: () {
                _agregarProducto();
              },
              child: const Text('Añadir Producto'),
            ),
          ],
        ),
      ),
    );
  }

  void _agregarProducto() {
    final String nombre = _nombreController.text.trim();
    final double precio1 = double.tryParse(_precio1Controller.text) ?? 0.0;
    final double precio2 = double.tryParse(_precio2Controller.text) ?? 0.0;

    if (nombre.isNotEmpty) {
      final Producto nuevoProducto = Producto(
        nombre: nombre,
        precios: [precio1, precio2],
        categoria: _selectedCategoria, id: 0,
      );

      widget.onProductoAgregado(nuevoProducto);
      Navigator.pop(context);
    }
  }
}
