class ProductoSql {
  int id;
  String folio;
  String descripcion;
  String existencia;

  ProductoSql({this.id,this.folio, this.descripcion, this.existencia});

  Map<String, dynamic> toMap(){
    var map = <String, dynamic> {
      'id'         : id,
      'folio'      : folio,
      'descripcion': descripcion,
      'existencia'  : existencia
    };
    return map;
  }

  ProductoSql.fromMap(Map<String, dynamic> map) {
    id          = map['id'];
    folio       = map['folio'];
    descripcion = map['descripcion'];
    existencia   = map['existencia'];
  }

}