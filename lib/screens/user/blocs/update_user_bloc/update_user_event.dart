part of 'update_user_bloc.dart';

/// A sealed class representing events related to updating user information.
sealed class UpdateUserEvent extends Equatable {
  const UpdateUserEvent();

  @override
  List<Object> get props => <Object>[];
}

/// An event indicating an update to user information.
class UpdateUser extends UpdateUserEvent{

  /// Constructs an [UpdateUser] event with the provided user data.
  const UpdateUser(this.updateUser);

  /// The user data for sign-up.
  final MyUser updateUser;

  @override
  List<Object> get props => <Object>[updateUser];
}
