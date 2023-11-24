/*
      appBar: AppBar(
        scrolledUnderElevation: 5,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        elevation: 2,
        iconTheme: const IconThemeData(color: AppStyle.miColorPrimario),
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            GestureDetector(
              onTap: () {
                _actualizarPagina();
                _scrollController.animateTo(0,
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
            const Spacer(),
            PopupMenuButton(
              itemBuilder: (context) {
                return [
                  PopupMenuItem(
                    child: const Text('Importar datos'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Importar datos'),
                            content: const Text(
                                '¿Está seguro de que desea importar los datos?'),
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
                                    _datosManager('Importar');
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text('Importar datos'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  PopupMenuItem(
                    child: const Text('Exportar datos'),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            title: const Text('Exportar datos'),
                            content: const Text(
                                '¿Está seguro de que desea exportar los datos?'),
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
                                    _datosManager('Exportar');
                                    Navigator.pop(context);
                                  });
                                },
                                child: const Text('Exportar datos'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ];
              },
            ),
          ],
        ),
      ),
      

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
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
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
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
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
                      onDoubleTap: () {
                        _eliminarProducto(productosFiltrados[index]);
                      },
                      child: ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Text(
                                productosFiltrados[index].nombre,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                productosFiltrados[index].precios[0] == -1
                                    ? 'No disponible'
                                    : '${productosFiltrados[index].precios[0].toStringAsFixed(2)}€',
                                style: const TextStyle(color: Colors.green),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                productosFiltrados[index].precios[1] == -1
                                    ? 'No disponible'
                                    : '${productosFiltrados[index].precios[1].toStringAsFixed(2)}€',
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 0, 0)),
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
        ),
      ),
    );
  }
}

*/