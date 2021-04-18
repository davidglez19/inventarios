import 'package:flutter/material.dart';
import 'package:inventariour/src/models/producto-Api.model.dart';
import 'package:inventariour/src/models/producto-sql.model.dart';
import 'package:inventariour/src/services/data-notifier.dart';
import 'package:inventariour/src/services/producto-Api.service.dart';
import 'package:inventariour/src/services/producto-sql.services.dart';

import 'package:inventariour/src/widgets/fondo.dart';
import 'package:inventariour/src/widgets/titulos.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:provider/provider.dart';

class AddStockPage extends StatefulWidget {
  @override
  _AddStockPageState createState() => _AddStockPageState();
}

class _AddStockPageState extends State<AddStockPage> {
  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();

  String _existencias;
  final _existenciasController = TextEditingController();
  DBProductos dbProductos;

  final servicioProductoApi = new ServicioProductoApi();
  final _tituloStyle = TextStyle(
      fontSize: 20,
      fontFamily: 'dmfont',
      fontStyle: FontStyle.normal,
      color: Color(0xFF335422));
  final _descripcion = TextStyle(
    fontSize: 20,
    fontFamily: 'dmfont',
    fontStyle: FontStyle.italic,
    color: Color(0xff0e3256),
  );

  bool escaneo = false;

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> scannerCodigo(BuildContext context) async {
    final productoService = Provider.of<DataNotifiter>(context, listen: false);
    final args = ModalRoute.of(context).settings.arguments as Map;
    String scannerCode = await FlutterBarcodeScanner.scanBarcode(
        '#2D96F5', 'Cancelar', false, ScanMode.BARCODE);
    if (scannerCode == '-1') {
      if (mounted) {
        setState(() {
          _regresasrAlHome();
        });
      }
    } else {
      productoService.idCodigo = scannerCode;
      args['info'] = 'nuevo';
      return Navigator.popAndPushNamed(context, 'stock');
    }
  }

  _regresasrAlHome() {
    Navigator.of(context)
        .pushNamedAndRemoveUntil('home', ModalRoute.withName('home'));
  }

  @override
  void initState() {
    super.initState();
    dbProductos = DBProductos();
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map;
    if (args['info'] == 'continuar') {
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
    final productoSerivices = Provider.of<DataNotifiter>(context);
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
            child: FutureBuilder(
              future:
                  servicioProductoApi.getProducto(productoSerivices.idCodigo),
              builder:
                  (BuildContext context, AsyncSnapshot<ProductoApi> snapshot) {
                final args = ModalRoute.of(context).settings.arguments as Map;
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasData &&
                    snapshot.data.nombreArticulo != null) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SizedBox(height: 10),
                      Text(
                        'Descripción del producto',
                        style: _tituloStyle,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 18, vertical: 12),
                        child: Text(
                          snapshot.data.nombreArticulo,
                          style: _descripcion,
                        ),
                      ),
                      Form(
                          key: _formStateKey,
                          autovalidateMode: AutovalidateMode.always,
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 18, right: 18, top: 12, bottom: 10),
                            child: TextFormField(
                              keyboardType: TextInputType.number,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Es necesario anexar un valor';
                                }
                                if (!value.startsWith(RegExp('[0-9]'))) {
                                  return 'Debe comenzar con un valor entero';
                                }
                                if (value.contains(' ') ||
                                    value.contains('.') ||
                                    value.contains(',') ||
                                    value.contains('-')) {
                                  return 'Valor invalido';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _existencias = value;
                              },
                              controller: _existenciasController,
                              decoration: InputDecoration(
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.teal[300],
                                      width: 2,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  labelText: 'Existencias',
                                  icon: Icon(
                                    Icons.description,
                                    color: Colors.teal[300],
                                  ),
                                  fillColor: Colors.white,
                                  labelStyle:
                                      TextStyle(color: Colors.teal[300])),
                            ),
                          )),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ElevatedButton(
                              onPressed: () {
                                print(
                                    'Valor folio ${productoSerivices.idFolio}');
                                if (_formStateKey.currentState.validate()) {
                                  _formStateKey.currentState.save();
                                  dbProductos.add(ProductoSql(
                                      id: null,
                                      folio: productoSerivices.idFolio,
                                      descripcion: snapshot.data.nombreArticulo,
                                      existencia: _existencias));
                                  _existenciasController.text = '';
                                  args['info'] = 'continuar';
                                  scannerCodigo(context);
                                }
                              },
                              child: Text('Agregar')),
                          SizedBox(
                            width: 10,
                          ),
                          ElevatedButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.red)),
                              onPressed: () {
                                Navigator.popAndPushNamed(context, 'home');
                              },
                              child: Text('Cancelar')),
                        ],
                      )
                    ],
                  );
                } else {
                  return Center(child: Text('Código no encontrado'));
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
