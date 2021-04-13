import 'package:flutter/material.dart';

class BotonOpciones extends StatelessWidget {
  final IconData icono;
  final String texto;

  BotonOpciones({@required this.icono, @required this.texto});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
          color: Color(0xFFbfcacd),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              offset: Offset(2, 2),
              color: Colors.grey,
              blurRadius: 4,
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white70,
            maxRadius: 25,
            child: Icon(
              icono,
              color: Color(0xff0e3256),
              size: 32.5,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            texto,
            style: TextStyle(
                fontFamily: 'dmfont',
                fontStyle: FontStyle.italic,
                fontSize: 11.5,
                color: Color(0xff1f8100)),
          )
        ],
      ),
    );
  }
}
