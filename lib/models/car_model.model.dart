class CarModel {
  String key;
  String id;
  String fipeName;
  String name;

  CarModel({
    this.key,
    this.id,
    this.fipeName,
    this.name,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      key: json['key'],
      id: json['id'],
      fipeName: json['fipe_name'],
      name: json['name'],
    );
  }
}
