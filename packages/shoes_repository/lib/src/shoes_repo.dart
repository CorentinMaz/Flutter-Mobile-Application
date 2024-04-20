import 'dart:typed_data';

import 'models/models.dart';

abstract class ShoesRepo {
    Future<List<Shoes>> getShoes();

    Future<String> sendImage(Uint8List file, String name);

    Future<void> createShoes(Shoes shoes);
}
