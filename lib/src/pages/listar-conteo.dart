import 'package:flutter/material.dart';
import 'package:inventariour/src/models/producto-sql.model.dart';
import 'package:inventariour/src/services/data-notifier.dart';
import 'package:inventariour/src/services/producto-sql.services.dart';
import 'package:provider/provider.dart';

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
    actualizarLista();
  }

  actualizarLista(){
    folios = dbfolios.getFoliosLista();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Folios')),
      body: FutureBuilder(
        future: folios,
        builder: (BuildContext context,
            AsyncSnapshot<List<ProductoSqlFolios>> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData && snapshot.data.isNotEmpty) {
            return generarLista(snapshot.data, context);
          } else {
            return Center(
              child: Text('No se a generado ningún conteo'),
            );
          }
        },
      ),
    );
  }

  SingleChildScrollView generarLista(List<ProductoSqlFolios> folios, BuildContext context) {
    final productosServices = Provider.of<DataNotifiter>(context);
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Folio'),numeric: true),
            DataColumn(label: Text('Eliminar')),
            DataColumn(label: Text('Actualizar')),
          ],
          rows: folios
              .map((folio) => DataRow(cells: [
                    DataCell(Text(folio.folio), onTap: () {
                      productosServices.idFolio = folio.folio;
                      // print('Valor del folio en listar  $folioSelect');
                      Navigator.pushNamed(context, 'listar-productos');
                    }),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: (){
                          setState(() {
                            dbfolios.delteFolio(folio.id);
                            actualizarLista();
                            
                          });
                        },
                        color: Colors.redAccent,
                      )
                    ),
                    DataCell(
                      IconButton(
                        icon: Icon(Icons.send),
                        onPressed: (){
                          
                        },
                        color: Colors.green,
                      )
                    )
                  ],
                  ),
                  )
              .toList(),
        ),
      ),
    );
  }
}
