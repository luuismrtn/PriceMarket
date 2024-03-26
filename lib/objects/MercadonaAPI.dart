import 'dart:convert';
import 'package:http/http.dart' as http;

class MercadonaAPI {
  Future<List<String>> obtenerCategorias(String detalle) async {
    final url = Uri.parse('https://tienda.mercadona.es/api/categories/');
    final response = await http.get(url);

    List<String> listaCategorias = [];

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      final categorias = jsonResponse['results'];
      if (detalle == 'nombre') {
        for (var categoria in categorias) {
          final nombre = categoria['name'];
          listaCategorias.add(nombre);
        }
      } else if (detalle == 'id') {
        for (var categoria in categorias) {
          final id = categoria['id'];
          listaCategorias.add(id.toString());
        }
      } else {
        print('Error al cargar las categorías: ${response.statusCode}');
      }
    }

    return listaCategorias;
  }

  Future<List<String>> obtenerProductos(int categoria) async {
    final url =
        Uri.parse('https://tienda.mercadona.es/api/categories/$categoria/');
    final response = await http.get(url);

    List<String> listaProductos = [];

    if (response.statusCode == 200) {
      final jsonResponse = json.decode(utf8.decode(response.bodyBytes));
      final nombreCategoria = jsonResponse['name'];
      final categorias = jsonResponse['categories'];
      for (var categoria in categorias) {
        final productos = categoria['products'];
        for (var producto in productos) {
          final id = producto['id'];
          final nombre = producto['display_name'];
          final precio = double.tryParse(
              producto['price_instructions']['unit_price'] ?? '0.0');
          final cantidad = producto['price_instructions']['min_bunch_amount'];
          final unidad = producto['price_instructions']['reference_format'];


          listaProductos
              .add('$id;$nombre;$precio;$cantidad$unidad;$nombreCategoria');
        }
      }
    } else {
      print('Error al cargar los productos: ${response.statusCode}');
    }
    return listaProductos;
  }

  Future<List<String>> obtenerProductosDeTodasLasCategorias() async {
    final categoriasIds = await MercadonaAPI().obtenerCategorias("id");
    final listaProductos = <String>[];

    for (var categoriaId in categoriasIds) {
      final productos =
          await MercadonaAPI().obtenerProductos(int.parse(categoriaId));
      listaProductos.addAll(productos);
    }

    return listaProductos;
  }
}
