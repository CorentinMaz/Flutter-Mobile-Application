part of 'update_user_bloc.dart';

/// Represents the state of updating user information.
sealed class UpdateUserState extends Equatable {
  const UpdateUserState();

  @override
  List<Object> get props => <Object>[];
}

/// Represents the initial state of updating user information.
final class UpdateUserInitial extends UpdateUserState {}

/// Represents the loading state while updating user information.
final class UpdateUserLoading extends UpdateUserState {}

/// Represents the success state after updating user information.
final class UpdateUserSuccess extends UpdateUserState {}

/// Represents the failure state after updating user information.
final class UpdateUserFailure extends UpdateUserState {}
