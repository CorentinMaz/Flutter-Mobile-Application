import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:shoes_repository/shoes_repository.dart';
import 'package:sneakboutique/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:sneakboutique/blocs/create_shoes_bloc/create_shoes_bloc.dart';
import 'package:sneakboutique/blocs/upload_picture_bloc/upload_picture_bloc.dart';
import 'package:sneakboutique/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:sneakboutique/screens/auth/views/welcome_screen.dart';
import 'package:sneakboutique/screens/home/blocs/get_shoes_bloc/get_shoes_bloc.dart';
import 'package:sneakboutique/screens/home/blocs/get_user_bloc/get_user_bloc.dart';
import 'package:sneakboutique/screens/home/views/home_screen.dart';
import 'package:sneakboutique/screens/user/blocs/update_user_bloc/update_user_bloc.dart';
import 'package:user_repository/user_repository.dart';

/// The main view of the application.
class MyAppView extends StatelessWidget {
  /// Constructs a [MyAppView].
  const MyAppView({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Eshop shoes',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          background: Colors.grey.shade200,
          primary: Colors.blue,
        ),
      ),
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (BuildContext context, AuthenticationState state) {
          if (state.status == AuthenticationStatus.authenticated) {
            return MultiBlocProvider(
              providers: <SingleChildWidget>[
                BlocProvider<SignInBloc>(
                  create: (BuildContext context) => SignInBloc(
                    context.read<AuthenticationBloc>().userRepository,
                  ),
                ),
                BlocProvider<GetShoesBloc>(
                  create: (BuildContext context) =>
                      GetShoesBloc(FirebaseShoesRepo())..add(GetShoes()),
                ),
                BlocProvider<GetUserBloc>(
                  create: (BuildContext context) =>
                      GetUserBloc(FirebaseUserRepo())..add(GetUser()),
                ),
                BlocProvider<UploadPictureBloc>(
                  create: (BuildContext context) =>
                      UploadPictureBloc(FirebaseShoesRepo()),
                ),
                BlocProvider<CreateShoesBloc>(
                  create: (BuildContext context) =>
                      CreateShoesBloc(FirebaseShoesRepo()),
                ),
                BlocProvider<UpdateUserBloc>(
                  create: (BuildContext context) => UpdateUserBloc(
                    context.read<AuthenticationBloc>().userRepository,
                  ),
                ),
              ],
              child: const HomeScreen(),
            );
          } else {
            return const WelcomeScreen();
          }
        },
      ),
    );
  }
}
