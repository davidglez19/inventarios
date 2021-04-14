import 'package:flutter/material.dart';
import 'package:inventariour/src/models/producto-Api.model.dart';
import 'package:inventariour/src/models/producto-sql.model.dart';
import 'package:inventariour/src/services/producto-Api.service.dart';
import 'package:inventariour/src/services/producto-sql.services.dart';


class AgregarBldr extends StatefulWidget {
  final String folio;
  final String productoBar;
  
  AgregarBldr({@required this.folio, @required this.productoBar});

  @override
  _AgregarBldrState createState() => _AgregarBldrState(folio: this.folio, productoBar: this.productoBar);
}

class _AgregarBldrState extends State<AgregarBldr> {
  String folio;
  String productoBar;

  
  
  

  _AgregarBldrState({this.folio, this.productoBar});

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

  @override
  void initState() {
    super.initState();
    dbProductos = DBProductos();
    
  }

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context).settings.arguments as Map;
    (folio != null) ? folio = folio : folio = args['folio'];
    return FutureBuilder(
      future: servicioProductoApi.getProducto(productoBar),
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
