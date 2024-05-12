import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nested/nested.dart';
import 'package:shoes_repository/shoes_repository.dart';
import 'package:sneakboutique/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:sneakboutique/blocs/create_shoes_bloc/create_shoes_bloc.dart';
import 'package:sneakboutique/blocs/get_shoes_by_id_bloc/get_shoes_by_id_bloc.dart';
import 'package:sneakboutique/blocs/upload_picture_bloc/upload_picture_bloc.dart';
import 'package:sneakboutique/screens/auth/blocs/sign_in_bloc/sign_in_bloc.dart';
import 'package:sneakboutique/screens/home/blocs/get_shoes_bloc/get_shoes_bloc.dart';
import 'package:sneakboutique/screens/home/blocs/get_user_bloc/get_user_bloc.dart';
import 'package:sneakboutique/screens/home/views/details_sreen.dart';
import 'package:sneakboutique/screens/shoes/create_shoes_screen.dart';
import 'package:sneakboutique/screens/shoes/panier_screen.dart';
import 'package:sneakboutique/screens/user/blocs/update_user_bloc/update_user_bloc.dart';
import 'package:sneakboutique/screens/user/views/user_screen.dart';
import 'package:user_repository/user_repository.dart';

/// The screen widget for the home screen.
class HomeScreen extends StatefulWidget {
  /// Constructs a [HomeScreen] widget.
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  dynamic _getRequests() async {
    context.read<GetUserBloc>().add(GetUser());
    context.read<GetShoesBloc>().add(GetShoes());
  }

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
                      ).then((void value) => <void>{_getRequests()});
                    },
                    icon: const Icon(CupertinoIcons.add),
                  );
                } else {
                  return IconButton(
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (BuildContext context) => MultiBlocProvider(
                            providers: <SingleChildWidget>[
                              BlocProvider<GetShoesByIdBloc>(
                                create: (BuildContext context) =>
                                    GetShoesByIdBloc(
                                  FirebaseShoesRepo(),
                                ),
                              ),
                            ],
                            child: PanierScreen(
                              user: user,
                            ),
                          ),
                        ),
                      );
                    },
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
                  color: const Color.fromRGBO(238, 238, 238, 1),
                  onPressed: () async {
                    await Navigator.of(context)
                        .push(
                          MaterialPageRoute<void>(
                            builder: (BuildContext context) =>
                                MultiBlocProvider(
                              providers: <SingleChildWidget>[
                                BlocProvider<UpdateUserBloc>(
                                  create: (BuildContext context) =>
                                      UpdateUserBloc(
                                    context
                                        .read<AuthenticationBloc>()
                                        .userRepository,
                                  ),
                                ),
                                BlocProvider<UploadPictureBloc>(
                                  create: (BuildContext context) =>
                                      UploadPictureBloc(
                                    FirebaseShoesRepo(),
                                  ),
                                ),
                              ],
                              child: UserScreen(
                                user: user,
                              ),
                            ),
                          ),
                        )
                        .then((void value) => <void>{_getRequests()});
                  },
                  icon: user.picture != ''
                      ? CircleAvatar(
                          backgroundImage: NetworkImage(user.picture),
                        )
                      : const Icon(
                          CupertinoIcons.profile_circled,
                          color: Colors.grey,
                        ),
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
        padding: const EdgeInsets.all(32),
        child: BlocBuilder<GetShoesBloc, GetShoesState>(
          builder: (BuildContext context, GetShoesState state) {
            if (state is GetShoesSuccess) {
              return GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: MediaQuery.of(context).size.width > 900
                      ? 5
                      : MediaQuery.of(context).size.width > 600
                          ? 3
                          : 2,
                  crossAxisSpacing: 32,
                  mainAxisSpacing: 32,
                  childAspectRatio: MediaQuery.of(context).size.width > 900
                      ? 9 / 8
                      : MediaQuery.of(context).size.width > 600
                          ? 9 / 12
                          : 9 / 16,
                  mainAxisExtent: 300,
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
                            builder: (BuildContext context) => MultiBlocProvider(
                            providers: <SingleChildWidget>[
                              BlocProvider<UpdateUserBloc>(
                                create: (BuildContext context) =>
                                  UpdateUserBloc(
                                    context.read<AuthenticationBloc>().userRepository,
                                ),
                              ),
                              BlocProvider<GetUserBloc>(
                                create: (BuildContext context) =>
                                  GetUserBloc(
                                    FirebaseUserRepo()
                                )..add(GetUser()),
                              ),
                            ],
                            child: DetailsScreen(
                                state.shoes[i],
                                key: UniqueKey(),
                              ),
                            ),
                          ),
                        );
                      },
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Image.network(
                                state.shoes[i].picture,
                                scale: 6,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  state.shoes[i].name,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  state.shoes[i].description,
                                  style: TextStyle(
                                    fontSize: 10,
                                    color: Colors.grey.shade500,
                                  ),
                                ),
                              ),
                            ),
                            Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.center,
                                  children: <Widget>[
                                    Row(
                                      children: <Widget>[
                                        Text(
                                          '${state.shoes[i].price}€',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Theme.of(context)
                                                .colorScheme
                                                .shadow,
                                            fontWeight: FontWeight.w900,
                                          ),
                                        ),
                                      ],
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
