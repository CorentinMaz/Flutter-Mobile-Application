class MyUserEntity {

  MyUserEntity({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasActiveCart,
    required this.role,
  });

  MyUserEntity.fromDocument(Map<String, dynamic> doc)
    : userId = doc['userId'],
    email = doc['email'],
    name = doc['name'],
    hasActiveCart = doc['hasActiveCart'],
    role = doc['role'];
  String userId;
  String email;
  String name;
  bool hasActiveCart;
  String role;

  Map<String, Object?> toDocument() {
    return <String, Object?>{
      'userId': userId,
      'email': email,
      'name': name,
      'hasActiveCart': hasActiveCart,
      'role': role,
    };
  }
}
