part of 'create_shoes_bloc.dart';

/// This class serves as the base class for all create shoes states.
sealed class CreateShoesState extends Equatable {
  const CreateShoesState();

  @override
  List<Object> get props => <Object>[];
}

/// Represents the initial state when creating shoes.
class CreateShoesInitial extends CreateShoesState {}

/// Represents the state when an error occurs during shoe creation.
class CreateShoesFailure extends CreateShoesState {}

/// Represents the state when shoes are being created.
class CreateShoesLoading extends CreateShoesState {}

/// Represents the state when shoes are successfully created.
class CreateShoesSuccess extends CreateShoesState {}
