class ShoesEntity {
  String shoesId;
  String picture;
  String name;
  String desciption;
  double price;
  List<int> sizeShoes;

  ShoesEntity({
    required this.shoesId,
    required this.picture,
    required this.name,
    required this.desciption,
    required this.price,
    required this.sizeShoes,
  });

  Map<String, Object?> toDocument() {
    return {
      'shoesId': shoesId,
      'picture': picture,
      'name': name,
      'desciption': desciption,
      'price': price,
      'sizeShoes': sizeShoes.map((e) => null),
    };
  }

  static ShoesEntity fromDocument(Map<String, dynamic> doc) {
    return ShoesEntity(
      shoesId: doc['shoesId'],
      picture: doc['picture'],
      name: doc['name'],
      desciption: doc['desciption'],
      price: doc['price'],
      sizeShoes: doc['sizeShoes'],
    );
  }
}