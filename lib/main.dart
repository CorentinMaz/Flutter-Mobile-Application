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
          'AIzaSyAvHZomr6E2-mcH2X-PS5h-vM0fPETK3d0', // paste your api key here
      authDomain: 'sneak-boutique.firebaseapp.com',
      appId:
          '1:609122838747:web:e7875e8b45b0c3859ac4fe', //paste your app id here
      messagingSenderId: '609122838747', //paste your messagingSenderId here
      projectId: 'sneak-boutique', //paste your project id here
      storageBucket: 'sneak-boutique.appspot.com',
    ),
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(FirebaseUserRepo()));
}
