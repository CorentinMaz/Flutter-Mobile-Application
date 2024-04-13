import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'get_user_event.dart';
part 'get_user_state.dart';

/// A BLoC responsible for managing user data retrieval and state.
///
/// This BLoC listens for [GetUserEvent]s and updates its state accordingly.
class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {

  /// Constructs a [GetUserBloc] with the provided [UserRepository].
  ///
  /// The initial state of the bloc is set to [GetUserInitial].
  GetUserBloc(this._userRepository) : super(GetUserInitial()) {
    on<GetUserEvent>((GetUserEvent event, Emitter<GetUserState> emit) async {
      emit(GetUserLoading());
      try {
        final MyUser? user = await _userRepository.user.first;
        if (user != null) {
          emit(GetUserSuccess(user));
        } else {
          emit(GetUserInitial());
        }
      } catch (e) {
        emit(GetUserFailure());
      }
    });
  }
  final UserRepository _userRepository;
}
