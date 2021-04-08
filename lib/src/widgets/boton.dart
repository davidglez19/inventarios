import 'package:flutter/material.dart';

class BotonOpciones extends StatelessWidget {
  final IconData icono;
  final String texto;

  BotonOpciones({@required this.icono, @required this.texto});

  @override
  Widget build(BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.only(top: 20),
      width: _size.width * 0.35,
      height: _size.width * 0.35,
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          CircleAvatar(
            backgroundColor: Colors.white70,
            maxRadius: 30,
            child: Icon(
              icono,
              color: Color(0xff0e3256),
              size: 35,
            ),
          ),
          Text(
            texto,
            style: TextStyle(
                fontFamily: 'dmfont',
                fontStyle: FontStyle.italic,
                fontSize: 12.5,
                color: Color(0xff1f8100)),
          )
        ],
      ),
    );
  }
}
