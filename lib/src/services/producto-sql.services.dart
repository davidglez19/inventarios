


import 'package:inventariour/src/models/producto-sql.model.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:io' as io;   
import 'package:path/path.dart';    

class DBProductos {
  
  static Database _db;

  Future<Database> get db async {
    if(_db !=null){
      return _db;
    }else{
      _db = await initDataBase();
      return _db;
    }
  }
  initDataBase() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'listaproductos.db');
    var db = await openDatabase(path, version:1, onCreate: _onCreate);
    return db;
  }
  _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE productos (id INTEGER PRIMARY KEY, folio TEXT, descripcion TEXT, existencia TEXT)');
  }

  Future<ProductoSql> add(ProductoSql producto) async {
    var dbClient = await db;
    producto.id = await dbClient.insert('productos', producto.toMap());
    print('Producto guardato');
    return producto;
  }

  Future<List<ProductoSql>> getProductosLista() async{
    var dbClient = await db;
    List<Map> maps = await dbClient.query('productos', columns: ['id','folio','descripcion','existencia']);
    List<ProductoSql> productos = [];
    if(maps.length > 0){
      for(var producto in maps ){
        productos.add(ProductoSql.fromMap(producto));
      }
    }
    return productos;
  }

  



}