import 'dart:math';

import 'package:flutter/material.dart';
import 'package:inventariour/src/models/producto-sql.model.dart';
import 'package:inventariour/src/services/data-notifier.dart';
import 'package:inventariour/src/services/producto-sql.services.dart';
import 'package:inventariour/src/widgets/boton.dart';
import 'package:inventariour/src/widgets/fondo.dart';
import 'package:inventariour/src/widgets/titulos.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class NewCountPage extends StatefulWidget {
  @override
  _NewCountPageState createState() => _NewCountPageState();
}

class _NewCountPageState extends State<NewCountPage> {
  DBFolios dbfolio;
  String codigoBarras;
  @override
  void initState() {
    super.initState();
    dbfolio = DBFolios();
  }

  @override
  Widget build(BuildContext context) {
    final productoServices = Provider.of<DataNotifiter>(context);
    return Scaffold(
      body: Stack(
        children: [
          Fondo(),
          Titulos(textos: 'Nuevo Conteo'),
          Center(
            child: GestureDetector(
              child: BotonOpciones(icono: Icons.add_to_photos, texto: 'Crear'),
              onTap: () async {
                String scannerCode = await FlutterBarcodeScanner.scanBarcode(
                    '#2D96F5', 'Cancelar', false, ScanMode.BARCODE);
                if (scannerCode != '-1') {
                  productoServices.idCodigo = scannerCode;
                  Random rnd = new Random();
                  int folio = rnd.nextInt(32000);
                  productoServices.idFolio = folio.toString();
                  dbfolio.addFolio(
                      ProductoSqlFolios(id: null, folio: folio.toString()));
                  Navigator.popAndPushNamed(context, 'stock',
                      arguments: {'info': 'nuevo'});
                  // return Navigator.pushNamed(context, 'respuesta');
                } else {
                  Navigator.popAndPushNamed(context, 'home');
                }
              },
            ),
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniStartFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.popAndPushNamed(context, 'home');
        },
        child: Icon(Icons.arrow_back_ios_rounded),
      ),
    );
  }
}
