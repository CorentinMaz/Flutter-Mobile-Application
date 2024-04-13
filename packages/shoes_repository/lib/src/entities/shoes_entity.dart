class ShoesEntity {

  ShoesEntity({
    required this.shoesId,
    required this.picture,
    required this.name,
    required this.description,
    required this.price,
    required this.sizeShoes,
  });

  ShoesEntity.fromDocument(Map<String, dynamic> doc)
      : shoesId = doc['shoesId'],
      picture = doc['picture'],
      name = doc['name'],
      description = doc['description'],
      price = doc['price'],
      sizeShoes = List<int>.from(doc['sizeShoes']);
  String shoesId;
  String picture;
  String name;
  String description;
  double price;
  List<int> sizeShoes;

  Map<String, Object?> toDocument() {
    return <String, Object?>{
      'shoesId': shoesId,
      'picture': picture,
      'name': name,
      'description': description,
      'price': price,
      'sizeShoes': sizeShoes,
    };
  }
}
