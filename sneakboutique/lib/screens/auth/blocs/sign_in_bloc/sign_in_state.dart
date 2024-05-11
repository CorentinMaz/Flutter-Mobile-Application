part of 'sign_in_bloc.dart';

/// Base class for sign-in states.
///
/// All sign-in states should extend this class.
sealed class SignInState extends Equatable {
  const SignInState();

  @override
  List<Object> get props => <Object>[];
}

/// Initial state indicating that sign-in process has not started yet.
final class SignInInitial extends SignInState {}

/// State indicating that sign-in process has failed.
final class SignInFailure extends SignInState {}

/// State indicating that sign-in process is in progress.
final class SignInProcess extends SignInState {}

/// State indicating that sign-in process has succeeded.
final class SignInSuccess extends SignInState {}
