void main() {
  List<Map<String, dynamic>> productos = [
    {"nombre": "Celular", "precio": 100000, "descuento": 0.10, "iva": 0.19},
    {"nombre": "Televisor", "precio": 150000, "descuento": 0.15, "iva": 0.19},
    {"nombre": "Licuadora", "precio": 200000, "descuento": 0.20, "iva": 0.19},
  ];

  productos.forEach((producto) {
    double precio = producto["precio"].toDouble();
    double descuento = producto["descuento"];
    double iva = producto["iva"];

    double precioConDescuento = precio - (precio * descuento);

    double precioFinal = precioConDescuento + (precioConDescuento * iva);

    print(
        "El precio final del producto: ${producto['nombre']} es: \$${precioFinal.toStringAsFixed(2)} COP");
  });
}
