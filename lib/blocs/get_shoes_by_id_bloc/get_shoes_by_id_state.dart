part of 'get_shoes_by_id_bloc.dart';

/// Représente l'état de récupération des chaussures par leur identifiant.
///
/// Cette classe est scellée, ce qui signifie qu'elle ne peut pas être étendue en dehors de ce fichier.
/// Les sous-classes doivent être déclarées dans ce fichier uniquement.
sealed class GetShoesByIdState extends Equatable {
  const GetShoesByIdState();

  @override
  List<Object> get props => <Object>[];
}

/// Represents the state when fetching shoes has Initial.
final class GetShoesByIdInitial extends GetShoesByIdState {}

/// Represents the state when fetching shoes has failed.
final class GetShoesByIdFailure extends GetShoesByIdState {}

/// Represents the state when shoes are being loaded.
final class GetShoesByLoading extends GetShoesByIdState {}

/// Represents the state when fetching shoes is successful.
final class GetShoesBySuccess extends GetShoesByIdState {
  /// Constructs a [GetShoesBySuccess] with the provided list of [shoes].
  const GetShoesBySuccess(this.shoes);

  /// Représente une paire de chaussures.
  final Shoes shoes;

  @override
  List<Object> get props => <Object>[shoes];
}
