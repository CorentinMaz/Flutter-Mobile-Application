import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sneakboutique/app.dart';
import 'package:sneakboutique/simple_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:
          'AIzaSyA_UOaQBJrs7WP2Ex_pqYOq55DsuCX17Q8', // paste your api key here
      appId:
          '1:609122838747:android:620178ca0b09da379ac4fe', //paste your app id here
      messagingSenderId: '609122838747', //paste your messagingSenderId here
      projectId: 'sneak-boutique', //paste your project id here
      storageBucket: 'gs://sneak-boutique.appspot.com',
    ),
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(FirebaseUserRepo()));
}
