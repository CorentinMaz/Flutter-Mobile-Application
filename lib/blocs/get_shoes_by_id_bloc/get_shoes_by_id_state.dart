part of 'get_shoes_by_id_bloc.dart';

sealed class GetShoesByIdState extends Equatable {
  const GetShoesByIdState();

  @override
  List<Object> get props => <Object>[];
}

final class GetShoesByIdInitial extends GetShoesByIdState {}

/// Represents the state when fetching shoes has failed.
final class GetShoesByIdFailure extends GetShoesByIdState {}

/// Represents the state when shoes are being loaded.
final class GetShoesByLoading extends GetShoesByIdState {}

/// Represents the state when fetching shoes is successful.
final class GetShoesBySuccess extends GetShoesByIdState {
  /// Constructs a [GetShoesBySuccess] with the provided list of [shoes].
  const GetShoesBySuccess(this.shoes);

  final Shoes shoes;

  @override
  List<Object> get props => <Object>[shoes];
}
