import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:price_market/objects/MercadonaAPI.dart';
import 'package:price_market/objects/Producto.dart';

class ImportadorExportadorDatos {
  static Future<void> exportDataToFile(List<Producto> listaDeProductos) async {
    try {
      // Obtén el directorio de documentos de la aplicación
      Directory? documentsDirectory = await getDownloadsDirectory();

      // Construye la ruta del archivo
      String filePath = join(documentsDirectory!.path, 'datos.txt');

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

  static Future<List<Producto>> importDataFromFile() async {
    List<Producto> listaDeProductos = [];

    try {
      // Obtén el directorio de documentos de la aplicación
      Directory? documentsDirectory = await getDownloadsDirectory();

      // Construye la ruta del archivo
      String filePath = join(documentsDirectory!.path, 'datos.txt');

      // Lee el contenido del archivo
      File file = File(filePath);
      String data = await file.readAsString();

      // Procesa la cadena de datos y crea la lista de productos
      List<String> lineas = LineSplitter.split(data).toList();
      for (var i = 0; i < lineas.length; i++) {
        String linea = lineas[i];
        List<String> partes = linea.split(';');

        double id = double.parse(partes[0]);
        String nombre = partes[1];
        List<double> precios = [
          double.parse(partes[2]),
          double.parse(partes[3])
        ];
        String categoria = partes[4];
        List<String> cantidad = [partes[5], partes[6]];
        List<int> yuka = [int.parse(partes[7]), int.parse(partes[8])];
        List<String> opinion = [partes[9], partes[10]];
        String imagen = partes[11];
        DateTime fecha = DateTime.parse(partes[12]);
        listaDeProductos.add(Producto(
          id: id,
          nombre: nombre,
          precios: precios,
          categoria: categoria,
          cantidad: cantidad,
          yuka: yuka,
          opinion: opinion,
          imagen: imagen,
          fecha: fecha,
        ));
      }

      print(listaDeProductos.length);
      return listaDeProductos;
    } catch (e) {
      print('Error al importar datos: $e');
      return [];
    }
  }

  static Future<void> exportCategoriesToFile() async {
    try {
      // Obtén la lista de categorías
      List<String> listaCategorias =
          await MercadonaAPI().obtenerCategorias("nombre");

      // Obtén el directorio de documentos de la aplicación
      Directory? documentsDirectory = await getDownloadsDirectory();

      // Construye la ruta del archivo
      String filePath = join(documentsDirectory!.path, 'categorias.txt');

      // Abre el archivo en modo de escritura
      File file = File(filePath);
      IOSink sink = file.openWrite();

      // Escribe los datos en el archivo
      for (var categoria in listaCategorias) {
        sink.writeln(categoria);
      }

      // Cierra el archivo
      await sink.close();
    } catch (e) {
      print('Error al exportar datos: $e');
    }
  }

  static Future<List<String>> importCategoriesFromFile(
      List<String> listaCategorias) async {
    listaCategorias.clear();

    try {
      // Obtén el directorio de documentos de la aplicación
      Directory? documentsDirectory = await getDownloadsDirectory();

      // Construye la ruta del archivo
      String filePath = join(documentsDirectory!.path, 'categorias.txt');

      // Lee el contenido del archivo
      File file = File(filePath);
      String data = await file.readAsString();

      // Procesa la cadena de datos y crea la lista de productos
      List<String> lineas = LineSplitter.split(data).toList();
      for (var i = 0; i < lineas.length; i++) {
        listaCategorias.add(lineas[i]);
      }

      return listaCategorias;
    } catch (e) {
      print('Error al importar datos: $e');
      return [];
    }
  }

  static Future<void> exportDataMercadonaToFile() async {
    try {
      List<String> listaProductosMercadona =
          await MercadonaAPI().obtenerProductosDeTodasLasCategorias();

      // Obtén el directorio de documentos de la aplicación
      Directory? documentsDirectory = await getDownloadsDirectory();

      // Construye la ruta del archivo
      String filePath = join(documentsDirectory!.path, 'datosMercadona.txt');

      // Abre el archivo en modo de escritura
      File file = File(filePath);
      IOSink sink = file.openWrite();

      // Escribe los datos en el archivo
      for (var producto in listaProductosMercadona) {
        sink.write('${producto.toString()}\n');
      }

      // Cierra el archivo
      await sink.close();
    } catch (e) {
      print('Error al exportar datos: $e');
    }
  }

  static Future<List<String>> importDataMercadonaFromFile() async {
    List<String> listaProductoMercadona = [];

    try {
      // Obtén el directorio de documentos de la aplicación
      Directory? documentsDirectory = await getDownloadsDirectory();

      // Construye la ruta del archivo
      String filePath = join(documentsDirectory!.path, 'datosMercadona.txt');

      // Lee el contenido del archivo
      File file = File(filePath);
      String data = await file.readAsString();

      // Procesa la cadena de datos y crea la lista de productos
      List<String> lineas = LineSplitter.split(data).toList();
      for (var i = 0; i < lineas.length; i++) {
        listaProductoMercadona.add(lineas[i]);
      }

      return listaProductoMercadona;
    } catch (e) {
      print('Error al importar datos: $e');
      return [];
    }
  }

  static Future<void> convertDataToFile(
      List<String> listaProductosMercadona) async {
    try {
      // Obtén el directorio de documentos de la aplicación
      Directory? documentsDirectory = await getDownloadsDirectory();

      // Construye la ruta del archivo
      String filePath = join(documentsDirectory!.path, 'datos.txt');

      // Abre el archivo en modo de escritura
      File file = File(filePath);
      IOSink sink = file.openWrite();

      // Escribe los datos en el archivo
      for (var producto in listaProductosMercadona) {
        List<String> parte = producto.split(';');

        sink.write(
            '${parte[0]};${parte[1]};${parte[2]};-1;${parte[4]};${parte[3]};-1;0;0;Sin más;Sin más;-1;${DateTime.now()}\n');
      }

      // Cierra el archivo
      await sink.close();
    } catch (e) {
      print('Error al exportar datos: $e');
    }
  }
}
