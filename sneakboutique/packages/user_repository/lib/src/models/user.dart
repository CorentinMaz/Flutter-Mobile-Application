import 'package:user_repository/src/entities/entities.dart';

class MyUser {

  MyUser({
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

  static final MyUser empty = MyUser(
    userId: '',
    email: '',
    name: '',
    role: 'user',
    picture: '',
    panier: <dynamic>[],
  );

  MyUserEntity toEntity() {
    return MyUserEntity(
      userId: userId,
      email: email,
      name: name,
      role: role,
      picture: picture,
      panier: panier,
    );
  }

  static MyUser fromEntity(MyUserEntity entity) {
    return MyUser(
      userId: entity.userId,
      email: entity.email,
      name: entity.name,
      role: entity.role,
      picture: entity.picture,
      panier: entity.panier,
    );
  }

  @override
  String toString() {
    return 'MyUser: $userId, $email, $name, $role, $picture';
  }
}
