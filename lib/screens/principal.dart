import 'package:flutter/material.dart';
import '../objects/colors.dart';
import '../objects/Producto.dart';
import 'formularioProducto.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<Principal> {
  List<Producto> productos = [
    Producto(
      id: 1,
      nombre: 'Coca Cola',
      precios: [1.5, 2.0],
      categoria: 'Bebidas',
    ),
    Producto(
      id: 2,
      nombre: 'Pepsi',
      precios: [1.5, 2.0],
      categoria: 'Bebidas',
    ),
    Producto(
      id: 3,
      nombre: 'Fanta',
      precios: [1.5, 2.0],
      categoria: 'Bebidas',
    ),
    Producto(
      id: 4,
      nombre: 'Cerveza',
      precios: [1.5, 2.0],
      categoria: 'Bebidas',
    ),
    Producto(
      id: 5,
      nombre: 'Agua',
      precios: [1.5, 2.0],
      categoria: 'Bebidas',
    ),
    Producto(
      id: 6,
      nombre: 'Leche',
      precios: [1.5, 2.0],
      categoria: 'Alimentación',
    ),
    Producto(
      id: 7,
      nombre: 'Pan',
      precios: [1.5, 2.0],
      categoria: 'Alimentación',
    ),
    Producto(
      id: 8,
      nombre: 'Huevos',
      precios: [1.5, 2.0],
      categoria: 'Alimentación',
    ),
    Producto(
      id: 9,
      nombre: 'Carne',
      precios: [1.5, 2.0],
      categoria: 'Alimentación',
    ),
    Producto(
      id: 10,
      nombre: 'Pescado',
      precios: [1.5, 2.0],
      categoria: 'Alimentación',
    ),
  ];

  List<Producto> productosFiltrados = [];
  String filtroCategoria = '';

  @override
  void initState() {
    super.initState();
    productosFiltrados = List.from(productos);
  }

  void _agregarProducto(Producto nuevoProducto) {
    setState(() {
      productos.add(nuevoProducto);
    });
  }

  void _filtrarProductos(String filtro) {
    setState(() {
      productosFiltrados = productos
          .where((producto) =>
              producto.nombre.toLowerCase().contains(filtro.toLowerCase()) &&
              (filtroCategoria.isEmpty || producto.categoria == filtroCategoria))
          .toList();
    });
  }

  void _irFormulario(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FormularioProducto(
          onProductoAgregado: _agregarProducto,
        ),
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
        )),
        elevation: 2,
        iconTheme: const IconThemeData(color: AppColors.miColorPrimario),
        backgroundColor: Colors.white,
        title: Row(
          children: [
            const Spacer(),
            const Text(
              'PriceMarket',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppColors.miColorPrimario,
              ),
            ),
            const Spacer(),
            // ... Otros botones o iconos que puedas tener
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _irFormulario(context);
        },
        backgroundColor: AppColors.miColorPrimario,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onChanged: _filtrarProductos,
                    decoration: InputDecoration(
                      labelText: 'Buscar producto',
                      prefixIcon: Icon(Icons.search),
                    ),
                  ),
                ),
                PopupMenuButton<String>(
                  icon: const Icon(Icons.filter_list),
                  onSelected: (value) {
                    setState(() {
                      filtroCategoria = value;
                      _filtrarProductos('');
                    });
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        value: '',
                        child: const Text('Todos'),
                      ),
                      PopupMenuItem<String>(
                        value: 'Bebidas',
                        child: const Text('Bebidas'),
                      ),
                      PopupMenuItem<String>(
                        value: 'Alimentación',
                        child: const Text('Alimentación'),
                      ),
                      // Agrega más opciones de filtro según tus necesidades
                    ];
                  },
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: productosFiltrados.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          productosFiltrados[index].nombre,
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Precio 1: \$${productosFiltrados[index].precios[0]}',
                          style: TextStyle(color: Colors.green),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          'Precio 2: \$${productosFiltrados[index].precios[1]}',
                          style: TextStyle(color: Colors.blue),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
