import 'package:flutter/material.dart';
import 'package:inventariour/src/services/data-notifier.dart';
import 'package:inventariour/src/widgets/agregar-bldr.dart';
import 'package:inventariour/src/widgets/fondo.dart';
import 'package:inventariour/src/widgets/titulos.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

class AddStockPage extends StatefulWidget {
  @override
  _AddStockPageState createState() => _AddStockPageState();
}

class _AddStockPageState extends State<AddStockPage> {
  bool escaneo = false;
    
 @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
      Navigator.pushReplacementNamed(context, 'home');
  }
   scannerCodigo(BuildContext context) async {
  final productoService = Provider.of<DataNotifiter>(context, listen: false);
  final args = ModalRoute.of(context).settings.arguments as Map;
    String scannerCode = await FlutterBarcodeScanner.scanBarcode(
        '#2D96F5', 'Cancelar', false, ScanMode.BARCODE);
    if (scannerCode == '-1') {
       dispose();
       
    } else {
      productoService.idCodigo =  scannerCode;
      args['info'] = 'nuevo';
      
    }
  }
 
 
 

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map;
    if(args['info'] == 'continuar'){
      scannerCodigo(context);
    }
    final productoSerivices = Provider.of<DataNotifiter>(context);
    print('CODIGO ESCANEADO: => ${productoSerivices.idCodigo}');
    print('FOLIO: =>  ${productoSerivices.idFolio}');
    return Scaffold(
      body: Stack(
        children: [
          Fondo(),
          Titulos(textos: 'Stock'),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [_addStockWidget('Agregar')],
          )
        ],
      ),
    );
  }

  SingleChildScrollView _addStockWidget(String _titulo) {
    // final args = ModalRoute.of(context).settings.arguments as Map;
    // print('Argunmentos Stock $args');
    // if (args == null) {
    //   scannerCodigo(context);
    // }

    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            width: size.width * 0.90,
            padding: EdgeInsets.symmetric(vertical: 10),
            margin: EdgeInsets.symmetric(
              horizontal: size.width * 0.05,
            ),
            height: 50,
            child: Text(
              _titulo,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'dmfont',
                  fontStyle: FontStyle.normal,
                  fontSize: 20,
                  letterSpacing: 2),
            ),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10)),
                gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xff1f8100), Color(0xff0e3256)],
                )),
          ),
          Container(
            width: size.width * 0.90,
            margin: EdgeInsets.only(
                left: size.width * 0.05, right: size.width * 0.05),
            height: 300,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(4),
                    bottomRight: Radius.circular(4)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black54,
                    blurRadius: 5,
                    offset: Offset(3, 4),
                  ),
                ]),
            child: AgregarBldr(),
          ),
        ],
      ),
    );
  }
}
