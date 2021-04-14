import 'package:flutter/material.dart';
import 'package:inventariour/src/models/producto-sql.model.dart';
import 'package:inventariour/src/services/producto-sql.services.dart';

class ListarProductosPage extends StatefulWidget {
  final String numFolio;
  ListarProductosPage({this.numFolio});

  @override
  _ListarProductosPageState createState() => _ListarProductosPageState();
}

class _ListarProductosPageState extends State<ListarProductosPage> {
  
  
  // Future<List<ProductoSql>> productos;
  DBProductos dbProductos;

  @override
  void initState() {
    super.initState();
    dbProductos = new DBProductos();
    // final args = ModalRoute.of(context).settings.arguments as Map;
    // productos = dbProductos.getProductosLista('123');
    // print(args['folio']);
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map;
    print(args['folio']);
    return Scaffold(
      appBar: AppBar(
        title: Text('Listar'),
        actions: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.popAndPushNamed(context, 'stock',
                    arguments: {'folio': args['folio']});
              })
        ],
      ),
      body: FutureBuilder(
        future: dbProductos.getProductosLista(args['folio']),
        builder:
            (BuildContext context, AsyncSnapshot<List<ProductoSql>> snapshot) {
          if (snapshot.hasData) {
            return generarLista(snapshot.data);
          } else if (snapshot.data == null || snapshot.data.length == 0) {
            return Center(
              child: Text('No se a generado ningún conteo'),
            );
          } else {
            return CircularProgressIndicator();
          }
        },
      ),
    );
  }

  SingleChildScrollView generarLista(List<ProductoSql> folios) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Nombre del producto')),
            DataColumn(label: Text('Cantidad')),
          ],
          rows: folios
              .map((folio) => DataRow(cells: [
                    DataCell(Text(folio.descripcion)),
                    DataCell(Text(folio.existencia)),
                  ]))
              .toList(),
        ),
      ),
    );
  }
}
