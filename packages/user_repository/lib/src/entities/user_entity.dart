/// Entity class representing a user.
class MyUserEntity {

  /// Constructs a [MyUserEntity] instance with the provided user data.
  MyUserEntity({
    required this.userId,
    required this.email,
    required this.name,
    required this.role,
    required this.picture,
    required this.panier,
  });

  /// Constructs a [MyUserEntity] instance from a document.
  MyUserEntity.fromDocument(Map<String, dynamic> doc)
    : userId = doc['userId'],
      email = doc['email'],
      name = doc['name'],
      role = doc['role'],
      picture = doc['picture'],
      panier = doc['panier'];

  /// The unique identifier of the user.
  String userId;

  /// The email address of the user.
  String email;

  /// The name of the user.
  String name;

  /// The role of the user.
  String role;

  /// The picture URL of the user.
  String picture;

  /// The shopping cart of the user.
  List<dynamic> panier;


  /// Converts the [MyUserEntity] instance to a document.
  Map<String, Object?> toDocument() {
    return <String, Object?>{
      'userId': userId,
      'email': email,
      'name': name,
      'role': role,
      'picture': picture,
      'panier': panier,
    };
  }
}
