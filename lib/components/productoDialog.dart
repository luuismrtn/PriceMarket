import 'package:flutter/material.dart';
import 'package:price_market/objects/Producto.dart';

class ProductoDialog extends StatelessWidget {
  final Producto producto;

  const ProductoDialog({required this.producto});

  @override
  Widget build(BuildContext context) {
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
            if (producto.imagen != "-1")
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
  }
}
