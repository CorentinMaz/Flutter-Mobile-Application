class MyUserEntity {

  MyUserEntity.fromDocument(Map<String, dynamic> doc)
    : userId = doc['userId'],
      email = doc['email'],
      name = doc['name'],
      role = doc['role'],
      picture = doc['picture'],
      panier = doc['panier'];

  MyUserEntity({
    required this.userId,
    required this.email,
    required this.name,
    required this.role,
    required this.picture,
    required this.panier,
  });

  String userId;
  String email;
  String name;
  String role;
  String picture;
  List<dynamic> panier;

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
