import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shoes_repository/shoes_repository.dart';

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

  @override
  Widget build(BuildContext context) {
    final isWeb = kIsWeb;
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.background,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly, // Ajout d'un espacement égal entre les éléments
            children: <Widget>[
              Container(
                width: screenWidth,
                height: isWeb ? screenHeight * 0.5 : screenWidth - 40,
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
              DecoratedBox(
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
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Theme.of(context).colorScheme.primary,
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
                        children: widget.shoes.sizeShoes.map((int size) {
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedSize = size.toString();
                              });
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                width: 40, // Largeur du carré
                                height: 40, // Hauteur du carré
                                decoration: BoxDecoration(
                                  color: selectedSize == size.toString()
                                      ? Colors.blue
                                      : Colors.grey[200],
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                  child: Text(
                                    size.toString(),
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
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
                      SizedBox(
                        width: screenWidth,
                        height: 50,
                        child: TextButton(
                          onPressed: () {
                            if (kDebugMode) {
                              print('Selected Size: $selectedSize');
                            }
                          },
                          style: TextButton.styleFrom(
                            elevation: 3,
                            backgroundColor: Colors.black,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Buy Now',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
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
