import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:inventariour/src/models/producto-Api.model.dart';
import 'package:inventariour/src/models/producto-sql.model.dart';
import 'package:inventariour/src/services/producto-Api.service.dart';
import 'package:inventariour/src/services/producto-sql.services.dart';
import 'package:provider/provider.dart';

class AgregarBldr extends StatefulWidget {
  final String folio;

  AgregarBldr({@required this.folio});

  @override
  _AgregarBldrState createState() => _AgregarBldrState(folio: this.folio);
}

class _AgregarBldrState extends State<AgregarBldr> {
  String folio;

  _AgregarBldrState({this.folio});

  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();

  String _existencias;
  final _existenciasController = TextEditingController();
  DBProductos dbProductos;

  final servicioProductoApi = new ServicioProductoApi();
  final _titulo = TextStyle(
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

  Future scannerCodigo(BuildContext context) async {
    final productoServices = Provider.of<ServicioProductoApi>(context);
    String scannerCode = await FlutterBarcodeScanner.scanBarcode(
        '#2D96F5', 'Cancelar', false, ScanMode.BARCODE);
    if (scannerCode == '-1') {
      return Navigator.popAndPushNamed(context, 'home');
      // return Navigator.pushNamed(context, 'respuesta');
    } else {
      productoServices.idCodigo = scannerCode;
    }
  }

  @override
  void initState() {
    super.initState();
    dbProductos = DBProductos();
  }

  @override
  Widget build(BuildContext context) {
    final productoServices = Provider.of<ServicioProductoApi>(context);
    final args = ModalRoute.of(context).settings.arguments as Map;
    if (folio == null) {
      folio = args['folio'];
    } else {
      folio = folio;
      print('Folio seleccionado $folio');
    }
    return FutureBuilder(
      future: servicioProductoApi.getProducto(productoServices.idCodigo),
      builder: (BuildContext context, AsyncSnapshot<ProductoApi> snapshot) {
        if (!snapshot.hasData) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasData && snapshot.data.nombreArticulo != null) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 10),
              Text(
                'Descripción del producto',
                style: _titulo,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
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
                          labelStyle: TextStyle(color: Colors.teal[300])),
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        print('Valor folio $folio');
                        if (_formStateKey.currentState.validate()) {
                          _formStateKey.currentState.save();
                          dbProductos.add(ProductoSql(
                              id: null,
                              folio: this.folio,
                              descripcion: snapshot.data.nombreArticulo,
                              existencia: _existencias));
                          _existenciasController.text = '';
                          Navigator.popAndPushNamed(context, 'stock',
                              arguments: {'folio': this.folio});
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
          return Text('Código no encontrado');
        }
      },
    );
  }
}
