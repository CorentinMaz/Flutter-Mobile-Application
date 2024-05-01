import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:flutter_application_1/blocs/create_shoes_bloc/create_shoes_bloc.dart';
import 'package:flutter_application_1/blocs/upload_picture_bloc/upload_picture_bloc.dart';
import 'package:flutter_application_1/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:flutter_application_1/screens/home/blocs/get_shoes_bloc/get_shoes_bloc.dart';
import 'package:flutter_application_1/screens/home/blocs/get_user_bloc/get_user_bloc.dart';
import 'package:flutter_application_1/screens/home/views/details_screen.dart';
import 'package:flutter_application_1/screens/shoes/create_shoes_screen.dart';
import 'package:flutter_application_1/screens/user/blocs/update_user_bloc/update_user_bloc.dart';
import 'package:flutter_application_1/screens/user/views/user_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:shoes_repository/shoes_repository.dart';
import 'package:user_repository/user_repository.dart';

/// The screen widget for the home screen.
class HomeScreen extends StatelessWidget {
  /// Constructs a [HomeScreen] widget.
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        title: Row(
          children: <Widget>[
            Image.asset(
              'assets/logosneakers.png',
              scale: 17,
            ),
            const SizedBox(
              width: 8,
            ),
            const Text(
              'SHOES',
              style: TextStyle(fontWeight: FontWeight.w900, fontSize: 30),
            ),
          ],
        ),
        actions: <Widget>[
          BlocBuilder<GetUserBloc, GetUserState>(
            builder: (BuildContext context, GetUserState state) {
              if (state is GetUserSuccess) {
                final MyUser user = state.user;
                if (user.role == 'admin') {
                  return IconButton(
                    onPressed: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => MultiBlocProvider(
                            providers: <SingleChildWidget>[
                              BlocProvider<CreateShoesBloc>(
                                create: (BuildContext context) =>
                                    CreateShoesBloc(
                                  FirebaseShoesRepo(),
                                ),
                              ),
                              BlocProvider<UploadPictureBloc>(
                                create: (BuildContext context) =>
                                    UploadPictureBloc(
                                  FirebaseShoesRepo(),
                                ),
                              ),
                            ],
                            child: const CreateShoesScreen(),
                          ),
                        ),
                      );
                    },
                    icon: const Icon(CupertinoIcons.add),
                  );
                } else {
                  return IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.cart),
                  );
                }
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          BlocBuilder<GetUserBloc, GetUserState>(
            builder: (BuildContext context, GetUserState state) {
              if (state is GetUserSuccess) {
                final MyUser user = state.user;
                return IconButton(
                  onPressed: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) =>
                            BlocProvider<UpdateUserBloc>(
                          create: (BuildContext context) => UpdateUserBloc(
                            context.read<AuthenticationBloc>().userRepository,
                          ),
                          child: UserScreen(
                            user: user,
                          ),
                        ),
                      ),
                    );
                  },
                  icon: const Icon(CupertinoIcons.profile_circled),
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
          IconButton(
            onPressed: () {
              context.read<SignInBloc>().add(SignOutRequired());
            },
            icon: const Icon(CupertinoIcons.power),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: BlocBuilder<GetShoesBloc, GetShoesState>(
          builder: (BuildContext context, GetShoesState state) {
            if (state is GetShoesSuccess) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 16,
                  childAspectRatio: 9 / 16,
                ),
                itemCount: state.shoes.length,
                itemBuilder: (BuildContext context, int i) {
                  return Material(
                    elevation: 3,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) => DetailsScreen(
                              state.shoes[i],
                              key: UniqueKey(),
                            ),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Image.network(
                            state.shoes[i].picture,
                            scale: 6,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              state.shoes[i].name,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Text(
                              state.shoes[i].description,
                              style: TextStyle(
                                fontSize: 10,
                                color: Colors.grey.shade500,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[
                                    Text(
                                      '${state.shoes[i].price}€',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                                IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    CupertinoIcons.heart,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            } else if (state is GetShoesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(
                child: Text(
                  'An error has occured...',
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
