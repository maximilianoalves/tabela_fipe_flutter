class CarFuelAndYears {
  String fipeCodigo;
  String name;
  String key;
  String veiculo;
  String id;

  CarFuelAndYears(
      {this.fipeCodigo, this.name, this.key, this.veiculo, this.id}
  );

  factory CarFuelAndYears.fromJson(Map<String, dynamic> json) {
    return CarFuelAndYears (
      fipeCodigo: json['fipe_codigo'],
      name: json['name'],
      key: json['key'],
      veiculo: json['veiculo'],
      id: json['id']
    );
  }
}