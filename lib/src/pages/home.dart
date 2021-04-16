import 'dart:math';

import 'package:flutter/material.dart';
import 'package:inventariour/src/widgets/boton.dart';
import 'package:inventariour/src/widgets/fondo.dart';
import 'package:inventariour/src/widgets/titulos.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Stack(
          children: [
            Fondo(),
            Titulos(textos: 'Inventarios UR'),
            _botones(context),
          ],
        ),
      ),
    );
  }

  Widget _botones(BuildContext context) {
    return SafeArea(
      child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(top: 120, right: 40, left: 40),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  _boton(context, Icons.add, 'Nuevo conteo', 0),
                  SizedBox(
                    width: 40,
                  ),
                  _boton(context, Icons.art_track_sharp, 'Conteo dinámico', 1),
                ]),
                SizedBox(height: 60),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _boton(context, Icons.content_copy_outlined,
                        'Continuar conteo', 2),
                    SizedBox(
                      width: 40,
                    ),
                    _boton(context, Icons.check_circle_outline,
                        'Validar conteo', 3),
                  ],
                ),
              ],
            ),
          )),
    );
  }

  Widget _boton(
      BuildContext context, IconData _icono, String _texto, int _opcion) {
    return GestureDetector(
        onTap: () {
          switch (_opcion) {
            case 0:
              Navigator.of(context).pushReplacementNamed('nuevo');
              break;
            case 1:
              print('Conteo dinamico');
              break;
            case 2:
              Random rnd = new Random();
              int folio = rnd.nextInt(32000);
              Navigator.of(context)
                  .pushNamed('listar', arguments: {'folio': folio.toString()});
              break;
            case 3:
              print('Validar conteo');
              break;
          }
        },
        child: BotonOpciones(icono: _icono, texto: _texto));
  }
}
