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
      precios: [1.6, 1.0],
      categoria: 'Bebidas',
    ),
    Producto(
      id: 3,
      nombre: 'Fanta',
      precios: [1.4, 0.2],
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
      precios: [1.6, 2.3],
      categoria: 'Bebidas',
    ),
    Producto(
      id: 6,
      nombre: 'Leche',
      precios: [132, 28],
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

  void _editarProducto(int index) async {
  final TextEditingController _nombreController =
      TextEditingController(text: productos[index].nombre);
  final TextEditingController _precio1Controller =
      TextEditingController(text: productos[index].precios[0].toString());
  final TextEditingController _precio2Controller =
      TextEditingController(text: productos[index].precios[1].toString());
  final TextEditingController _categoriaController =
      TextEditingController(text: productos[index].categoria);

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Editar Producto'),
        titlePadding: EdgeInsets.fromLTRB(20, 20, 20, 5),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nombreController,
              decoration: InputDecoration(labelText: 'Nombre del Producto'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _precio1Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Precio 1'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _precio2Controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Precio 2'),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _categoriaController,
              decoration: InputDecoration(labelText: 'Categoría'),
            ),
          ],
        ),
        contentPadding: EdgeInsets.fromLTRB(20, 5, 20, 20),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                productos[index].nombre = _nombreController.text;
                productos[index].precios[0] =
                    double.tryParse(_precio1Controller.text) ?? 0.0;
                productos[index].precios[1] =
                    double.tryParse(_precio2Controller.text) ?? 0.0;
                productos[index].categoria = _categoriaController.text;
              });
              Navigator.pop(context);
            },
            child: Text('Guardar'),
          ),
        ],
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
          Padding(
            padding: const EdgeInsets.all(8.0),
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
          Expanded(
            child: ListView.builder(
              itemCount: productosFiltrados.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: InkWell(
                    onTap: () {
                      _editarProducto(index);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            productosFiltrados[index].nombre,
                            style: TextStyle(fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${productosFiltrados[index].precios[0]}€',
                            style: TextStyle(color: Colors.green),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Expanded(
                          child: Text(
                            '${productosFiltrados[index].precios[1]}€',
                            style: TextStyle(color: Colors.blue),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
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
