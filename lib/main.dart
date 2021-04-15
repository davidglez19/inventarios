import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:inventariour/src/pages/add-stock.dart';

import 'package:inventariour/src/pages/home.dart';
import 'package:inventariour/src/pages/listar-conteo.dart';
import 'package:inventariour/src/pages/listar-productos.dart';
import 'package:inventariour/src/pages/new-count.dart';
import 'package:inventariour/src/services/producto-Api.service.dart';
import 'package:provider/provider.dart';

void main() {
  WidgetsFlutterBinding();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ServicioProductoApi())],
      child: MaterialApp(
        initialRoute: 'home',
        routes: {
          'home': (BuildContext context) => HomePage(),
          'nuevo': (BuildContext context) => NewCountPage(),
          'stock': (BuildContext contex) => AddStockPage(),
          'listar': (BuildContext contex) => ListarPage(),
          'listar-productos': (BuildContext contex) => ListarProductosPage()
        },
      ),
    );
  }
}
