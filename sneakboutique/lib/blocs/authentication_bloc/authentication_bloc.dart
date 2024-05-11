import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

/// A BLoC responsible for managing user authentication state.
class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  /// Creates an [AuthenticationBloc] with the provided [UserRepository].
  ///
  /// The [userRepository] must not be null.
  AuthenticationBloc({
    required this.userRepository,
    }) : super(const AuthenticationState.unknown()) {
    _userSubscription = userRepository.user.listen((MyUser? user) {
      add(AuthenticationUserChanged(user));
    });

    on<AuthenticationUserChanged>(
        (AuthenticationUserChanged event, Emitter<AuthenticationState> emit) {
      if (event.user != MyUser.empty) {
        emit(AuthenticationState.authenticated(event.user!));
      } else {
        emit(const AuthenticationState.unauthenticated());
      }
    });
  }

  /// The repository for managing user data.
  final UserRepository userRepository;
  late final StreamSubscription<MyUser?> _userSubscription;

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
