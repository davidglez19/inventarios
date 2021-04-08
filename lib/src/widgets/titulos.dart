import 'package:flutter/material.dart';

class Titulos extends StatelessWidget {
  final String textos;

  Titulos({@required this.textos});

  @override
  Widget build(BuildContext context) {
    TextStyle _textos = TextStyle(
        fontSize: 25,
        fontWeight: FontWeight.bold,
        fontFamily: 'dmfont',
        fontStyle: FontStyle.normal);
    final size = MediaQuery.of(context).size;
    return SafeArea(
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset(
              'assets/img/ur.jpeg',
              width: 50,
            ),
            SizedBox(
              width: size.width * 0.10,
            ),
            Text(this.textos, style: _textos),
          ],
        ),
      ),
    );
  }
}
