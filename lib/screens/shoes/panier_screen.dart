import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_repository/shoes_repository.dart';
import 'package:sneakboutique/blocs/get_shoes_by_id_bloc/get_shoes_by_id_bloc.dart';
import 'package:user_repository/user_repository.dart';

/// A screen widget to display the user's shopping cart.
class PanierScreen extends StatefulWidget {

  /// Constructs a `PanierScreen` with the provided user data.
  const PanierScreen({required this.user, super.key});

  /// The user data to be displayed.
  final MyUser user;

  /// Overrides the default method to create the state for the PanierScreen widget.
  ///
  /// This method returns an instance of [_PanierScreenState], which is responsible for managing
  /// the state of the PanierScreen widget.
  @override
  PanierScreenState createState() => PanierScreenState();
}

/// The state for the [PanierScreen] widget.
///
/// This class manages the state for the PanierScreen widget. It keeps track of the list of loaded shoes
/// and provides methods to fetch shoes data and update the UI accordingly.
class PanierScreenState extends State<PanierScreen> {
  /// List to store the loaded shoes.
  final List<Shoes> _loadedShoes = <Shoes>[];

  @override
  void initState() {
    super.initState();
    // Déclenchez la récupération des données de chaussure pour toutes les chaussures dans le panier de l'utilisateur
    _fetchAllShoes();
  }

  void _fetchAllShoes() {
    for (final String shoesId in widget.user.panier) {
      context.read<GetShoesByIdBloc>().add(GetShoesById(shoesId));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panier'),
      ),
      body: BlocListener<GetShoesByIdBloc, GetShoesByIdState>(
        listener: (BuildContext context, GetShoesByIdState state) {
          if (state is GetShoesBySuccess) {
            setState(() {
              _loadedShoes.add(state.shoes);
            });
          }
        },
        child: BlocBuilder<GetShoesByIdBloc, GetShoesByIdState>(
          builder: (BuildContext context, GetShoesByIdState state) {
            if (state is GetShoesByLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: _loadedShoes.length,
                itemBuilder: (BuildContext context, int index) {
                  final Shoes shoes = _loadedShoes[index];
                  return ShoesItem(shoes: shoes);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

/// Additional details about the shoes can be added as needed.
class ShoesItem extends StatelessWidget {

  /// Constructs a [ShoesItem] widget with the provided [shoes] object.
  ///
  /// The [shoes] parameter is required and represents the pair of shoes to be displayed.
  const ShoesItem({
    required this.shoes,
    super.key,
  });

  /// The pair of shoes to be displayed by this widget.
  final Shoes shoes;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(shoes.name),
      subtitle: Text('${shoes.price}€'),
      // Ajoutez d'autres détails de la chaussure ici selon vos besoins
    );
  }
}
