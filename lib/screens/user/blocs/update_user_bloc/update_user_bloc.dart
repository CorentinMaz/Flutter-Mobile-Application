import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'update_user_event.dart';
part 'update_user_state.dart';

/// A BLoC responsible for updating user information.
class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {

  /// Constructs an [UpdateUserBloc] with the provided [UserRepository].
  UpdateUserBloc(this.userRepository) : super(UpdateUserInitial()) {
    on<UpdateUser>((UpdateUser event, Emitter<UpdateUserState> emit) async {
      emit(UpdateUserLoading());
      try {
        await userRepository.setUserData(event.updateUser);
        emit(UpdateUserSuccess());
      } catch (e) {
        emit(UpdateUserFailure());
      }
    });
  }

  /// The repository for user data.
  final UserRepository userRepository;
}
