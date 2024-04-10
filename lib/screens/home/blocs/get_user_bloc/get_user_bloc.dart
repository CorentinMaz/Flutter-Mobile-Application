import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'get_user_event.dart';
part 'get_user_state.dart';

/// A BLoC responsible for managing the state of fetching user information.
class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  /// Constructs a [GetUserBloc] with the provided [UserRepository].
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
