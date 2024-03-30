import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoes_repository/shoes_repository.dart';

part 'get_shoes_event.dart';
part 'get_shoes_state.dart';

class GetShoesBloc extends Bloc<GetShoesEvent, GetShoesState> {
  final ShoesRepo _shoesRepo;

  GetShoesBloc(this._shoesRepo) : super(GetShoesInitial()) {
    on<GetShoes>((event, emit) async {
      emit(GetShoesLoading());
      try {
        List<Shoes> shoes = await _shoesRepo.getShoes();
        emit(GetShoesSuccess(shoes));
      } catch (e) {
        emit(GetShoesFailure());
      }
    });
  }
}
