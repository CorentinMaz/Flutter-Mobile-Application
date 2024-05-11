import 'package:user_repository/src/models/models.dart';

/// Abstract class for user repository.
abstract class UserRepository {
  /// Stream of user data.
  Stream<MyUser?> get user;

  /// Signs up a user with the provided [myUser] data and [password].
  Future<MyUser> signUp(MyUser myUser, String password);

  /// Sets user data with the provided [user].
  Future<void> setUserData(MyUser user);

  /// Signs in a user with the provided [email] and [password].
  Future<void> signIn(String email, String password);

  /// Logs out the current user.
  Future<void> logOut();
}
