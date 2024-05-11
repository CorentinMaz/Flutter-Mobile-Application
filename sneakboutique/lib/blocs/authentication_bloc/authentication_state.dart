part of 'authentication_bloc.dart';

/// Enum representing the authentication status.
enum AuthenticationStatus {
  /// The user is authenticated.
  authenticated,

  /// The user is unauthenticated.
  unauthenticated,

  /// The authentication status is unknown.
  unknown
}

/// Represents the state of authentication.
class AuthenticationState extends Equatable {
  /// Constructs an unknown authentication state.
  const AuthenticationState.unknown() : this._();

  /// Constructs an authenticated authentication state with the given [myUser].
  const AuthenticationState.authenticated(MyUser myUser) :
    this._(status: AuthenticationStatus.authenticated, user: myUser);

  /// Constructs an unauthenticated authentication state.
  const AuthenticationState.unauthenticated() :
    this._(status: AuthenticationStatus.unauthenticated);

  const AuthenticationState._({
    this.status = AuthenticationStatus.unknown,
    this.user,
  });

  /// The authentication status.
  final AuthenticationStatus status;

  /// The user associated with the authentication state.
  final MyUser? user;

  @override
  List<Object?> get props => <Object?>[status, user];
}
