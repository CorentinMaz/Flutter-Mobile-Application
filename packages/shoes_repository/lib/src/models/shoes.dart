import 'dart:ffi';

import 'package:uuid/uuid.dart';

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
  static Shoes empty = Shoes(
		shoesId: const Uuid().v1(),
    picture: '',
    name: '',
    description: '',
    price: 0,
    sizeShoes: <int>[],
	);

  @override
  String toString() {
    return '''
      shoesId: $shoesId,
      picture: $picture,
      name: $name,
      description: $description,
      price: $price,
      sizeShoes: $sizeShoes,
    ''';
  }
}
