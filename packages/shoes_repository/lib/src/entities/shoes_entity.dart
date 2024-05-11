/// A model class representing shoes data in a database.
class ShoesEntity {

  /// Constructs a [ShoesEntity] object with the provided data.
  ShoesEntity({
    required this.shoesId,
    required this.picture,
    required this.name,
    required this.description,
    required this.price,
    required this.sizeShoes,
  });

  /// Constructs a [ShoesEntity] object from a document.
  ShoesEntity.fromDocument(Map<String, dynamic> doc)
    : shoesId = doc['shoesId'],
    picture = doc['picture'],
    name = doc['name'],
    description = doc['description'],
    price = doc['price'],
    sizeShoes = List<int>.from(doc['sizeShoes'],
  );

  /// The unique identifier for the shoes.
  String shoesId;

  /// The URL of the picture of the shoes.
  String picture;

  /// The name of the shoes.
  String name;

  /// The description of the shoes.
  String description;

  /// The price of the shoes.
  double price;

  /// The available sizes of the shoes.
  List<int> sizeShoes;

  /// Converts the [ShoesEntity] object to a document.
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
