part of 'authentication_bloc.dart';

/// Base class for authentication events.
///
/// All authentication events should extend this class.
sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => <Object>[];
}

/// An event indicating that the user's authentication status has changed.
class AuthenticationUserChanged extends AuthenticationEvent {
  /// Constructs an [AuthenticationUserChanged] event with the given [user].
  const AuthenticationUserChanged(this.user);

  /// The user whose authentication status has changed.
  final MyUser? user;
}
