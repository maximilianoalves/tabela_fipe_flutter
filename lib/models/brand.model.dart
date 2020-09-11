class Brand {
  String key;
  int id;
  String fipeName;
  String name;

  Brand({
    this.key,
    this.id,
    this.fipeName,
    this.name,
  });

  factory Brand.fromJson(Map<String, dynamic> json) {
    return Brand(
      key: json['key'],
      id: json['id'],
      fipeName: json['fipeName'],
      name: json['name'],
    );
  }
}
