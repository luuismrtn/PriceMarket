
import 'package:flutter/material.dart';
import 'package:price_market/objects/Clases.dart';
import '../objects/AppStyle.dart';
import '../objects/Producto.dart';
import 'formularioProducto.dart';

class Principal extends StatefulWidget {
  const Principal({Key? key}) : super(key: key);

  @override
  _MyScreenState createState() => _MyScreenState();
}

class _MyScreenState extends State<Principal> {

  List<String> ordenOpciones = ['Menor Precio', 'Mayor Precio'];

  String filtroOrden = 'Ninguno';

  List<Producto> productos = [
    Producto(
      id: 1,
      nombre: 'Coca Cola',
      precios: [1.5, 2.0],
      categoria: 'Bebidas',
      imagen: "https://sgfm.elcorteingles.es/SGFM/dctm/MEDIA03/202109/28/00118622300228____23__600x600",
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

      if (filtroOrden == 'Menor Precio') {
        productosFiltrados.sort((a, b) =>
            (a.precios.reduce((value, element) => value + element) /
                    a.precios.length)
                .compareTo((b.precios.reduce((value, element) => value + element) /
                        b.precios.length)));
      } else if (filtroOrden == 'Mayor Precio') {
        productosFiltrados.sort((a, b) =>
            (b.precios.reduce((value, element) => value + element) /
                    b.precios.length)
                .compareTo((a.precios.reduce((value, element) => value + element) /
                        a.precios.length)));
      }
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

  void _mostrarInformacionProducto(Producto producto) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Información del Producto'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (producto.imagen != "")
               Image.network(
                producto.imagen,
                height: 100,
                width: 100,
              ),
            Table(
          columnWidths: {
            0: const FlexColumnWidth(1),
            1: const FlexColumnWidth(1),
          },
          defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          children: [
            TableRow(
              children: [
                const TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Nombre:'),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(producto.nombre),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                const TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Mercadona:'),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${producto.precios[0]}€'),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                const TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Lidl:'),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('${producto.precios[1]}€'),
                  ),
                ),
              ],
            ),
            TableRow(
              children: [
                const TableCell(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Categoría:'),
                  ),
                ),
                TableCell(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(producto.categoria),
                  ),
                ),
              ],
            ),
          ],
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
        title: const Text('Editar Producto'),
        titlePadding: const EdgeInsets.fromLTRB(20, 20, 20, 5),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _nombreController,
              decoration: const InputDecoration(labelText: 'Nombre del Producto'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _precio1Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Precio 1'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _precio2Controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Precio 2'),
            ),
            const SizedBox(height: 8),
            TextField(
              controller: _categoriaController,
              decoration: const InputDecoration(labelText: 'Categoría'),
            ),
          ],
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
                productos[index].nombre = _nombreController.text;
                productos[index].precios[0] =
                    double.tryParse(_precio1Controller.text) ?? 0.0;
                productos[index].precios[1] =
                    double.tryParse(_precio2Controller.text) ?? 0.0;
                productos[index].categoria = _categoriaController.text;
              });
              Navigator.pop(context);
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
                SizedBox(height: 10),
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
                SizedBox(height: 10),
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
        )),
        elevation: 2,
        iconTheme: const IconThemeData(color: AppStyle.miColorPrimario),
        backgroundColor: Colors.white,
        title: const Row(
          children: [
            Spacer(),
            Text(
              'PriceMarket',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppStyle.miColorPrimario,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _irFormulario(context);
        },
        backgroundColor: AppStyle.miColorPrimario,
        foregroundColor: Colors.white,
        child: const Icon(Icons.add),
      ),
       body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {

              },
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
        Expanded(
  child: ListView.builder(
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
                      style: const TextStyle(fontWeight: FontWeight.bold),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${productosFiltrados[index].precios[0]}€',
                      style: const TextStyle(color: Colors.green),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '${productosFiltrados[index].precios[1]}€',
                      style: const TextStyle(color: Colors.blue),
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
),
      ],
    ),
  );
}
}
