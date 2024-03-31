import 'dart:async';

import 'package:flutter/material.dart';
import 'package:price_market/components/ProductoDialog.dart';
import 'package:price_market/screens/principal.dart';
import 'package:price_market/screens/settings.dart';
import '../objects/AppStyle.dart';
import '../objects/Producto.dart';
import '../components/drawerWidget.dart';
import '../objects/Clases.dart';

class ShoppingCart extends StatefulWidget {
  ShoppingCart({Key? key}) : super(key: key);

  @override
  _ShoppingCartState createState() => _ShoppingCartState();

  static List<Producto> listaProductos = Principal.getListaProductos();
  static List<Producto> productosFiltrados = [];
  static String filtroOrden = 'Ninguno';
  static String filtroCategoria = '';
  final ScrollController _scrollController = ScrollController();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<Producto> resultadosBusqueda = [];
  List<Producto> listaCompra = [];
  final TextEditingController _searchController = TextEditingController();
  String filtroSuper = '';
  @override
  void initState() {
    super.initState();
  }

  void _filtrarProductos(String filtro) {
    
  }

  void _agregarProductoAListaCompra(Producto producto) {
    setState(() {
      listaCompra.add(producto);
      resultadosBusqueda.clear();
      _searchController.clear();
    });
  }

  void _eliminarProducto(Producto producto) {
    setState(() {
      listaCompra.remove(producto);
    });
  }

  void _mostrarInformacionProducto(Producto producto) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return ProductoDialog(producto: producto);
      },
    );
  }

  void _mostrarFiltrosDialog() {}

  Future<void> _actualizarPagina() async {
    _filtrarProductos('');
    _filtrarProductos;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrawerWidget(),
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
              flexibleSpace: Expanded(
                child: Container(
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
              )),
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
                              padding: const EdgeInsets.fromLTRB(10, 2, 10, 2),
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
                                  filtroSuper = selected ? supermercado : '';
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
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          child: Column(
                            children: [
                              TextField(
                                controller: _searchController,
                                onChanged: (value) {
                                  List<Producto> resultados = [];
                                  if (value.isNotEmpty) {
                                    resultados = ShoppingCart.listaProductos
                                        .where((producto) => producto.nombre
                                            .toLowerCase()
                                            .contains(value.toLowerCase()))
                                        .toList();
                                  }
                                  setState(() {
                                    resultadosBusqueda = resultados;
                                  });
                                },
                                decoration: const InputDecoration(
                                  border: InputBorder
                                      .none, // Elimina el borde del TextField
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
                                              _searchController
                                                  .clear(); // Limpia el campo de búsqueda
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
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Super',
                              style: TextStyle(fontWeight: FontWeight.bold),
                              textAlign: TextAlign.center,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Precio',
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
                      itemCount: listaCompra.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                          child: Card(
                            color: Colors.white,
                            elevation: 2,
                            child: InkWell(
                              onTap: () {
                                _mostrarInformacionProducto(listaCompra[index]);
                              },
                              onDoubleTap: () {
                                _eliminarProducto(listaCompra[index]);
                              },
                              child: ListTile(
                                title: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        listaCompra[index].nombre,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        listaCompra[index].precios[0] == -1
                                            ? 'No disponible'
                                            : '${listaCompra[index].precios[0].toStringAsFixed(2)}€',
                                        style: const TextStyle(
                                            color: Colors.green),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                    Expanded(
                                      child: Text(
                                        listaCompra[index].precios[1] == -1
                                            ? 'No disponible'
                                            : '${listaCompra[index].precios[1].toStringAsFixed(2)}€',
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
