import 'package:flutter/material.dart';
import 'package:inventariour/src/models/producto-sql.model.dart';
import 'package:inventariour/src/services/producto-sql.services.dart';

class ListarPage extends StatefulWidget {
  @override
  _ListarPageState createState() => _ListarPageState();
}

class _ListarPageState extends State<ListarPage> {
  Future<List<ProductoSqlFolios>> folios;
  DBFolios dbfolios;

  @override
  void initState() {
    super.initState();
    dbfolios = new DBFolios();
    folios = dbfolios.getFoliosLista();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Listar')),
      body: FutureBuilder(
        future: folios,
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductoSqlFolios>> snapshot) {
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

  SingleChildScrollView generarLista(List<ProductoSqlFolios> folios) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Numero Folio')),
          ],
          rows: folios
              .map((folio) => DataRow(cells: [
                    DataCell(Text(folio.folio), onTap: () {
                      String folioSelect = folio.folio;
                      print('Valor del folio en listar  $folioSelect');
                      Navigator.popAndPushNamed(context, 'listar-productos',
                          arguments: {'folio': folioSelect});
                    }),
                  ]))
              .toList(),
        ),
      ),
    );
  }
}
