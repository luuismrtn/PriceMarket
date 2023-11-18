import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../objects/Clases.dart';
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
  final TextEditingController _mercadonaController = TextEditingController();
  final TextEditingController _lidlController = TextEditingController();
  final TextEditingController _yukaMercadonaController = TextEditingController();
  final TextEditingController _yukaLidlController = TextEditingController();
  String _selectedCategoria = Categorias.listaCategorias[0];

  final _formKey = GlobalKey<FormState>();

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
        child: Form(
          key: _formKey,
          child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextFormField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre del Producto',
                labelStyle: TextStyle(fontFamily: 'ProductSans'),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Por favor, ingrese un nombre.';
                }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _mercadonaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Mercadona',
                labelStyle: TextStyle(fontFamily: 'ProductSans'),
              ),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  try {
                  final intVal = int.parse(value);
                  if (intVal <= 0) {
                    return 'El producto no puede ser gratis.';
                  }
                } catch (e) {
                  return 'Ingrese un número válido.';
                }
                return null;
                  }
                return null;
              },
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _yukaMercadonaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Yuka Mercadona',
                labelStyle: TextStyle(fontFamily: 'ProductSans'),
              ),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  try {
                  final intVal = int.parse(value);
                  if (intVal < 0 || intVal > 100) {
                    return 'Ingrese un número entre 0 y 100.';
                  }
                } catch (e) {
                  return 'Ingrese un número válido.';
                }
                return null;
                  }
                return null;
                }
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _lidlController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Lidl',
                labelStyle: TextStyle(fontFamily: 'ProductSans'),
              ),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  try {
                  final intVal = int.parse(value);
                  if (intVal <= 0) {
                    return 'El producto no puede ser gratis.';
                  }
                } catch (e) {
                  return 'Ingrese un número válido.';
                }
                return null;
                  }
                return null;
                }
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _yukaLidlController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Yuka Lidl',
                labelStyle: TextStyle(fontFamily: 'ProductSans'),
              ),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  try {
                  final intVal = int.parse(value);
                  if (intVal < 0 || intVal > 100) {
                    return 'Ingrese un número entre 0 y 100.';
                  }
                } catch (e) {
                  return 'Ingrese un número válido.';
                }
                return null;
                  }
                return null;
                }
            ),
            const SizedBox(height: 16),
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
              hint: const Text('Seleccione una categoría',
                style: TextStyle(fontFamily: 'ProductSans'),
            ),
            ),
            const SizedBox(height: 16),
            FilledButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    Theme.of(context).primaryColor),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  _agregarProducto();
                }
              },
              child: const Text('Añadir Producto',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'ProductSans',
                ),
            ),
            )
          ],
        ),
        ),
      ),
    );
  }

  void _agregarProducto() {
    final String nombre = _nombreController.text.trim();
    final double mercadona = double.tryParse(_mercadonaController.text) ?? -1;
    final double lidl = double.tryParse(_lidlController.text) ?? -1;
    final int yukaMercadona = int.tryParse(_yukaMercadonaController.text) ?? -1;
    final int yukaLidl = int.tryParse(_yukaLidlController.text) ?? -1;

    if (nombre.isNotEmpty) {
      final Producto nuevoProducto = Producto(
        nombre: nombre,
        precios: [mercadona, lidl],
        categoria: _selectedCategoria, id: 0,
        yuka: [yukaMercadona, yukaLidl],
      );

      widget.onProductoAgregado(nuevoProducto);
      Navigator.pop(context);
    }
  }
}
