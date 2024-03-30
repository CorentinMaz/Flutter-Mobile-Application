class ShoesEntity {
  String shoesId;
  String picture;
  String name;
  String description;
  double price;
  List<int> sizeShoes;

  ShoesEntity({
    required this.shoesId,
    required this.picture,
    required this.name,
    required this.description,
    required this.price,
    required this.sizeShoes,
  });

  Map<String, Object?> toDocument() {
    return {
      'shoesId': shoesId,
      'picture': picture,
      'name': name,
      'description': description,
      'price': price,
      'sizeShoes': sizeShoes,
    };
  }

  static ShoesEntity fromDocument(Map<String, dynamic> doc) {
    return ShoesEntity(
      shoesId: doc['shoesId'],
      picture: doc['picture'],
      name: doc['name'],
      description: doc['description'],
      price: doc['price'],
      sizeShoes: List<int>.from(doc['sizeShoes'] ?? []),
    );
  }
}
