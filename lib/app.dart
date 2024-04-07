import 'package:flutter/material.dart';
import 'package:flutter_application_1/app_view.dart';
import 'package:flutter_application_1/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';

/// The main application widget.
class MyApp extends StatelessWidget {
  /// Creates a [MyApp].
  ///
  /// The [userRepository] must not be null.
  const MyApp(this.userRepository, {super.key});

  /// The repository for managing user data.
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
