import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:price_market/objects/Producto.dart';

class ImportadorExportadorDatos {
  static Future<void> exportDataToFile(List<Producto> listaDeProductos) async {
    try {
      // Obtén el directorio de documentos de la aplicación
      Directory documentsDirectory = await getApplicationDocumentsDirectory();

      // Construye la ruta del archivo
      String filePath = join(documentsDirectory.path, 'datos.txt');

      // Abre el archivo en modo de escritura
      File file = File(filePath);
      IOSink sink = file.openWrite();

      // Escribe los datos en el archivo
      for (var producto in listaDeProductos) {
        sink.write('${producto.toString()}\n');
      }

      // Cierra el archivo
      await sink.close();
    } catch (e) {
      print('Error al exportar datos: $e');
    }
  }

  static Future<List<Producto>> importDataFromFile(List<Producto> listaDeProductos) async {
    listaDeProductos.clear(); // Limpiar la lista antes de importar

    try {
      // Obtén el directorio de documentos de la aplicación
      Directory documentsDirectory = await getApplicationDocumentsDirectory();

      // Construye la ruta del archivo
      String filePath = join(documentsDirectory.path, 'datos.txt');

      // Lee el contenido del archivo
      File file = File(filePath);
      String data = await file.readAsString();

      // Procesa la cadena de datos y crea la lista de productos
      List<String> lineas = LineSplitter.split(data).toList();
      for (var i = 0; i < lineas.length; i++) {
        String linea = lineas[i];
        List<String> partes = linea.split(', ');
        int id = int.parse(partes[0]);
        String nombre = partes[1];
        List<double> precios = [
          double.parse(partes[2]),
          double.parse(partes[3])
        ];
        String categoria = partes[4];
        List<int> yuka = [
          int.parse(partes[5]),
          int.parse(partes[6])
        ];
        String imagen = partes[7];
        DateTime fecha = DateTime.parse(partes[8]);
        listaDeProductos.add(Producto(
            id: id,
            nombre: nombre,
            precios: precios,
            categoria: categoria,
            yuka: yuka,
            imagen: imagen,
            fecha: fecha));
      }

      return listaDeProductos;
    } catch (e) {
      print('Error al importar datos: $e');
      return [];
    }
  }
}
