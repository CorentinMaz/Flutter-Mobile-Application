import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_repository/shoes_repository.dart';
import 'package:sneakboutique/screens/home/blocs/get_user_bloc/get_user_bloc.dart';
import 'package:sneakboutique/screens/user/blocs/update_user_bloc/update_user_bloc.dart';
import 'package:user_repository/user_repository.dart';

/// A screen that displays the details of a pair of shoes.
class DetailsScreen extends StatefulWidget {
  /// Constructs a [DetailsScreen] with the given [shoes] and [key].
  const DetailsScreen(this.shoes, {required Key key}) : super(key: key);

  /// The pair of shoes to display details for.
  final Shoes shoes;

  @override
  DetailsScreenState createState() => DetailsScreenState();
}

/// The state class for the [DetailsScreen] widget.
class DetailsScreenState extends State<DetailsScreen> {
  /// The selected shoe size.
  String selectedSize = '';

  /// The shoes in cart.
  bool isInCartLocal = false;

  @override
  Widget build(BuildContext context) {
    return BlocListener<UpdateUserBloc, UpdateUserState>(
      listener: (BuildContext context, UpdateUserState state) {
        if (state is UpdateUserSuccess) {
          setState(() {
            isInCartLocal = true;
          });
        } else if (state is UpdateUserLoading) {
        } else if (state is UpdateUserFailure) {}
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.background,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width / 1.5,
                  height: MediaQuery.of(context).size.height / 2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: const <BoxShadow>[
                      BoxShadow(
                        color: Colors.grey,
                        offset: Offset(3, 3),
                        blurRadius: 5,
                      ),
                    ],
                    image: DecorationImage(
                      image: NetworkImage(
                        widget.shoes.picture,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: const <BoxShadow>[
                          BoxShadow(
                            color: Colors.grey,
                            offset: Offset(3, 3),
                            blurRadius: 5,
                          ),
                        ],
                      ),
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            children: <Widget>[
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      widget.shoes.name,
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.centerRight,
                                      child: Text(
                                        '${widget.shoes.price}€',
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 12,
                              ),
                              Wrap(
                                spacing: 10,
                                runSpacing: 10,
                                children:
                                    widget.shoes.sizeShoes.map((int size) {
                                  return GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedSize = size.toString();
                                      });
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.only(right: 10),
                                      child: AnimatedContainer(
                                        duration:
                                            const Duration(milliseconds: 300),
                                        width: 40, // Largeur du carré
                                        height: 40, // Hauteur du carré
                                        decoration: BoxDecoration(
                                          color: selectedSize == size.toString()
                                              ? Colors.black
                                              : Colors.grey[200],
                                          borderRadius:
                                              BorderRadius.circular(8),
                                        ),
                                        child: Center(
                                          child: Text(
                                            size.toString(),
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              color: selectedSize ==
                                                      size.toString()
                                                  ? Colors.white
                                                  : Colors.black,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              BlocBuilder<GetUserBloc, GetUserState>(
                                builder: (BuildContext context, GetUserState state) {
                                  if (state is GetUserSuccess) {
                                    final MyUser user = state.user;
                                    final bool isInCart = user.panier.contains(widget.shoes.shoesId);
                                    return SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      height: 50,
                                      child: TextButton(
                                        onPressed: isInCart ? null : () {
                                          user.panier
                                              .add(widget.shoes.shoesId);
                                          context
                                              .read<UpdateUserBloc>()
                                              .add(UpdateUser(user));
                                        },
                                        style: TextButton.styleFrom(
                                          elevation: 3,
                                          backgroundColor: isInCart ? Colors.grey : Colors.black,
                                          foregroundColor: Colors.white,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                        ),
                                        child: Text(
                                          isInCart ? 'Already in Cart' : 'Buy Now',
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return const SizedBox.shrink();
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
