import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';
import 'package:user_repository/user_repository.dart';

/// Implementation of [UserRepository] using Firebase authentication and Firestore.
class FirebaseUserRepo implements UserRepository {

  /// Constructs a [FirebaseUserRepo] with an optional [FirebaseAuth] instance.
  /// If no [firebaseAuth] is provided, it defaults to [FirebaseAuth.instance].
  FirebaseUserRepo({
    FirebaseAuth? firebaseAuth,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  final FirebaseAuth _firebaseAuth;

  /// Collection reference for the 'users' collection in Firestore.
	final CollectionReference<Map<String, dynamic>> usersCollection = FirebaseFirestore.instance.collection('users');

  @override
  Stream<MyUser?> get user {
    return _firebaseAuth.authStateChanges().flatMap((User? firebaseUser) async* {
      if(firebaseUser == null) {
        yield MyUser.empty;
      } else {
        yield await usersCollection
          .doc(firebaseUser.uid)
          .get()
          .then((DocumentSnapshot<Map<String, dynamic>> value) => MyUser.fromEntity(MyUserEntity.fromDocument(value.data()!)));
      }
    });
  }

  @override
  Future<void> signIn(String email, String password) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<MyUser> signUp(MyUser myUser, String password) async {
    try {
      final UserCredential user = await _firebaseAuth.createUserWithEmailAndPassword(
        email: myUser.email,
        password: password,
      );

      myUser.userId = user.user!.uid;
      return myUser;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  @override
  Future<void> setUserData(MyUser myUser) async {
    try {
      await usersCollection
        .doc(myUser.userId)
        .set(myUser.toEntity().toDocument());
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
}
