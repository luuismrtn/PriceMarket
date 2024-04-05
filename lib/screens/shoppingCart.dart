import 'dart:async';

import 'package:flutter/material.dart';
import 'package:price_market/components/ProductoDialog.dart';
import 'package:price_market/screens/principal.dart';
import 'package:price_market/screens/settings.dart';
import '../objects/AppStyle.dart';
import '../objects/Producto.dart';
import '../components/drawerWidget.dart';
import '../objects/Clases.dart';
import 'package:price_market/objects/DatosManager.dart';

class ShoppingCart extends StatefulWidget {
  const ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();

  static List<Producto> listaProductos = Principal.getListaProductos();

  static String filtroOrden = 'Ninguno';
  static String filtroCategoria = '';
  static List<Producto> listaCompra = [];

  static void datosManager(String accion) async {
    if (accion == 'Importar') {
      listaCompra = await ImportadorExportadorDatos.importListaCompraFromFile();
    } else if (accion == 'Exportar') {
      await ImportadorExportadorDatos.exportListaCompraFromFile(listaCompra);
    }
  }
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<Producto> resultadosBusqueda = [];
  List<Producto> productosFiltrados = [];
  String filtroSuper = '';

  bool _isDeleting = false;

  final TextEditingController _searchController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _inicializarDatos();
  }

  Future<void> _inicializarDatos() async {
    ShoppingCart.listaCompra =
        await ImportadorExportadorDatos.importListaCompraFromFile();
    setState(() {
      _filtrarProductos('');
    });
  }

  void _filtrarProductos(String value) {
    List<Producto> resultadosFiltrados =
        ShoppingCart.listaCompra.where((producto) {
      if (value.isNotEmpty &&
          !producto.nombre.toLowerCase().contains(value.toLowerCase())) {
        return false;
      }
      // Aplicar filtro por supermercado
      if (filtroSuper.isNotEmpty &&
          _calcularMejorSuper(producto) != filtroSuper) {
        return false;
      }
      return true;
    }).toList();

    setState(() {
      productosFiltrados = resultadosFiltrados;
    });
  }

  void _agregarProductoAListaCompra(Producto producto) {
    setState(() {
      ShoppingCart.listaCompra.add(producto);
      _filtrarProductos('');
      resultadosBusqueda.clear();
      _searchController.clear();
    });
    ShoppingCart.datosManager('Exportar');
  }

  void _eliminarProducto(Producto producto) {
    setState(() {
      ShoppingCart.listaCompra.remove(producto);
    });
    ShoppingCart.datosManager('Exportar');
  }

  void _mostrarInformacionProducto(Producto producto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProductoDialog(producto: producto);
      },
    );
  }

  Future<void> _actualizarPagina() async {
    _filtrarProductos('');
    _filtrarProductos;
  }

  String _calcularMejorOpcion(Producto producto) {
    // Obtener precios del producto
    double precioMercadona = producto.precios[0];
    double precioLidl = producto.precios[1];

    if (precioMercadona == -1) {
      return '${producto.precios[1].toStringAsFixed(2)}€';
    } else if (precioLidl == -1) {
      return '${producto.precios[0].toStringAsFixed(2)}€';
    }

    // Obtener cantidad del producto
    String cantidadMercadona = producto.cantidad[0];
    String cantidadLidl = producto.cantidad[1];

    double unidadMercadona = double.parse(cantidadMercadona.split(' ')[0]);
    double unidadLidl = double.parse(cantidadLidl.split(' ')[0]);

    // Obtener puntuación de Yuka del producto
    int yukaMercadona = producto.yuka[0];
    int yukaLidl = producto.yuka[1];

    if (yukaMercadona == 0) {
      yukaMercadona++;
    }
    if (yukaLidl == 0) {
      yukaLidl++;
    }

    // Calcular puntaje para cada opción
    double puntajeMercadona = precioMercadona / unidadMercadona / yukaMercadona;
    double puntajeLidl = precioLidl / unidadLidl / yukaLidl;

    String opinionMercadona = producto.opinion[0];
    String opinionLidl = producto.opinion[1];

    switch (opinionMercadona) {
      case 'Increíble':
        puntajeMercadona *= 0.5;
        break;
      case 'Me gusta':
        puntajeMercadona *= 0.7;
        break;
      case 'Sin más':
        puntajeMercadona *= 1.0;
        break;
      case 'No me gusta':
        puntajeMercadona *= 1.3;
        break;
      case 'Horrible':
        puntajeMercadona *= 1.5;
        break;
    }

    switch (opinionLidl) {
      case 'Increíble':
        puntajeLidl *= 0.5;
        break;
      case 'Me gusta':
        puntajeLidl *= 0.7;
        break;
      case 'Sin más':
        puntajeLidl *= 1.0;
        break;
      case 'No me gusta':
        puntajeLidl *= 1.3;
        break;
      case 'Horrible':
        puntajeLidl *= 1.5;
        break;
    }

    // Elegir el mejor precio
    if (puntajeLidl >= puntajeMercadona) {
      return '${producto.precios[0].toStringAsFixed(2)}€';
    } else {
      return '${producto.precios[1].toStringAsFixed(2)}€';
    }
  }

  String _calcularMejorSuper(Producto producto) {
    String precio = _calcularMejorOpcion(producto);

    if (precio == '${producto.precios[0].toStringAsFixed(2)}€') {
      return 'Mercadona';
    } else {
      return 'Lidl';
    }
  }

  double _calcularTotal() {
    double total = 0.0;
    for (var producto in productosFiltrados) {
      double precio =
          double.parse(_calcularMejorOpcion(producto).split('€')[0]);
      total += precio;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: DrawerWidget(),
        body: Stack(
          children: [
            CustomScrollView(
              controller: _scrollController,
              slivers: [
                SliverAppBar(
                  expandedHeight: 10.0,
                  floating: true,
                  pinned: true,
                  title: GestureDetector(
                    onTap: () {
                      _actualizarPagina();
                      _scrollController.animateTo(0,
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                      _searchController.clear();
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
                            child: Wrap(
                              children: Supermercados.getListaSupermercados()
                                  .map((supermercado) {
                                return Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: FilterChip(
                                    padding:
                                        const EdgeInsets.fromLTRB(10, 2, 10, 2),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    labelStyle: const TextStyle(
                                      fontSize: 15,
                                      fontFamily: 'ProductSans',
                                    ),
                                    labelPadding:
                                        const EdgeInsets.fromLTRB(5, 2, 5, 2),
                                    label: Text(supermercado),
                                    selected: filtroSuper == supermercado,
                                    onSelected: (selected) {
                                      setState(() {
                                        filtroSuper =
                                            selected ? supermercado : '';
                                        _filtrarProductos('');
                                      });
                                    },
                                  ),
                                );
                              }).toList(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Card(
                              color: Colors.white,
                              elevation: 4,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8),
                                child: Column(
                                  children: [
                                    TextField(
                                      controller: _searchController,
                                      onChanged: (value) {
                                        List<Producto> resultados = [];
                                        if (value.isNotEmpty) {
                                          resultados =
                                              Principal.getListaProductos()
                                                  .where((producto) => producto
                                                      .nombre
                                                      .toLowerCase()
                                                      .contains(
                                                          value.toLowerCase()))
                                                  .toList();
                                        }
                                        setState(() {
                                          resultadosBusqueda = resultados;
                                        });
                                      },
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Añadir producto',
                                        prefixIcon: Icon(Icons.add),
                                      ),
                                    ),
                                    if (resultadosBusqueda.isNotEmpty)
                                      Column(
                                        children: resultadosBusqueda
                                            .map((producto) => ListTile(
                                                  title: Text(producto.nombre),
                                                  onTap: () {
                                                    _agregarProductoAListaCompra(
                                                        producto);
                                                    _searchController.clear();
                                                  },
                                                ))
                                            .toList(),
                                      ),
                                  ],
                                ),
                              ),
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
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Super',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Expanded(
                                  child: Text(
                                    'Precio',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
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
                            itemCount: productosFiltrados.length,
                            itemBuilder: (context, index) {
                              final producto = productosFiltrados[index];
                              return Padding(
                                padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                                child: Card(
                                    color: Colors.white,
                                    elevation: 2,
                                    child: Dismissible(
                                      key: Key(producto.nombre),
                                      direction: DismissDirection.startToEnd,
                                      background: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(12),
                                            color: Colors.red),
                                        alignment: Alignment.centerLeft,
                                        child: Container(
                                          padding: const EdgeInsets.fromLTRB(
                                              10, 0, 0, 0),
                                          child: const Icon(
                                            Icons.delete,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                      onDismissed: (direction) {
                                        setState(() {
                                          _isDeleting = true;
                                          _eliminarProducto(producto);
                                          productosFiltrados.remove(producto);
                                          _isDeleting = false;
                                        });
                                      },
                                      confirmDismiss: (direction) async {
                                        return !_isDeleting; // Bloquear eliminaciones si se está eliminando actualmente
                                      },
                                      child: InkWell(
                                        onTap: () {
                                          _mostrarInformacionProducto(producto);
                                        },
                                        child: ListTile(
                                          title: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Expanded(
                                                  child: Container(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        5, 2, 5, 2),
                                                child: Text(
                                                  producto.nombre,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                ),
                                              )),
                                              Expanded(
                                                child: Container(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          5, 2, 5, 2),
                                                  margin:
                                                      const EdgeInsets.fromLTRB(
                                                          10, 2, 10, 2),
                                                  decoration: BoxDecoration(
                                                    color: const Color.fromARGB(
                                                        255, 255, 125, 125),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: Text(
                                                    _calcularMejorSuper(
                                                        producto),
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                child: Text(
                                                  _calcularMejorOpcion(
                                                      producto),
                                                  style: const TextStyle(
                                                      color: Colors.green),
                                                  textAlign: TextAlign.center,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )),
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
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 215, 215),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Precio total: ${_calcularTotal().toStringAsFixed(2)}€',
                      style: const TextStyle(
                        fontFamily: 'ProductSans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ));
  }
}
