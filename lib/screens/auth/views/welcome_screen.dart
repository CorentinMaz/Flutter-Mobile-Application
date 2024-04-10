import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_application_1/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_application_1/screens/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:flutter_application_1/screens/auth/views/sign_in_screen.dart';
import 'package:flutter_application_1/screens/auth/views/sign_up_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// A screen that welcomes users and allows them to sign in or sign up.
class WelcomeScreen extends StatefulWidget {
  /// Constructs a [WelcomeScreen].
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with TickerProviderStateMixin {
  late TabController tabController;

  @override
  void initState() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.shadow,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  '../../../Assets/shoes7.png', // Remplacez par le chemin de votre image
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
                child: Container(),
              ),
              Align(
                child: SizedBox(
                  height: MediaQuery.of(context).size.height / 1.8,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 50),
                        child: TabBar(
                          controller: tabController,
                          unselectedLabelColor: Theme.of(context)
                              .colorScheme
                              .onBackground
                              .withOpacity(0.5),
                          labelColor:
                              Theme.of(context).colorScheme.onBackground,
                          tabs: const <Widget>[
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                'Sign In',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: TabBarView(
                          controller: tabController,
                          children: <Widget>[
                            BlocProvider<SignInBloc>(
                              create: (BuildContext context) => SignInBloc(
                                context
                                    .read<AuthenticationBloc>()
                                    .userRepository,
                              ),
                              child: const SignInScreen(),
                            ),
                            BlocProvider<SignUpBloc>(
                              create: (BuildContext context) => SignUpBloc(
                                context
                                    .read<AuthenticationBloc>()
                                    .userRepository,
                              ),
                              child: const SignUpScreen(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
