import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoes_repository/shoes_repository.dart';

part 'get_shoes_by_id_event.dart';
part 'get_shoes_by_id_state.dart';

class GetShoesByIdBloc extends Bloc<GetShoesByIdEvent, GetShoesByIdState> {
  GetShoesByIdBloc(this.shoesRepo) : super(GetShoesByLoading()) {
    on<GetShoesById>((GetShoesById event, Emitter<GetShoesByIdState> emit) async {
      try {
        final Shoes shoes = await shoesRepo.getShoesById(event.id);
        emit(GetShoesBySuccess(shoes));
      } catch (e) {
        emit(GetShoesByIdFailure());
      }
    });
  }

  /// The repository for handling shoe-related data.
  ShoesRepo shoesRepo;
}
