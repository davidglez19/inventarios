import 'package:flutter/material.dart';
import 'package:inventariour/src/widgets/agregar-bldr.dart';
import 'package:inventariour/src/widgets/fondo.dart';
import 'package:inventariour/src/widgets/titulos.dart';

class AddStockPage extends StatefulWidget {
  @override
  _AddStockPageState createState() => _AddStockPageState();
}

class _AddStockPageState extends State<AddStockPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
          children: [
            Fondo(),
            Titulos(textos: 'Stock'),
            Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _addStockWidget('Agregar')
      ],
            )

          ],
          
        ),
    );
  }

  SingleChildScrollView _addStockWidget(String _titulo){
   final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: size.width * 0.90,
            padding: EdgeInsets.symmetric(vertical:10),
            margin: EdgeInsets.symmetric(horizontal: size.width * 0.05,),
            height: 50,
            child: Text(_titulo, textAlign: TextAlign.center, style: TextStyle(color: Colors.white, fontFamily: 'dmfont', fontStyle: FontStyle.normal, fontSize: 20,letterSpacing: 2),),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xff1f8100),Color(0xff0e3256)],
              )
            ),
          ),
          
          Container(
            width: size.width * 0.90,
            margin: EdgeInsets.only(left:size.width * 0.05 , right: size.width * 0.05),
            height: 300,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(4), bottomRight: Radius.circular(4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 5,
                  offset: Offset(3,4),
                ),
              ]
            ),
            child: AgregarBldr() ,
          ),
          
        ],
      ),
    );
  }
}