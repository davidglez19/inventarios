import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:inventariour/src/models/producto-Api.model.dart';

class ServicioProductoApi {

//http://ursoft.ddns.net/verificator-app/v1/articulos/123

Future<ProductoApi> getProducto(String id) async {
final  String _url = 'ursoft.ddns.net';

final url = Uri.http(_url, 'verificator-app/v1/articulos/$id');

final resp = await http.get(url);
print(resp.body);
final decodedData = json.decode(resp.body);
print(decodedData);

final producto = new ProductoApi.fromJson(decodedData);
print(producto.nombreArticulo);
return producto;

}




}