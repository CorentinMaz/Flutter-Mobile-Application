import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoes_repository/shoes_repository.dart';

part 'create_shoes_event.dart';
part 'create_shoes_state.dart';

class CreateShoesBloc extends Bloc<CreateShoesEvent, CreateShoesState> {
  ShoesRepo shoesRepo;

  CreateShoesBloc(this.shoesRepo) : super(CreateShoesInitial()) {
    on<CreateShoes>((CreateShoes event, Emitter<CreateShoesState> emit) async {
      emit(CreateShoesLoading());
      try {
        await shoesRepo.createShoes(event.shoes);
        emit(CreateShoesSuccess());
      } catch (e) {
        emit(CreateShoesFailure());
      }
    });
  }
}
