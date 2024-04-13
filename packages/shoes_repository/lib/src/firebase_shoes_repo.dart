import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shoes_repository/shoes_repository.dart';

class FirebaseShoesRepo implements ShoesRepo {
    final CollectionReference<Map<String, dynamic>> shoesCollection = FirebaseFirestore.instance.collection('shoes');

  @override
  Future<List<Shoes>> getShoes() async {
    try {
      return await shoesCollection
        .get()
        .then((QuerySnapshot<Map<String, dynamic>> value) => value.docs.map((QueryDocumentSnapshot<Map<String, dynamic>> e) =>
          Shoes.fromEntity(ShoesEntity.fromDocument(e.data())),
        ).toList(),);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
