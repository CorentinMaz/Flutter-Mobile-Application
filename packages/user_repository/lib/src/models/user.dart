import '../entities/entities.dart';

class MyUser {
  MyUser({
    required this.userId,
    required this.email,
    required this.name,
    required this.hasActiveCart,
  });

  MyUser.fromEntity(MyUserEntity entity)
      : userId = entity.userId,
        email = entity.email,
        name = entity.name,
        hasActiveCart = entity.hasActiveCart;
  String userId;
  String email;
  String name;
  bool hasActiveCart;

  static final MyUser empty = MyUser(
    userId: '',
    email: '',
    name: '',
    hasActiveCart: false,
  );

  MyUserEntity toEntity() {
    return MyUserEntity(
      userId: userId,
      email: email,
      name: name,
      hasActiveCart: hasActiveCart,
    );
  }

  @override
  String toString() {
    return 'MyUser: $userId, $email, $name, $hasActiveCart';
  }
}
