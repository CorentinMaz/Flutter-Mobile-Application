import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'get_user_event.dart';
part 'get_user_state.dart';

class GetUserBloc extends Bloc<GetUserEvent, GetUserState> {
  final UserRepository _userRepository;

   GetUserBloc(this._userRepository) : super(GetUserInitial()) {
    on<GetUserEvent>((event, emit) async {
      emit(GetUserLoading());
      try {
        final user = await _userRepository.user.first;
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
}
