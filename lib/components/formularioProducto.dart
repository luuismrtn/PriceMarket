import 'package:flutter/material.dart';
import 'package:price_market/objects/Clases.dart';

class FormularioProducto extends StatefulWidget {
  final TextEditingController nombreController;
  final TextEditingController mercadonaController;
  final TextEditingController lidlController;
  final TextEditingController yukaMercadonaController;
  final TextEditingController yukaLidlController;
  final TextEditingController opinionMercadonaController;
  final TextEditingController opinionLidlController;
  final TextEditingController categoriaController;
  final TextEditingController cantidadMercadonaController;
  final TextEditingController cantidadLidlController;
  final GlobalKey<FormState> formKey;

  const FormularioProducto({
    required this.nombreController,
    required this.mercadonaController,
    required this.lidlController,
    required this.yukaMercadonaController,
    required this.yukaLidlController,
    required this.opinionMercadonaController,
    required this.opinionLidlController,
    required this.categoriaController,
    required this.cantidadMercadonaController,
    required this.cantidadLidlController,
    required this.formKey,
  });

  @override
  _FormularioProductoState createState() => _FormularioProductoState();
}

class _FormularioProductoState extends State<FormularioProducto> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: widget.nombreController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Nombre del Producto',
              labelStyle: TextStyle(fontFamily: 'ProductSans'),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, ingrese un nombre.';
              }
              return null;
            },
          ),
          const SizedBox(height: 8),
          ExpansionTile(
              shape: BeveledRectangleBorder(
                borderRadius: BorderRadius.circular(5),
              ),
              tilePadding: const EdgeInsets.all(8),
              title: const Text('Mercadona',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ProductSans',
                  )),
              children: [
                const SizedBox(height: 8),
                TextFormField(
                  controller: widget.mercadonaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Precio Mercadona',
                    labelStyle: TextStyle(fontFamily: 'ProductSans'),
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      try {
                        final intVal = double.parse(value);
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
                const SizedBox(height: 8),
                TextFormField(
                  controller: widget.cantidadMercadonaController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Cantidad Mercadona',
                    labelStyle: TextStyle(fontFamily: 'ProductSans'),
                  ),
                ),
                const SizedBox(height: 8),
                TextFormField(
                    controller: widget.yukaMercadonaController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Yuka Mercadona',
                      labelStyle: TextStyle(fontFamily: 'ProductSans'),
                    ),
                    validator: (value) {
                      if (value != null && value.isNotEmpty) {
                        try {
                          final intVal = double.parse(value);
                          if (intVal < -2 || intVal > 100) {
                            return 'Ingrese un número entre 0 y 100.';
                          }
                        } catch (e) {
                          return 'Ingrese un número válido.';
                        }
                        return null;
                      }
                      return null;
                    }),
                const SizedBox(height: 8),
                DropdownButtonFormField(
                  items: Opiniones.opiniones
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value,
                          style: const TextStyle(fontFamily: 'ProductSans')),
                    );
                  }).toList(),
                  value: widget.opinionMercadonaController.text.isNotEmpty
                      ? widget.opinionMercadonaController.text
                      : null,
                  hint: const Text(
                    'Seleccione una opinión',
                    style: TextStyle(fontFamily: 'ProductSans'),
                  ),
                  onChanged: (String? newValue) {
                    setState(() {
                      widget.opinionMercadonaController.text = newValue!;
                    });
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Opinión',
                    labelStyle: TextStyle(fontFamily: 'ProductSans'),
                  ),
                  icon: const Icon(Icons.expand_more),
                ),
                const SizedBox(height: 8),
              ]),
          const SizedBox(height: 8),
          ExpansionTile(
            shape: BeveledRectangleBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            tilePadding: const EdgeInsets.all(8),
            title: const Text('Lidl',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ProductSans',
                )),
            children: [
              const SizedBox(height: 8),
              TextFormField(
                  controller: widget.lidlController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Precio Lidl',
                    labelStyle: TextStyle(fontFamily: 'ProductSans'),
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      try {
                        final intVal = double.parse(value);
                        if (intVal <= 0) {
                          return 'El producto no puede ser gratis.';
                        }
                      } catch (e) {
                        return 'Ingrese un número válido.';
                      }
                      return null;
                    }
                    return null;
                  }),
              const SizedBox(height: 8),
              TextFormField(
                  controller: widget.cantidadLidlController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Cantidad Lidl',
                    labelStyle: TextStyle(fontFamily: 'ProductSans'),
                  ),
                  validator: (value) {
                    return null;
                  }),
              const SizedBox(height: 8),
              TextFormField(
                  controller: widget.yukaLidlController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Yuka Lidl',
                    labelStyle: TextStyle(fontFamily: 'ProductSans'),
                  ),
                  validator: (value) {
                    if (value != null && value.isNotEmpty) {
                      try {
                        final intVal = int.parse(value);
                        if (intVal < -2 || intVal > 100) {
                          return 'Ingrese un número entre 0 y 100.';
                        }
                      } catch (e) {
                        return 'Ingrese un número válido.';
                      }
                      return null;
                    }
                    return null;
                  }),
              const SizedBox(height: 8),
              DropdownButtonFormField(
                items: Opiniones.opiniones
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value,
                        style: const TextStyle(fontFamily: 'ProductSans')),
                  );
                }).toList(),
                value: widget.opinionLidlController.text.isNotEmpty
                    ? widget.opinionLidlController.text
                    : null,
                hint: const Text(
                  'Seleccione una opinión',
                  style: TextStyle(fontFamily: 'ProductSans'),
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    widget.opinionLidlController.text = newValue!;
                  });
                },
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Opinión',
                  labelStyle: TextStyle(fontFamily: 'ProductSans'),
                ),
                icon: const Icon(Icons.expand_more),
              ),
              const SizedBox(height: 8),
            ],
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField(
            items: Categorias.listaCategorias
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                    style: const TextStyle(fontFamily: 'ProductSans')),
              );
            }).toList(),
            value: widget.categoriaController.text.isNotEmpty
                ? widget.categoriaController.text
                : null,
            hint: const Text(
              'Seleccione una categoría',
              style: TextStyle(fontFamily: 'ProductSans'),
            ),
            onChanged: (String? newValue) {
              setState(() {
                widget.categoriaController.text = newValue!;
              });
            },
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Categoría',
              labelStyle: TextStyle(fontFamily: 'ProductSans'),
            ),
            icon: const Icon(Icons.expand_more),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Por favor, elija una categoría.';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
