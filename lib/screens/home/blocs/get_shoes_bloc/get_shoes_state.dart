part of 'get_shoes_bloc.dart';

/// A sealed class representing the state of fetching shoes.
sealed class GetShoesState extends Equatable {
  const GetShoesState();

  @override
  List<Object> get props => <Object>[];
}

/// Represents the initial state when fetching shoes.
final class GetShoesInitial extends GetShoesState {}

/// Represents the state when fetching shoes has failed.
final class GetShoesFailure extends GetShoesState {}

/// Represents the state when shoes are being loaded.
final class GetShoesLoading extends GetShoesState {}

/// Represents the state when fetching shoes is successful.
final class GetShoesSuccess extends GetShoesState {
  /// Constructs a [GetShoesSuccess] with the provided list of [shoes].
  const GetShoesSuccess(this.shoes);

  /// The list of shoes fetched successfully.
  final List<Shoes> shoes;

  @override
  List<Object> get props => <Object>[shoes];
}
