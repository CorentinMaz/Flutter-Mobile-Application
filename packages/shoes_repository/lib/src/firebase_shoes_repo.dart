import 'dart:developer';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:shoes_repository/shoes_repository.dart';

/// A repository implementation using Firebase Firestore and Storage for managing shoes data.
class FirebaseShoesRepo implements ShoesRepo {
  /// The collection reference for shoes data in Firestore.
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

  @override
  Future<String> sendImage(Uint8List file, String name) async {
    try {
      final Reference firebaseStorageRef = FirebaseStorage
        .instance
        .ref()
        .child(name);

      await firebaseStorageRef.putData(
        file,
        SettableMetadata(
          contentType: 'image/jpeg',
        ),
      );
      return await firebaseStorageRef.getDownloadURL();
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> createShoes(Shoes shoes) async {
    try {
      return await shoesCollection
        .doc(shoes.shoesId)
        .set(shoes.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<Shoes> getShoesById(String id) async {
    try {
      final DocumentSnapshot<Map<String, dynamic>> doc = await shoesCollection.doc(id).get();
      if (doc.exists) {
        final ShoesEntity shoesEntity = ShoesEntity.fromDocument(doc.data()!);
        return Shoes.fromEntity(shoesEntity);
      } else {
        return Shoes.empty;
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
