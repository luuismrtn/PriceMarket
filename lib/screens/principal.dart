import 'package:flutter/material.dart';
import 'package:price_market/objects/Clases.dart';
import 'package:price_market/objects/DatosManager.dart';
import '../objects/AppStyle.dart';
import '../objects/Producto.dart';
import '../components/formularioProducto.dart';
import '../components/drawerWidget.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<Principal> {
  String filtroOrden = 'Ninguno';

  List<Producto> listaProductos = [];
  List<Producto> productosFiltrados = [];
  List<String> listaCategorias = [];
  List<String> listaProductoMercadona = [];
  String filtroCategoria = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
  }

  void _filtrarProductos(String filtro) {
    setState(() {
      productosFiltrados = listaProductos
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
            titlePadding: const EdgeInsets.all(20),
            content: SingleChildScrollView(
              child: FormularioProducto(
                nombreController: nombreController,
                mercadonaController: mercadonaController,
                lidlController: lidlController,
                yukaMercadonaController: yukaMercadonaController,
                yukaLidlController: yukaLidlController,
                opinionMercadonaController: opinionMercadonaController,
                opinionLidlController: opinionLidlController,
                categoriaController: categoriaController,
                cantidadMercadonaController: cantidadMercadonaController,
                cantidadLidlController: cantidadLidlController,
                formKey: formKey,
              ),
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
                        final String nombre = nombreController.text;
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
                        final String opinionMercadona =
                            opinionMercadonaController.text.isNotEmpty
                                ? opinionMercadonaController.text
                                : '-1';
                        final String opinionLidl =
                            opinionLidlController.text.isNotEmpty
                                ? opinionLidlController.text
                                : '-1';

                        if (nombre.isNotEmpty) {
                          final Producto nuevoProducto = Producto(
                              id: 0,
                              nombre: nombre,
                              precios: [mercadona, lidl],
                              categoria: categoria,
                              cantidad: [cantidadMercadona, cantidadLidl],
                              yuka: [yukaMercadona, yukaLidl],
                              opinion: [opinionMercadona, opinionLidl],
                              fecha: DateTime.now());
                          listaProductos.add(nuevoProducto);
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
                  listaProductos.remove(producto);
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
                              producto.opinion[0] == '-1'
                                  ? 'No disponible'
                                  : producto.opinion[0],
                              style: const TextStyle(fontFamily: 'ProductSans'),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              producto.opinion[1] == '-1'
                                  ? 'No disponible'
                                  : producto.opinion[1],
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
            text: productosFiltrados[index].opinion[0] == '-1'
                ? ''
                : productosFiltrados[index].opinion[0]);
    final TextEditingController opinionLidlController = TextEditingController(
        text: productosFiltrados[index].opinion[1] == '-1'
            ? ''
            : productosFiltrados[index].opinion[1]);
    final formKey = GlobalKey<FormState>();

    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Editar Producto'),
          titlePadding: const EdgeInsets.all(20),
          content: SingleChildScrollView(
            child: FormularioProducto(
              nombreController: nombreController,
              mercadonaController: mercadonaController,
              lidlController: lidlController,
              yukaMercadonaController: yukaMercadonaController,
              yukaLidlController: yukaLidlController,
              opinionMercadonaController: opinionMercadonaController,
              opinionLidlController: opinionLidlController,
              categoriaController: categoriaController,
              cantidadMercadonaController: cantidadMercadonaController,
              cantidadLidlController: cantidadLidlController,
              formKey: formKey,
            ),
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
                        opinionMercadonaController.text.isNotEmpty
                            ? opinionMercadonaController.text
                            : '-1';
                    productosFiltrados[index].opinion[1] =
                        opinionLidlController.text.isNotEmpty
                            ? opinionLidlController.text
                            : '-1';
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
                      children: listaCategorias.map((categoria) {
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
                      children: OrdenOpciones.ordenOpciones.map((orden) {
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

  void _datosManager(String accion) async {
    if (accion == 'Exportar') {
      ImportadorExportadorDatos.exportDataToFile(listaProductos);
      ImportadorExportadorDatos.exportCategoriesToFile();
      ImportadorExportadorDatos.exportDataMercadonaToFile();
    } else if (accion == 'Importar') {
      listaProductos.clear();
      listaProductos = await ImportadorExportadorDatos.importDataFromFile();
      listaCategorias.clear();
      listaCategorias =
          await ImportadorExportadorDatos.importCategoriesFromFile(
              listaCategorias);
      listaProductoMercadona.clear();
      listaProductoMercadona =
          await ImportadorExportadorDatos.importDataMercadonaFromFile();
    } else if (accion == 'ImportarM') {
      await ImportadorExportadorDatos.convertDataToFile(listaProductoMercadona);
    }
  }

  Future<void> _actualizarPagina() async {
    _filtrarProductos('');
    _filtrarProductos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _agregarProductoNuevo();
          print(listaProductos.length);
          print(listaProductoMercadona.length);
        },
        backgroundColor: AppStyle.miColorPrimario,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          SliverAppBar(
              expandedHeight: 10.0,
              floating: false,
              pinned: true,
              title: GestureDetector(
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
              centerTitle: true,
              flexibleSpace: Padding(
                padding: const EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
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
                          PopupMenuItem(
                            child: const Text('Importar datos mercadona'),
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title:
                                        const Text('Importar datos mercadona'),
                                    content: const Text(
                                        '¿Está seguro de que desea importar datos del mercadona'),
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
                                            _datosManager('ImportarM');
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
              )),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Column(
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
                      itemCount: productosFiltrados.length%100,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Card(
                            surfaceTintColor:
                                const Color.fromARGB(255, 217, 212, 212),
                            child: InkWell(
                              onTap: () {
                                _mostrarInformacionProducto(
                                    productosFiltrados[index]);
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
                                        productosFiltrados[index].precios[0] ==
                                                -1
                                            ? 'No disponible'
                                            : '${productosFiltrados[index].precios[0].toStringAsFixed(2)}€',
                                        style: const TextStyle(
                                            color: Colors.green),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        productosFiltrados[index].precios[1] ==
                                                -1
                                            ? 'No disponible'
                                            : '${productosFiltrados[index].precios[1].toStringAsFixed(2)}€',
                                        style: const TextStyle(
                                            color:
                                                Color.fromARGB(255, 255, 0, 0)),
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
                );
              },
              childCount: 1, // Solo un elemento en este caso
            ),
          ),
        ],
      ),
    );
  }
}
