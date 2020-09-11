class FavoriteModel {
  int id;
  String name;
  String price;
  String url;

  FavoriteModel({this.id, this.name, this.price, this.url});


  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'price': price,
    'url': url
  };

  factory FavoriteModel.fromMap(Map<String, dynamic> json) => new FavoriteModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      url: json['url']
  );

}