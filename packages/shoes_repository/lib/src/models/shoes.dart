import '../entities/entities.dart';

class Shoes {
  String shoesId;
  String picture;
  String name;
  String description;
  double price;
  List<int> sizeShoes;

  Shoes({
    required this.shoesId,
    required this.picture,
    required this.name,
    required this.description,
    required this.price,
    required this.sizeShoes,
  });

  ShoesEntity toEntity() {
    return ShoesEntity(
      shoesId: shoesId,
      picture: picture,
      name: name,
      description: description,
      price: price,
      sizeShoes: sizeShoes,
    );
  }

  static Shoes fromEntity(ShoesEntity entity) {
    return Shoes(
      shoesId: entity.shoesId,
      picture: entity.picture,
      name: entity.name,
      description: entity.description,
      price: entity.price,
      sizeShoes: entity.sizeShoes,
    );
  }
}
