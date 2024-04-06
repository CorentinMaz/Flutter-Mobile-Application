import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';

/// A BLoC responsible for managing sign-up processes.
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  /// Constructs a [SignUpBloc] with the provided [UserRepository].
  SignUpBloc(this._userRepository) : super(SignUpInitial()) {
    on<SignUpRequired>((SignUpRequired event, Emitter<SignUpState> emit) async {
      emit(SignUpProcess());
      try {
        final MyUser myUser =
            await _userRepository.signUp(event.user, event.password);
        await _userRepository.setUserData(myUser);
        emit(SignUpSuccess());
      } catch (e) {
        emit(SignUpFailure());
      }
    });
  }
  final UserRepository _userRepository;
}
