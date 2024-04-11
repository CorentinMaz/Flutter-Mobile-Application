class MyUserEntity {

  MyUserEntity({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasActiveCart,
  });

  MyUserEntity.fromDocument(Map<String, dynamic> doc)
    : userId = doc['userId'],
      email = doc['email'],
      name = doc['name'],
      hasActiveCart = doc['hasActiveCart'];
  String userId;
  String email;
  String name;
  bool hasActiveCart;

  Map<String, Object?> toDocument() {
    return <String, Object?>{
      'userId': userId,
      'email': email,
      'name': name,
      'hasActiveCart': hasActiveCart,
    };
  }
}
