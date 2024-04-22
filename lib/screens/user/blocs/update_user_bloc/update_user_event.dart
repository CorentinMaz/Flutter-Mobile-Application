part of 'update_user_bloc.dart';

sealed class UpdateUserEvent extends Equatable {
  const UpdateUserEvent();

  @override
  List<Object> get props => <Object>[];
}

class UpdateUser extends UpdateUserEvent{
  const UpdateUser(this.updateUser);
  /// The user data for sign-up.
  final MyUser updateUser;

  @override
  List<Object> get props => <Object>[updateUser];
}
