import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:shoes_repository/shoes_repository.dart';

part 'get_shoes_by_id_event.dart';
part 'get_shoes_by_id_state.dart';

/// Un bloc pour obtenir des chaussures par leur identifiant.
///
/// Ce bloc gère l'état de la récupération des chaussures en fonction de leur identifiant.
/// Il prend en charge les événements pour récupérer les chaussures et met à jour l'état en conséquence.
class GetShoesByIdBloc extends Bloc<GetShoesByIdEvent, GetShoesByIdState> {
  /// Le constructeur pour initialiser le bloc avec le dépôt de chaussures spécifié.
  ///
  /// [shoesRepo] : Le dépôt de chaussures utilisé pour récupérer les données des chaussures.
  GetShoesByIdBloc(this.shoesRepo) : super(GetShoesByLoading()) {
    on<GetShoesById>((GetShoesById event, Emitter<GetShoesByIdState> emit) async {
      try {
        // Tente de récupérer les chaussures en fonction de l'identifiant fourni dans l'événement.
        final Shoes shoes = await shoesRepo.getShoesById(event.id);
        // Émet un nouvel état indiquant le succès de la récupération des chaussures.
        emit(GetShoesBySuccess(shoes));
      } catch (e) {
        // En cas d'erreur lors de la récupération des chaussures, émet un état d'échec.
        emit(GetShoesByIdFailure());
      }
    });
  }

  /// Le dépôt pour gérer les données liées aux chaussures.
  ShoesRepo shoesRepo;
}
