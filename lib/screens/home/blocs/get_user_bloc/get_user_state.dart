part of 'get_user_bloc.dart';

/// Sealed class representing states for user information retrieval.
///
/// Extends [Equatable] for equality comparison.
///
/// Each state class should be a subclass of [GetUserState].
sealed class GetUserState extends Equatable {
  const GetUserState();

  @override
  List<Object> get props => <Object>[];
}

/// Initial state indicating that user information retrieval has not yet started.
final class GetUserInitial extends GetUserState {}

/// State indicating a failure occurred during user information retrieval.
final class GetUserFailure extends GetUserState {}

/// State indicating that user information retrieval is in progress.
final class GetUserLoading extends GetUserState {}

/// State indicating successful retrieval of user information.
///
/// Contains [user] representing the retrieved user.
final class GetUserSuccess extends GetUserState {
  /// Constructs a [GetUserSuccess] state with the provided [user].
  const GetUserSuccess(this.user);

  /// The retrieved user information.
  final MyUser user;

  @override
  List<Object> get props => <Object>[user];
}
