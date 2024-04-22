import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:user_repository/user_repository.dart';

part 'update_user_event.dart';
part 'update_user_state.dart';

class UpdateUserBloc extends Bloc<UpdateUserEvent, UpdateUserState> {

  UpdateUserBloc(this.userRepository) : super(UpdateUserInitial()) {
    on<UpdateUser>((UpdateUser event, Emitter<UpdateUserState> emit) async {
      emit(UpdateUserLoading());
      try {
        await userRepository.updateUserInfo(event.updateUser);
        emit(UpdateUserSuccess());
      } catch (e) {
        emit(UpdateUserFailure());
      }
    });
  }
  final UserRepository userRepository;
  
}
