import 'package:flutter/material.dart';
import 'package:inventariour/src/widgets/boton.dart';
import 'package:inventariour/src/widgets/fondo.dart';
import 'package:inventariour/src/widgets/titulos.dart';

class NewCountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Fondo(),
          Titulos(textos: 'Nuevo Conteo'),
          Center(
            child: BotonOpciones(icono: Icons.add_to_photos, texto: 'Crear'),
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
