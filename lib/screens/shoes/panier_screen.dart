import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_repository/shoes_repository.dart';
import 'package:sneakboutique/blocs/get_shoes_by_id_bloc/get_shoes_by_id_bloc.dart';
import 'package:sneakboutique/screens/home/blocs/get_shoes_bloc/get_shoes_bloc.dart';
import 'package:user_repository/user_repository.dart';

class PanierScreen extends StatefulWidget {
  const PanierScreen({required this.user, Key? key}) : super(key: key);

  /// The user data to be displayed.
  final MyUser user;

  @override
  _PanierScreenState createState() => _PanierScreenState();
}

class _PanierScreenState extends State<PanierScreen> {
  List<Shoes> _loadedShoes = <Shoes>[];

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

class ShoesItem extends StatelessWidget {
  const ShoesItem({
    required this.shoes,
    Key? key,
  }) : super(key: key);

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
