
class ProductoApi {
    ProductoApi({
        this.articuloId,
        this.nombreArticulo,
        this.precioUnitario,
        this.existencia,
        this.unidadVenta,
    });

    int articuloId;
    String nombreArticulo;
    String precioUnitario;
    String existencia;
    String unidadVenta;

    factory ProductoApi.fromJson(Map<String, dynamic> json) => ProductoApi(
        articuloId     : json["ARTICULO_ID"],
        nombreArticulo : json["NOMBRE_ARTICULO"],
        precioUnitario : json["PRECIO_UNITARIO"],
        existencia     : json["EXISTENCIA"],
        unidadVenta    : json["UNIDAD_VENTA"],
    );

    Map<String, dynamic> toJson() => {
        "ARTICULO_ID"     : articuloId,
        "NOMBRE_ARTICULO" : nombreArticulo,
        "PRECIO_UNITARIO" : precioUnitario,
        "EXISTENCIA"      : existencia,
        "UNIDAD_VENTA"    : unidadVenta,
    };
}
