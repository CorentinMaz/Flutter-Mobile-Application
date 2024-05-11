import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoes_repository/shoes_repository.dart';

part 'get_shoes_event.dart';
part 'get_shoes_state.dart';

/// A BLoC responsible for managing the state of fetching shoes.
class GetShoesBloc extends Bloc<GetShoesEvent, GetShoesState> {
  /// Constructs a [GetShoesBloc] with the provided [ShoesRepo].
  GetShoesBloc(this._shoesRepo) : super(GetShoesInitial()) {
    on<GetShoes>((GetShoes event, Emitter<GetShoesState> emit) async {
      emit(GetShoesLoading());
      try {
        final List<Shoes> shoes = await _shoesRepo.getShoes();
        emit(GetShoesSuccess(shoes));
      } catch (e) {
        emit(GetShoesFailure());
      }
    });
  }
  final ShoesRepo _shoesRepo;
}
