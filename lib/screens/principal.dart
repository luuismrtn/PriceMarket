import 'package:flutter/material.dart';
import 'package:price_market/objects/Clases.dart';
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
  String filtroOrden = 'Ninguno';
  List<Producto> productos = [
    Producto(
      id: 1,
      nombre: 'Coca Cola',
      precios: [1.5, 2.0],
      categoria: 'Bebidas',
      yuka: [6, 2],
      imagen:
          "https://sgfm.elcorteingles.es/SGFM/dctm/MEDIA03/202109/28/00118622300228____23__600x600",
      fecha: DateTime.now(),
    ),
    Producto(
      id: 2,
      nombre: 'Pepsi',
      precios: [1.6, 1.0],
      categoria: 'Bebidas',
      yuka: [0, 0],
      fecha: DateTime.now(),
    ),
    Producto(
      id: 3,
      nombre: 'Fanta',
      precios: [1.4, 0.2],
      categoria: 'Bebidas',
      yuka: [30, 98],
      fecha: DateTime.now(),
    ),
    Producto(
      id: 4,
      nombre: 'Cerveza',
      precios: [1.5, 2.0],
      categoria: 'Bebidas',
      yuka: [20, 28],
      fecha: DateTime.now(),
    ),
    Producto(
      id: 5,
      nombre: 'Agua',
      precios: [1.6, 2.3],
      categoria: 'Bebidas',
      yuka: [100, 88],
      fecha: DateTime.now(),
    ),
    Producto(
      id: 6,
      nombre: 'Leche',
      precios: [132, 28],
      categoria: 'Alimentación',
      yuka: [80, 28],
      fecha: DateTime.now(),
    ),
  ];
  List<Producto> productosFiltrados = [];
  String filtroCategoria = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    productosFiltrados = List.from(productos);
  }

  void _filtrarProductos(String filtro) {
  setState(() {
    productosFiltrados = productos
        .where((producto) =>
            producto.nombre.toLowerCase().contains(filtro.toLowerCase()) &&
            (filtroCategoria.isEmpty || producto.categoria == filtroCategoria))
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
          (a.yuka.reduce((value, element) => value + element) /
              a.yuka.length)
              .compareTo(
              b.yuka.reduce((value, element) => value + element) /
                  b.yuka.length));
    } else if (filtroOrden == 'Mayor Yuka') {
      productosFiltrados.sort((a, b) =>
          (b.yuka.reduce((value, element) => value + element) /
              b.yuka.length)
              .compareTo(
              a.yuka.reduce((value, element) => value + element) /
                  a.yuka.length));
    }
  });
}

  Form formularioProducto(TextEditingController _nombreController, TextEditingController _mercadonaController,
      TextEditingController _lidlController, TextEditingController _yukaMercadonaController,
      TextEditingController _yukaLidlController, TextEditingController _categoriaController, GlobalKey<FormState> _formKey) {
    return Form(
      key: _formKey,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: _nombreController,
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
            controller: _mercadonaController,
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
              controller: _yukaMercadonaController,
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
                    if (intVal < 0 || intVal > 100) {
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
              controller: _lidlController,
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
              controller: _yukaLidlController,
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
                    if (intVal < 0 || intVal > 100) {
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
                child: Text(value, style: const TextStyle(fontFamily: 'ProductSans')),
              );
            }).toList(),
            value: _categoriaController.text.isNotEmpty ? _categoriaController.text : null,
            hint: const Text(
              'Seleccione una categoría',
              style: TextStyle(fontFamily: 'ProductSans'),
            ),
            onChanged: (String? newValue) {
              setState(() {
                _categoriaController.text = newValue!;
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
    final TextEditingController categoriaController = TextEditingController();

    final formKey = GlobalKey<FormState>();

    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Añadir Producto'),
            titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
            content: formularioProducto(
                nombreController,
                mercadonaController,
                lidlController,
                yukaMercadonaController,
                yukaLidlController,
                categoriaController,
                formKey),
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
                        final String categoria = categoriaController.text.trim();

                        if (nombre.isNotEmpty) {
                          final Producto nuevoProducto = Producto(
                            nombre: nombre,
                            precios: [mercadona, lidl],
                            categoria: categoria,
                            id: 0,
                            yuka: [yukaMercadona, yukaLidl],
                            fecha: DateTime.now(),
                          );
                          productos.add(nuevoProducto);
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

  void _mostrarInformacionProducto(Producto producto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Información del Producto'),
          content: Column(
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
                                : '${producto.precios[0]}€',
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
                                : '${producto.precios[1]}€',
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
                                : '${producto.yuka[1]}',
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
                style: const TextStyle(
                    fontSize: 10),
              ),
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
    final TextEditingController yukaMercadonaController =
        TextEditingController(
            text: productosFiltrados[index].yuka[0] == -1
                ? ''
                : '${productosFiltrados[index].yuka[0]}');
    final TextEditingController yukaLidlController = TextEditingController(
        text: productosFiltrados[index].yuka[1] == -1
            ? ''
            : '${productosFiltrados[index].yuka[1]}');
    final TextEditingController categoriaController = TextEditingController(
        text: productosFiltrados[index].categoria);

    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Producto'),
          titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
          content: formularioProducto(
              nombreController,
              mercadonaController,
              lidlController,
              yukaMercadonaController,
              yukaLidlController,
              categoriaController,
              formKey),
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
                    productosFiltrados[index].categoria = categoriaController.text;
                    Navigator.pop(context);
                    productosFiltrados[index].fecha = DateTime.now();
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
              content: Column(
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
      title: GestureDetector(
          onTap: () {
            // Cuando se toca el AppBar, se desplaza al principio.
            _scrollController.animateTo(0,
                duration: const Duration(milliseconds: 500), curve: Curves.easeInOut);
          },
          child: const Row(
            children: [
              Spacer(),
              Text(
                'Price Market',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: AppStyle.miColorPrimario,
                ),
              ),
              Spacer(),
            ],
          )
        ),
    ),
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
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Guardar datos'),
            ),
          ),
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
                                  : '${productosFiltrados[index].precios[0]}€',
                              style: const TextStyle(color: Colors.green),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              productosFiltrados[index].precios[1] == -1
                                  ? 'No disponible'
                                  : '${productosFiltrados[index].precios[1]}€',
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
