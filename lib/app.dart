import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sneakboutique/app_view.dart';
import 'package:sneakboutique/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:user_repository/user_repository.dart';

/// Root widget of the application.
class MyApp extends StatelessWidget {

  /// Constructs a [MyApp] with the provided [userRepository].
  const MyApp(this.userRepository, {super.key});

  /// Repository for managing user data.
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider<AuthenticationBloc>(
      create: (BuildContext context) => AuthenticationBloc(
        userRepository: userRepository,
      ),
      child: const MyAppView(),
    );
  }
}
