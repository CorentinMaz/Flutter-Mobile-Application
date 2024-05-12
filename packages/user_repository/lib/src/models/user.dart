import 'package:user_repository/src/entities/entities.dart';

/// Model class representing a user.
class MyUser {

  /// Constructs a [MyUser] instance with the provided user data.
  MyUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.role,
    required this.picture,
    required this.panier,
  });

  /// Creates a [MyUser] instance from a [MyUserEntity].
  MyUser.fromEntity(MyUserEntity entity)
   :  userId = entity.userId,
      email = entity.email,
      name = entity.name,
      role = entity.role,
      picture = entity.picture,
      panier = entity.panier;

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
  List<String> panier;

  /// An empty [MyUser] instance.
  static final MyUser empty = MyUser(
    userId: '',
    email: '',
    name: '',
    role: 'user',
    picture: '',
    panier: <String>[],
  );

  /// Converts the [MyUser] instance to a [MyUserEntity].
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

  @override
  String toString() {
    return 'MyUser: $userId, $email, $name, $role, $picture';
  }
}
