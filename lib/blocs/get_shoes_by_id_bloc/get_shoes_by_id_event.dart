part of 'get_shoes_by_id_bloc.dart';

/// Événement abstrait pour obtenir des chaussures par leur identifiant.
///
/// Les sous-classes de cet événement doivent implémenter la méthode [props]
/// pour permettre la comparaison d'égalité entre les événements.
abstract class GetShoesByIdEvent extends Equatable {
  const GetShoesByIdEvent();

  @override
  List<Object?> get props => <Object?>[];
}

/// Événement pour obtenir des chaussures spécifiques par leur identifiant.
///
/// [id] : L'identifiant unique des chaussures à récupérer.
class GetShoesById extends GetShoesByIdEvent {

  const GetShoesById(this.id);
  final String id;

  @override
  List<Object?> get props => <Object?>[id];
}
