import 'dart:typed_data';

import 'package:shoes_repository/src/models/models.dart';

/// Abstract class defining methods for managing shoes data.
abstract class ShoesRepo {
  /// Retrieves a list of shoes.
  Future<List<Shoes>> getShoes();

  /// Sends an image to a storage location and returns its URL.
  Future<String> sendImage(Uint8List file, String name);

  /// Creates a new shoes entry.
  Future<void> createShoes(Shoes shoes);
}
