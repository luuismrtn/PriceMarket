import 'dart:async';

import 'package:flutter/material.dart';
import 'package:price_market/components/ProductoDialog.dart';
import 'package:price_market/objects/Clases.dart';
import 'package:price_market/objects/DatosManager.dart';
import 'package:price_market/screens/settings.dart';
import '../objects/AppStyle.dart';
import '../objects/Producto.dart';
import '../components/formularioProducto.dart';
import '../components/drawerWidget.dart';

class Principal extends StatefulWidget {
  Principal({Key? key}) : super(key: key);

  @override
  _MyScreenState createState() => _MyScreenState();

  static List<Producto> listaProductos = [];
  static List<Producto> productosFiltrados = [];
  static List<String> listaCategorias = [];
  static List<String> listaProductoMercadona = [];
  static String filtroOrden = 'Ninguno';
  static String filtroCategoria = '';
  final ScrollController _scrollController = ScrollController();

  static void datosManager(String accion) async {
    switch (accion) {
      case 'Importar Datos.txt':
        Principal.listaProductos.clear();
        Principal.listaProductos =
            await ImportadorExportadorDatos.importDataFromFile();
        break;
      case 'Exportar Datos.txt':
        ImportadorExportadorDatos.exportDataToFile(Principal.listaProductos);
        break;
      case 'Importar categorias':
        Principal.listaCategorias.clear();
        Principal.listaCategorias =
            await ImportadorExportadorDatos.importCategoriesFromFile(
                Principal.listaCategorias);
        break;
      case 'Exportar categorias':
        ImportadorExportadorDatos.exportCategoriesToFile();
        break;
      case 'Importar API mercadona':
        Principal.listaProductoMercadona.clear();
        Principal.listaProductoMercadona =
            await ImportadorExportadorDatos.importDataMercadonaFromFile();
        break;
      case 'Combinar datos':
        await ImportadorExportadorDatos.combinarDatos(
            Principal.listaProductos, Principal.listaProductoMercadona);
        break;
      case 'Importar datosMIOS.txt':
        Principal.listaProductos.clear();
        Principal.listaProductos =
            await ImportadorExportadorDatos.importDataMIOFromFile();
        break;
      case 'Exportar datosMIOS.txt':
        ImportadorExportadorDatos.exportDataMIOFromFile(
            Principal.listaProductos);
        break;
    }
  }

  static List<Producto> getListaProductos() {
    return listaProductos;
  }

  void setListaProductos(List<Producto> lista) {
    listaProductos = lista;
  }

  static List<String> getListaCategorias() {
    return listaCategorias;
  }
}

class _MyScreenState extends State<Principal> {
  @override
  void initState() {
    super.initState();
    Principal.datosManager('Importar categorias');
    Principal.datosManager('Importar datosMIOS.txt');
  }

  void _filtrarProductos(String filtro) {
    setState(() {
      Principal.productosFiltrados = Principal.listaProductos
          .where((producto) =>
              producto.nombre.toLowerCase().contains(filtro.toLowerCase()) &&
              (Principal.filtroCategoria.isEmpty ||
                  producto.categoria == Principal.filtroCategoria))
          .toList();

      if (Principal.filtroOrden == 'Menor Precio') {
        Principal.productosFiltrados.sort((a, b) => (a.precios
                    .reduce((value, element) => value + element) /
                a.precios.length)
            .compareTo((b.precios.reduce((value, element) => value + element) /
                b.precios.length)));
      } else if (Principal.filtroOrden == 'Mayor Precio') {
        Principal.productosFiltrados.sort((a, b) => (b.precios
                    .reduce((value, element) => value + element) /
                b.precios.length)
            .compareTo((a.precios.reduce((value, element) => value + element) /
                a.precios.length)));
      } else if (Principal.filtroOrden == 'Menor Yuka') {
        Principal.productosFiltrados.sort((a, b) =>
            (a.yuka.reduce((value, element) => value + element) / a.yuka.length)
                .compareTo(b.yuka.reduce((value, element) => value + element) /
                    b.yuka.length));
      } else if (Principal.filtroOrden == 'Mayor Yuka') {
        Principal.productosFiltrados.sort((a, b) =>
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
                          Principal.listaProductos.add(nuevoProducto);
                          Principal.datosManager('Exportar datosMIOS.txt');
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
                  Principal.listaProductos.remove(producto);
                  Principal.datosManager('Exportar datosMIOS.txt');
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
        return ProductoDialog(producto: producto);
      },
    );
  }

  void _editarProducto(int index) async {
    final TextEditingController nombreController =
        TextEditingController(text: Principal.productosFiltrados[index].nombre);

    final TextEditingController mercadonaController = TextEditingController(
        text: Principal.productosFiltrados[index].precios[0] == -1
            ? ''
            : '${Principal.productosFiltrados[index].precios[0]}');
    final TextEditingController lidlController = TextEditingController(
        text: Principal.productosFiltrados[index].precios[1] == -1
            ? ''
            : '${Principal.productosFiltrados[index].precios[1]}');
    final TextEditingController yukaMercadonaController = TextEditingController(
        text: Principal.productosFiltrados[index].yuka[0] == -1
            ? ''
            : '${Principal.productosFiltrados[index].yuka[0]}');
    final TextEditingController yukaLidlController = TextEditingController(
        text: Principal.productosFiltrados[index].yuka[1] == -1
            ? ''
            : '${Principal.productosFiltrados[index].yuka[1]}');
    final TextEditingController categoriaController = TextEditingController(
        text: Principal.productosFiltrados[index].categoria);
    final TextEditingController cantidadMercadonaController =
        TextEditingController(
            text: Principal.productosFiltrados[index].cantidad[0] == '-1'
                ? ''
                : Principal.productosFiltrados[index].cantidad[0]);
    final TextEditingController cantidadLidlController = TextEditingController(
        text: Principal.productosFiltrados[index].cantidad[1] == '-1'
            ? ''
            : Principal.productosFiltrados[index].cantidad[1]);
    final TextEditingController opinionMercadonaController =
        TextEditingController(
            text: Principal.productosFiltrados[index].opinion[0] == '-1'
                ? ''
                : Principal.productosFiltrados[index].opinion[0]);
    final TextEditingController opinionLidlController = TextEditingController(
        text: Principal.productosFiltrados[index].opinion[1] == '-1'
            ? ''
            : Principal.productosFiltrados[index].opinion[1]);
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
                    Principal.productosFiltrados[index].nombre =
                        nombreController.text;
                    Principal.productosFiltrados[index].precios[0] =
                        double.tryParse(mercadonaController.text) ?? -1;
                    Principal.productosFiltrados[index].precios[1] =
                        double.tryParse(lidlController.text) ?? -1;
                    Principal.productosFiltrados[index].yuka[0] =
                        int.tryParse(yukaMercadonaController.text) ?? -1;
                    Principal.productosFiltrados[index].yuka[1] =
                        int.tryParse(yukaLidlController.text) ?? -1;
                    Principal.productosFiltrados[index].categoria =
                        categoriaController.text;
                    Principal.productosFiltrados[index].cantidad[0] =
                        cantidadMercadonaController.text.isNotEmpty
                            ? cantidadMercadonaController.text
                            : '-1';
                    Principal.productosFiltrados[index].cantidad[1] =
                        cantidadLidlController.text.isNotEmpty
                            ? cantidadLidlController.text
                            : '-1';
                    Principal.productosFiltrados[index].opinion[0] =
                        opinionMercadonaController.text.isNotEmpty
                            ? opinionMercadonaController.text
                            : '-1';
                    Principal.productosFiltrados[index].opinion[1] =
                        opinionLidlController.text.isNotEmpty
                            ? opinionLidlController.text
                            : '-1';
                    Principal.productosFiltrados[index].fecha = DateTime.now();
                    Principal.datosManager('Exportar datosMIOS.txt');
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
                      children: Principal.listaCategorias.map((categoria) {
                        return Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: FilterChip(
                            labelStyle: const TextStyle(
                              fontSize: 12,
                            ),
                            labelPadding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            label: Text(categoria),
                            selected: Principal.filtroCategoria == categoria,
                            onSelected: (selected) {
                              setState(() {
                                Principal.filtroCategoria =
                                    selected ? categoria : '';
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
                          padding: const EdgeInsets.all(2.0),
                          child: FilterChip(
                            labelStyle: const TextStyle(
                              fontSize: 12,
                            ),
                            labelPadding: const EdgeInsets.fromLTRB(5, 5, 5, 5),
                            label: Text(orden),
                            selected: Principal.filtroOrden == orden,
                            onSelected: (selected) {
                              setState(() {
                                Principal.filtroOrden = selected ? orden : '';
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
        },
        backgroundColor: AppStyle.miColorPrimario,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: CustomScrollView(
        controller: widget._scrollController,
        slivers: [
          SliverAppBar(
              expandedHeight: 10.0,
              floating: true,
              pinned: true,
              title: GestureDetector(
                onTap: () {
                  _actualizarPagina();
                  widget._scrollController.animateTo(0,
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
              flexibleSpace: Container(
                  alignment: Alignment.bottomRight,
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 5),
                  child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SettingsPage()),
                            );
                          },
                          icon: const Icon(Icons.settings),
                        ),
                      ]),
                ),
              ),
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
                      padding: const EdgeInsets.all(0),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: Principal.productosFiltrados.length % 100,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Card(
                            color: Colors.white,
                            child: InkWell(
                              onTap: () {
                                _mostrarInformacionProducto(
                                    Principal.productosFiltrados[index]);
                              },
                              onLongPress: () {
                                _editarProducto(index);
                              },
                              onDoubleTap: () {
                                _eliminarProducto(
                                    Principal.productosFiltrados[index]);
                              },
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        Principal
                                            .productosFiltrados[index].nombre,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        Principal.productosFiltrados[index]
                                                    .precios[0] ==
                                                -1
                                            ? 'No disponible'
                                            : '${Principal.productosFiltrados[index].precios[0].toStringAsFixed(2)}€',
                                        style: const TextStyle(
                                            color: Colors.green),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        Principal.productosFiltrados[index]
                                                    .precios[1] ==
                                                -1
                                            ? 'No disponible'
                                            : '${Principal.productosFiltrados[index].precios[1].toStringAsFixed(2)}€',
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
              childCount: 1,
            ),
          ),
        ],
      ),
    );
  }
}
