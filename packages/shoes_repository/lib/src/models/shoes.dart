import '../entities/entities.dart';

class Shoes {

  Shoes({
    required this.shoesId,
    required this.picture,
    required this.name,
    required this.description,
    required this.price,
    required this.sizeShoes,
  });
  Shoes.fromEntity(ShoesEntity entity)
      : shoesId = entity.shoesId,
        picture = entity.picture,
        name = entity.name,
        description = entity.description,
        price = entity.price,
        sizeShoes = entity.sizeShoes;
  String shoesId;
  String picture;
  String name;
  String description;
  double price;
  List<int> sizeShoes;

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
}
