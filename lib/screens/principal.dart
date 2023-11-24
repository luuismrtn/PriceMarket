import 'package:flutter/material.dart';
import 'package:price_market/objects/Clases.dart';
import 'package:price_market/objects/DatosManager.dart';
import 'package:price_market/objects/ListaProdutos.dart';
import '../objects/AppStyle.dart';
import '../objects/Producto.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<Principal> {
  List<String> ordenOpciones = [
    'Menor Precio',
    'Mayor Precio',
    'Menor Yuka',
    'Mayor Yuka'
  ];

  List<String> opiniones = [
    'Increíble',
    'Me gusta',
    'Sin más',
    'No me gusta',
    'Horrible'
  ];

  String filtroOrden = 'Ninguno';

  final String version = '1.0.5';

  ListaProducto listaProductos = ListaProducto(productos: []);
  List<Producto> productosFiltrados = [];
  String filtroCategoria = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    productosFiltrados = listaProductos.productos;
  }

  void _filtrarProductos(String filtro) {
    setState(() {
      productosFiltrados = listaProductos.productos
          .where((producto) =>
              producto.nombre.toLowerCase().contains(filtro.toLowerCase()) &&
              (filtroCategoria.isEmpty ||
                  producto.categoria == filtroCategoria))
          .toList();

      if (filtroOrden == 'Menor Precio') {
        productosFiltrados.sort((a, b) => (a.precios
                    .reduce((value, element) => value + element) /
                a.precios.length)
            .compareTo((b.precios.reduce((value, element) => value + element) /
                b.precios.length)));
      } else if (filtroOrden == 'Mayor Precio') {
        productosFiltrados.sort((a, b) => (b.precios
                    .reduce((value, element) => value + element) /
                b.precios.length)
            .compareTo((a.precios.reduce((value, element) => value + element) /
                a.precios.length)));
      } else if (filtroOrden == 'Menor Yuka') {
        productosFiltrados.sort((a, b) =>
            (a.yuka.reduce((value, element) => value + element) / a.yuka.length)
                .compareTo(b.yuka.reduce((value, element) => value + element) /
                    b.yuka.length));
      } else if (filtroOrden == 'Mayor Yuka') {
        productosFiltrados.sort((a, b) =>
            (b.yuka.reduce((value, element) => value + element) / b.yuka.length)
                .compareTo(a.yuka.reduce((value, element) => value + element) /
                    a.yuka.length));
      }
    });
  }

  Form formularioProducto(
      TextEditingController nombreController,
      TextEditingController mercadonaController,
      TextEditingController lidlController,
      TextEditingController yukaMercadonaController,
      TextEditingController yukaLidlController,
      TextEditingController opinionMercadonaController,
      TextEditingController opinionLidlController,
      TextEditingController categoriaController,
      TextEditingController cantidadMercadonaController,
      TextEditingController cantidadLidlController,
      GlobalKey<FormState> formKey) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: nombreController,
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
          TextFormField(
            controller: mercadonaController,
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
          const SizedBox(width: 8),
          TextFormField(
            controller: cantidadMercadonaController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Cantidad Mercadona',
              labelStyle: TextStyle(fontFamily: 'ProductSans'),
            ),
          ),
          const SizedBox(height: 8),
          TextFormField(
              controller: yukaMercadonaController,
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
          const SizedBox(width: 8),
          TextFormField(
              controller: opinionMercadonaController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Opinión Mercadona',
                labelStyle: TextStyle(fontFamily: 'ProductSans'),
              ),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  try {
                    final intVal = double.parse(value);
                    if (intVal < -1 || intVal > 100) {
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
          TextFormField(
              controller: lidlController,
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
          const SizedBox(width: 8),
          TextFormField(
              controller: cantidadLidlController,
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
              controller: yukaLidlController,
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
          const SizedBox(width: 8),
          TextFormField(
              controller: opinionLidlController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Opinión Lidl',
                labelStyle: TextStyle(fontFamily: 'ProductSans'),
              ),
              validator: (value) {
                if (value != null && value.isNotEmpty) {
                  try {
                    final intVal = int.parse(value);
                    if (intVal < -1 || intVal > 100) {
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
            items: Categorias.listaCategorias
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value,
                    style: const TextStyle(fontFamily: 'ProductSans')),
              );
            }).toList(),
            value: categoriaController.text.isNotEmpty
                ? categoriaController.text
                : null,
            hint: const Text(
              'Seleccione una categoría',
              style: TextStyle(fontFamily: 'ProductSans'),
            ),
            onChanged: (String? newValue) {
              setState(() {
                categoriaController.text = newValue!;
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

  void _agregarProductoNuevo() {
    final TextEditingController nombreController = TextEditingController();
    final TextEditingController mercadonaController = TextEditingController();
    final TextEditingController lidlController = TextEditingController();
    final TextEditingController yukaMercadonaController =
        TextEditingController();
    final TextEditingController yukaLidlController = TextEditingController();
    final TextEditingController opinionMercadonaController =
        TextEditingController();
    final TextEditingController opinionLidlController = TextEditingController();
    final TextEditingController categoriaController = TextEditingController();
    final TextEditingController cantidadMercadonaController =
        TextEditingController();
    final TextEditingController cantidadLidlController =
        TextEditingController();

    final formKey = GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Añadir Producto'),
            titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
            content: SingleChildScrollView(
              child: formularioProducto(
                  nombreController,
                  mercadonaController,
                  lidlController,
                  yukaMercadonaController,
                  yukaLidlController,
                  opinionMercadonaController,
                  opinionLidlController,
                  categoriaController,
                  cantidadMercadonaController,
                  cantidadLidlController,
                  formKey),
            ),
            contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancelar'),
              ),
              TextButton(
                onPressed: () {
                  setState(
                    () {
                      if (formKey.currentState!.validate()) {
                        final String nombre = nombreController.text.trim();
                        final double mercadona =
                            double.tryParse(mercadonaController.text) ?? -1;
                        final double lidl =
                            double.tryParse(lidlController.text) ?? -1;
                        final int yukaMercadona =
                            int.tryParse(yukaMercadonaController.text) ?? -1;
                        final int yukaLidl =
                            int.tryParse(yukaLidlController.text) ?? -1;
                        final String categoria =
                            categoriaController.text.trim();
                        final String cantidadMercadona =
                            cantidadMercadonaController.text.isNotEmpty
                                ? cantidadMercadonaController.text
                                : '-1';
                        final String cantidadLidl =
                            cantidadLidlController.text.isNotEmpty
                                ? cantidadLidlController.text
                                : '-1';
                        final int opinionMercadona =
                            int.tryParse(opinionMercadonaController.text) ?? -1;
                        final int opinionLidl =
                            int.tryParse(opinionLidlController.text) ?? -1;

                        if (nombre.isNotEmpty) {
                          final Producto nuevoProducto = Producto(
                            nombre: nombre,
                            precios: [mercadona, lidl],
                            categoria: categoria,
                            cantidad: [cantidadMercadona, cantidadLidl],
                            yuka: [yukaMercadona, yukaLidl],
                            opinion: [opinionMercadona, opinionLidl],
                            fecha: DateTime.now(),
                          );
                          listaProductos.productos.add(nuevoProducto);
                          _datosManager('Exportar');
                          _actualizarPagina();
                          Navigator.pop(context);
                        }
                      }
                    },
                  );
                },
                child: const Text('Guardar'),
              ),
            ],
          );
        });
  }

  void _eliminarProducto(Producto producto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar Producto'),
          content:
              const Text('¿Está seguro de que desea eliminar este producto?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  listaProductos.productos.remove(producto);
                  _datosManager('Exportar');
                  _actualizarPagina();
                  Navigator.pop(context);
                });
              },
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarInformacionProducto(Producto producto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Información del Producto'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  producto.nombre,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      fontFamily: 'ProductSans'),
                ),
                const SizedBox(height: 16),
                if (producto.imagen != "")
                  Column(
                    children: [
                      Image.network(
                        producto.imagen,
                        height: 100,
                        width: 100,
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                Table(
                  columnWidths: const {
                    0: FlexColumnWidth(2),
                    1: FlexColumnWidth(2),
                    2: FlexColumnWidth(2),
                  },
                  border: TableBorder.all(
                    color: Colors.black,
                    width: 1,
                  ),
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    const TableRow(
                      children: [
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text(
                              'Super',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: 'ProductSans'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Mercadona'),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Lidl'),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Precio',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'ProductSans')),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              producto.precios[0] == -1
                                  ? 'No disponible'
                                  : '${producto.precios[0].toStringAsFixed(2)}€',
                              style: const TextStyle(fontFamily: 'ProductSans'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              producto.precios[1] == -1
                                  ? 'No disponible'
                                  : '${producto.precios[1].toStringAsFixed(2)}€',
                              style: const TextStyle(fontFamily: 'ProductSans'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Cantidad',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'ProductSans')),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              producto.cantidad[0] == '-1'
                                  ? 'No disponible'
                                  : producto.cantidad[0],
                              style: const TextStyle(fontFamily: 'ProductSans'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              producto.cantidad[1] == '-1'
                                  ? 'No disponible'
                                  : producto.cantidad[1],
                              style: const TextStyle(fontFamily: 'ProductSans'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Yuka',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'ProductSans')),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              producto.yuka[0] == -1
                                  ? 'No disponible'
                                  : producto.yuka[0] == -2
                                      ? 'No tiene'
                                      : '${producto.yuka[0]}',
                              style: const TextStyle(fontFamily: 'ProductSans'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              producto.yuka[1] == -1
                                  ? 'No disponible'
                                  : producto.yuka[1] == -2
                                      ? 'No tiene'
                                      : '${producto.yuka[1]}',
                              style: const TextStyle(fontFamily: 'ProductSans'),
                            ),
                          ),
                        ),
                      ],
                    ),
                    TableRow(
                      children: [
                        const TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Text('Opinión',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'ProductSans')),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              producto.opinion[0] == -1
                                  ? 'No disponible'
                                  : '${producto.opinion[0]}',
                              style: const TextStyle(fontFamily: 'ProductSans'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              producto.opinion[1] == -1
                                  ? 'No disponible'
                                  : '${producto.opinion[1]}',
                              style: const TextStyle(fontFamily: 'ProductSans'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  'Categoría: ${producto.categoria}',
                  style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      fontFamily: 'ProductSans'),
                ),
                const SizedBox(height: 16),
                Text(
                  'Última modificación: ${producto.fecha.day}/${producto.fecha.month}/${producto.fecha.year}',
                  style: const TextStyle(fontSize: 10),
                ),
              ],
            ),
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
  }

  void _editarProducto(int index) async {
    final TextEditingController nombreController =
        TextEditingController(text: productosFiltrados[index].nombre);

    final TextEditingController mercadonaController = TextEditingController(
        text: productosFiltrados[index].precios[0] == -1
            ? ''
            : '${productosFiltrados[index].precios[0]}');
    final TextEditingController lidlController = TextEditingController(
        text: productosFiltrados[index].precios[1] == -1
            ? ''
            : '${productosFiltrados[index].precios[1]}');
    final TextEditingController yukaMercadonaController = TextEditingController(
        text: productosFiltrados[index].yuka[0] == -1
            ? ''
            : '${productosFiltrados[index].yuka[0]}');
    final TextEditingController yukaLidlController = TextEditingController(
        text: productosFiltrados[index].yuka[1] == -1
            ? ''
            : '${productosFiltrados[index].yuka[1]}');
    final TextEditingController categoriaController =
        TextEditingController(text: productosFiltrados[index].categoria);
    final TextEditingController cantidadMercadonaController =
        TextEditingController(
            text: productosFiltrados[index].cantidad[0] == '-1'
                ? ''
                : productosFiltrados[index].cantidad[0]);
    final TextEditingController cantidadLidlController = TextEditingController(
        text: productosFiltrados[index].cantidad[1] == '-1'
            ? ''
            : productosFiltrados[index].cantidad[1]);
    final TextEditingController opinionMercadonaController =
        TextEditingController(
            text: productosFiltrados[index].opinion[0] == -1
                ? ''
                : '${productosFiltrados[index].opinion[0]}');
    final TextEditingController opinionLidlController = TextEditingController(
        text: productosFiltrados[index].opinion[1] == -1
            ? ''
            : '${productosFiltrados[index].opinion[1]}');
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Producto'),
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
          content: SingleChildScrollView(
            child: formularioProducto(
                nombreController,
                mercadonaController,
                lidlController,
                yukaMercadonaController,
                yukaLidlController,
                opinionMercadonaController,
                opinionLidlController,
                categoriaController,
                cantidadMercadonaController,
                cantidadLidlController,
                formKey),
          ),
          contentPadding: const EdgeInsets.fromLTRB(20, 5, 20, 20),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  if (formKey.currentState!.validate()) {
                    productosFiltrados[index].nombre = nombreController.text;
                    productosFiltrados[index].precios[0] =
                        double.tryParse(mercadonaController.text) ?? -1;
                    productosFiltrados[index].precios[1] =
                        double.tryParse(lidlController.text) ?? -1;
                    productosFiltrados[index].yuka[0] =
                        int.tryParse(yukaMercadonaController.text) ?? -1;
                    productosFiltrados[index].yuka[1] =
                        int.tryParse(yukaLidlController.text) ?? -1;
                    productosFiltrados[index].categoria =
                        categoriaController.text;
                    productosFiltrados[index].cantidad[0] =
                        cantidadMercadonaController.text.isNotEmpty
                            ? cantidadMercadonaController.text
                            : '-1';
                    productosFiltrados[index].cantidad[1] =
                        cantidadLidlController.text.isNotEmpty
                            ? cantidadLidlController.text
                            : '-1';
                    productosFiltrados[index].opinion[0] =
                        int.tryParse(opinionMercadonaController.text) ?? -1;
                    productosFiltrados[index].opinion[1] =
                        int.tryParse(opinionLidlController.text) ?? -1;
                    productosFiltrados[index].fecha = DateTime.now();
                    _datosManager('Exportar');
                    _actualizarPagina();
                    Navigator.pop(context);
                  }
                });
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }

  void _mostrarFiltrosDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              title: const Text('Filtros'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Categorías: ',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      children: Categorias.listaCategorias.map((categoria) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: FilterChip(
                            label: Text(categoria),
                            selected: filtroCategoria == categoria,
                            onSelected: (selected) {
                              setState(() {
                                filtroCategoria = selected ? categoria : '';
                                _filtrarProductos('');
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8),
                      child: Divider(
                        color: Colors.black,
                        height: 10,
                      ),
                    ),
                    const Text(
                      'Ordenar por: ',
                      style: TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 20,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Wrap(
                      children: ordenOpciones.map((orden) {
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: FilterChip(
                            label: Text(orden),
                            selected: filtroOrden == orden,
                            onSelected: (selected) {
                              setState(() {
                                filtroOrden = selected ? orden : '';
                                _filtrarProductos('');
                              });
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ],
                ),
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
    );
  }

  void _datosManager(String accion) {
    if (accion == 'Exportar') {
      ImportadorExportadorDatos.exportDataToFile(listaProductos.productos);
    } else if (accion == 'Importar') {
      ImportadorExportadorDatos.importDataFromFile(listaProductos.productos);
    }
  }

  Future<void> _actualizarPagina() async {
    _filtrarProductos('');
    _filtrarProductos;
  }

  Drawer DrawerWidget() {
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
              Navigator.pop(context);
              // Código para la acción al hacer clic en "Inicio"
            },
          ),
          ListTile(
            leading: const Icon(Icons.settings),
            title: const Text('Configuración'),
            onTap: () {
              Navigator.pop(context);
              // Código para la acción al hacer clic en "Configuración"
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
                    content: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text('Aplicación desarrollada por',
                            style: TextStyle(fontFamily: 'ProductSans')),
                        const Text('Luis Martín García',
                            style: TextStyle(
                                fontFamily: 'ProductSans',
                                fontWeight: FontWeight.bold)),
                        const SizedBox(height: 10),
                        const Text('Price Market',
                            style: TextStyle(fontFamily: 'ProductSans')),
                        Text('Versión: $version',
                            style: const TextStyle(fontFamily: 'ProductSans')),
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        elevation: 2,
        iconTheme: const IconThemeData(color: AppStyle.miColorPrimario),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            GestureDetector(
              onTap: () {
                _actualizarPagina();
                _scrollController.animateTo(0,
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut);
              },
              child: const Text(
                'Price Market',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppStyle.miColorPrimario,
                ),
              ),
            ),
            const Spacer(),
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: const Text('Importar datos'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Importar datos'),
                            content: const Text(
                                '¿Está seguro de que desea importar los datos?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _datosManager('Importar');
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text('Importar datos'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  PopupMenuItem(
                    child: const Text('Exportar datos'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Exportar datos'),
                            content: const Text(
                                '¿Está seguro de que desea exportar los datos?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () {
                                  setState(() {
                                    _datosManager('Exportar');
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text('Exportar datos'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ];
              },
            ),
          ],
        ),
      ),
      drawer: DrawerWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _agregarProductoNuevo();
        },
        backgroundColor: AppStyle.miColorPrimario,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      onChanged: _filtrarProductos,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Buscar producto',
                        prefixIcon: Icon(Icons.search),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: _mostrarFiltrosDialog,
                    icon: const Icon(Icons.filter_list),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(28, 8, 35, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      'Nombre',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Mercadona',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      'Lidl',
                      style: TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: productosFiltrados.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: Card(
                    surfaceTintColor: const Color.fromARGB(255, 217, 212, 212),
                    child: InkWell(
                      onTap: () {
                        _mostrarInformacionProducto(productosFiltrados[index]);
                      },
                      onLongPress: () {
                        _editarProducto(index);
                      },
                      onDoubleTap: () {
                        _eliminarProducto(productosFiltrados[index]);
                      },
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                productosFiltrados[index].nombre,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                productosFiltrados[index].precios[0] == -1
                                    ? 'No disponible'
                                    : '${productosFiltrados[index].precios[0].toStringAsFixed(2)}€',
                                style: const TextStyle(color: Colors.green),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                productosFiltrados[index].precios[1] == -1
                                    ? 'No disponible'
                                    : '${productosFiltrados[index].precios[1].toStringAsFixed(2)}€',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 0, 0)),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
