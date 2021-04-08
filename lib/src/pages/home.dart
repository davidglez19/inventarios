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
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
          width: double.infinity,
          height: double.infinity,
          margin: EdgeInsets.only(top: 120, right: 20, left: 40),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _boton(context, Icons.add, 'Nuevo conteo', 0),
                  SizedBox(
                    width: 20,
                  ),
                  _boton(context, Icons.art_track_sharp, 'Conteo dinámico', 1),
                ],
              ),
              SizedBox(
                height: 60,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _boton(context, Icons.content_copy_outlined,
                      'Continuar conteo', 2),
                  SizedBox(
                    width: 20,
                  ),
                  _boton(
                      context, Icons.check_circle_outline, 'Validar conteo', 3),
                ],
              ),
            ],
          )),
    );
  }

  Widget _boton(
      BuildContext context, IconData _icono, String _texto, int _opcion) {
    final _size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          switch (_opcion) {
            case 0:
              Navigator.of(context).popAndPushNamed('nuevo');
              break;
            case 1:
              print('Conteo dinamico');
              break;
            case 2:
              print('Continuar conteo');
              break;
            case 3:
              print('Validar conteo');
              break;
          }
        },
        child: BotonOpciones(icono: _icono, texto: _texto));
  }
}
