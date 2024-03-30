import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoes_repository/shoes_repository.dart';

class FirebaseShoesRepo implements ShoesRepo {
    final shoesCollection = FirebaseFirestore.instance.collection('shoes');

  Future<List<Shoes>> getShoes() async {
    try {
      return await shoesCollection
        .get()
        .then((value) => value.docs.map((e) =>
          Shoes.fromEntity(ShoesEntity.fromDocument(e.data()))
        ).toList());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}