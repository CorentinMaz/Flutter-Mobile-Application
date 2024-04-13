part of 'get_user_bloc.dart';

/// Base class for user data retrieval states.
sealed class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object> get props => <Object>[];
}

/// Initial state when user data retrieval is initialized.
final class GetUserInitial extends GetUserState {}

/// State indicating failure in user data retrieval.
final class GetUserFailure extends GetUserState {}

/// State indicating ongoing user data retrieval.
final class GetUserLoading extends GetUserState {}

/// State indicating successful user data retrieval.
final class GetUserSuccess extends GetUserState {
  /// Constructs a [GetUserSuccess] with the provided user data.
  const GetUserSuccess(this.user);

  /// The retrieved user data.
  final MyUser user;

  @override
  List<Object> get props => <Object>[user];
}
