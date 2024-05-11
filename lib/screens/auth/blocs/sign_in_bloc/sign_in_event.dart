part of 'sign_in_bloc.dart';

/// Base class for sign-in events.
///
/// All sign-in events should extend this class.
sealed class SignInEvent extends Equatable {
  /// Constructs a [SignInEvent].
  const SignInEvent();

  @override
  List<Object> get props => <Object>[];
}

/// An event indicating that sign-in is required with the given [email] and [password].
class SignInRequired extends SignInEvent {
  /// Constructs a [SignInRequired] event with the provided [email] and [password].
  const SignInRequired(this.email, this.password);

  /// The email for sign-in.
  final String email;

  /// The password for sign-in.
  final String password;

  @override
  List<Object> get props => <Object>[email, password];
}

/// An event indicating that sign-out is required.
class SignOutRequired extends SignInEvent {}
