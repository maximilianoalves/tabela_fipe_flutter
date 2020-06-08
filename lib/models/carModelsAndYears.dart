class CarModelsAndYears {
  String fipeCodigo;
  String name;
  String key;
  String veiculo;
  String id;

  CarModelsAndYears(
      {this.fipeCodigo, this.name, this.key, this.veiculo, this.id}
  );

  factory CarModelsAndYears.fromJson(Map<String, dynamic> json) {
    return CarModelsAndYears (
      fipeCodigo: json['fipe_codigo'],
      name: json['name'],
      key: json['key'],
      veiculo: json['veiculo'],
      id: json['id']
    );
  }
}