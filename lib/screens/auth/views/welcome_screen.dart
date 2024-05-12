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
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: <Widget>[
              Positioned(
                top: 50, // Position verticale du contenu
                left: 0, // Position horizontale du contenu
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center, // Centrer l'image et le texte horizontalement
                  children: <Widget>[
                    Image.asset(
                      'assets/logosneakers.png', // Chemin de l'image dans le dossier assets
                      width: 75, // Largeur de l'image
                      height: 75, // Hauteur de l'image
                    ),
                    const SizedBox(width: 10), // Espacement entre l'image et le texte
                    const Text(
                      'SneakBoutique',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 24, // Taille du texte
                        fontWeight: FontWeight.bold, // Gras
                      ),
                    ),
                  ],
                ),
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
                                  color: Colors.black,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(12),
                              child: Text(
                                'Sign Up',
                                style: TextStyle(
                                  color: Colors.black,
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
