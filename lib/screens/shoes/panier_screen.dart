import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoes_repository/shoes_repository.dart';
import 'package:sneakboutique/blocs/get_shoes_by_id_bloc/get_shoes_by_id_bloc.dart';
import 'package:user_repository/user_repository.dart';

class PanierScreen extends StatefulWidget {
  const PanierScreen({required this.user, super.key});

  /// The user data to be displayed.
  final MyUser user;

  @override
  _PanierScreenState createState() => _PanierScreenState();
}

class _PanierScreenState extends State<PanierScreen> {
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
        title: const Text('Cart'),
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
              return _buildShoesList();
            } else {
              return _buildShoesList();
            }
          },
        ),
      ),
    );
  }

  Widget _buildShoesList() {
    if (_loadedShoes.isEmpty) {
      return const Center(
        child: Text(
          'The cart is empty',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
    }

    return SingleChildScrollView(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              for (final Shoes shoes in _loadedShoes)
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: _buildShoesItem(shoes),
                ),
              _buildTotalAmount(),
              _buildPayButton(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildShoesItem(Shoes shoes) {
    final double cardWidth = MediaQuery.of(context).size.width > 900
        ? MediaQuery.of(context).size.width / 2
        : MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.all(10),
      width: cardWidth,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              SizedBox(
                height: 120,
                width: 120,
                child: Image.network(
                  shoes.picture,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    shoes.name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    shoes.description,
                    style: const TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            ],
          ),
          Text(
            '${shoes.price}€',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTotalAmount() {
    double totalAmount = 0;
    for (final Shoes shoes in _loadedShoes) {
      totalAmount += shoes.price;
    }
    final double totalWidth = MediaQuery.of(context).size.width > 900
        ? MediaQuery.of(context).size.width / 2
        : MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: SizedBox(
        width: totalWidth,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            const Text(
              'Total:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            Text(
              '${totalAmount.toStringAsFixed(2)}€',
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPayButton() {
    return ElevatedButton(
      onPressed: () {
        // Add payment logic here
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        'Payer',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
    );
  }
}
