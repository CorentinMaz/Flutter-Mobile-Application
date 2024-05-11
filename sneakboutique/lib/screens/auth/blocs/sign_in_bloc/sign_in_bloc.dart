import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

/// A BLoC responsible for managing sign-in processes.
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  /// Constructs a [SignInBloc] with the provided [UserRepository].
  SignInBloc(this._userRepository) : super(SignInInitial()) {
    on<SignInRequired>((SignInRequired event, Emitter<SignInState> emit) async {
      emit(SignInProcess());
      try {
        await _userRepository.signIn(event.email, event.password);
        emit(SignInSuccess());
      } catch (e) {
        emit(SignInFailure());
      }
    });

    on<SignOutRequired>((SignOutRequired event, Emitter<SignInState> emit) async => _userRepository.logOut());
  }
  final UserRepository _userRepository;
}
