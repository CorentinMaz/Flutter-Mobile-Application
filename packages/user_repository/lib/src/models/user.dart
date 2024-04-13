import '../entities/entities.dart';

class MyUser {

  MyUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasActiveCart,
    required this.role,
  });

  MyUser.fromEntity(MyUserEntity entity)
    : userId = entity.userId,
    email = entity.email,
    name = entity.name,
    hasActiveCart = entity.hasActiveCart,
    role = entity.role;
  String userId;
  String email;
  String name;
  bool hasActiveCart;
  String role;

  static final MyUser empty = MyUser(
    userId: '',
    email: '',
    name: '',
    hasActiveCart: false,
    role: 'user',
  );

  MyUserEntity toEntity() {
    return MyUserEntity(
      userId: userId,
      email: email,
      name: name,
      hasActiveCart: hasActiveCart,
      role: role,
    );
  }

  @override
  String toString() {
    return 'MyUser: $userId, $email, $name, $hasActiveCart, $role';
  }
}
