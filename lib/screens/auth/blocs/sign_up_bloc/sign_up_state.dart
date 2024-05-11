part of 'sign_up_bloc.dart';

/// Base class for sign-up states.
///
/// All sign-up states should extend this class.
sealed class SignUpState extends Equatable {
  const SignUpState();

  @override
  List<Object> get props => <Object>[];
}

/// Initial state indicating that sign-up process has not started yet.
final class SignUpInitial extends SignUpState {}

/// State indicating that sign-up process has failed.
final class SignUpFailure extends SignUpState {}

/// State indicating that sign-up process is in progress.
final class SignUpProcess extends SignUpState {}

/// State indicating that sign-up process has succeeded.
final class SignUpSuccess extends SignUpState {}
