import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/app.dart';
import 'package:flutter_application_1/simple_bloc_observer.dart';
import 'package:user_repository/user_repository.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey:
          'AIzaSyBpDAVlk6eZsHl9yMgsCauZdjL1cC3En68', // paste your api key here
      appId:
          '1:520767960590:android:fe1d43196a98cf29caee5f', //paste your app id here
      messagingSenderId: '520767960590', //paste your messagingSenderId here
      projectId: 'eshopshoes-17628', //paste your project id here
      storageBucket: 'gs://eshopshoes-17628.appspot.com',
    ),
  );
  Bloc.observer = SimpleBlocObserver();
  runApp(MyApp(FirebaseUserRepo()));
}
