import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sneakboutique/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:sneakboutique/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:sneakboutique/screens/auth/blocs/sign_up_bloc/sign_up_bloc.dart';
import 'package:sneakboutique/screens/auth/views/sign_in_screen.dart';
import 'package:sneakboutique/screens/auth/views/sign_up_screen.dart';

/// A screen that welcomes users and allows them to sign in or sign up.
class WelcomeScreen extends StatefulWidget {
  /// Constructs a [WelcomeScreen].
  const WelcomeScreen({super.key});

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
      backgroundColor: Theme.of(context).colorScheme.background,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Align(
                alignment: const AlignmentDirectional(20, -1.2),
                child: Container(
                  height: MediaQuery.of(context).size.width,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.tertiary,
                  ),
                ),
              ),
              Align(
                alignment: const AlignmentDirectional(2.7, -1.2),
                child: Container(
                  height: MediaQuery.of(context).size.width / 1.3,
                  width: MediaQuery.of(context).size.width / 1.3,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              ),
              BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 100, sigmaY: 100),
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
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  fontSize: 18,
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
                                context.read<AuthenticationBloc>().userRepository,
                              ),
                              child: const SignInScreen(),
                            ),
                            BlocProvider<SignUpBloc>(
                              create: (BuildContext context) => SignUpBloc(
                                context.read<AuthenticationBloc>().userRepository,
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