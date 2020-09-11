class Car {
  String id;
  String anoModelo;
  String marca;
  String name;
  String veiculo;
  String preco;
  String combustivel;
  String referencia;
  String fipeCodigo;
  String key;

  Car({
    this.id,
    this.anoModelo,
    this.marca,
    this.name,
    this.veiculo,
    this.preco,
    this.combustivel,
    this.referencia,
    this.fipeCodigo,
    this.key,
  });

  factory Car.fromJson(Map<String, dynamic> json) {
    return Car(
      id: json['id'],
      anoModelo: json['ano_modelo'],
      marca: json['marca'],
      name: json['name'],
      veiculo: json['veiculo'],
      preco: json['preco'],
      combustivel: json['combustivel'],
      referencia: json['referencia'],
      fipeCodigo: json['fipe_codigo'],
      key: json['key'],
    );
  }
}
