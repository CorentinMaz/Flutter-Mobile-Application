import 'package:shoes_repository/src/entities/entities.dart';
import 'package:uuid/uuid.dart';

/// A model class representing shoes data.
class Shoes {
  /// Constructs a [Shoes] object with the provided data.
  Shoes({
    required this.shoesId,
    required this.picture,
    required this.name,
    required this.description,
    required this.price,
    required this.sizeShoes,
  });

  /// Constructs a [Shoes] object from a [ShoesEntity].
  Shoes.fromEntity(ShoesEntity entity)
      : shoesId = entity.shoesId,
        picture = entity.picture,
        name = entity.name,
        description = entity.description,
        price = entity.price,
        sizeShoes = entity.sizeShoes;

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

  /// Converts the [Shoes] object to a [ShoesEntity].
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

  /// An empty instance of [Shoes].
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
