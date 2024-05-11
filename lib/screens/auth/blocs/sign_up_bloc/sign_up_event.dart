part of 'sign_up_bloc.dart';

/// Base class for sign-up events.
///
/// All sign-up events should extend this class.
sealed class SignUpEvent extends Equatable {
  const SignUpEvent();

  @override
  List<Object> get props => <Object>[];
}

/// An event indicating that sign-up is required with the given [user] and [password].
class SignUpRequired extends SignUpEvent {
  /// Constructs a [SignUpRequired] event with the provided [user] and [password].
  const SignUpRequired(this.user, this.password);

  /// The user data for sign-up.
  final MyUser user;

  /// The password for sign-up.
  final String password;

  @override
  List<Object> get props => <Object>[user, password];
}
