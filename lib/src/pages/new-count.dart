import 'dart:math';

import 'package:flutter/material.dart';
import 'package:inventariour/src/models/producto-sql.model.dart';
import 'package:inventariour/src/services/producto-sql.services.dart';
import 'package:inventariour/src/widgets/boton.dart';
import 'package:inventariour/src/widgets/fondo.dart';
import 'package:inventariour/src/widgets/titulos.dart';

// ignore: must_be_immutable
class NewCountPage extends StatefulWidget {
  @override
  _NewCountPageState createState() => _NewCountPageState();
}

class _NewCountPageState extends State<NewCountPage> {
  DBFolios dbfolio;

  @override
  void initState() {
    super.initState();
    dbfolio = DBFolios();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Fondo(),
          Titulos(textos: 'Nuevo Conteo'),
          Center(
            child: GestureDetector(
              child: BotonOpciones(icono: Icons.add_to_photos, texto: 'Crear'),
              onTap: () {
                Random rnd = new Random();
                int folio = rnd.nextInt(32000);
                dbfolio.addFolio(
                    ProductoSqlFolios(id: null, folio: folio.toString()));

                Navigator.popAndPushNamed(context, 'stock',
                    arguments: {'folio': folio.toString()});
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
