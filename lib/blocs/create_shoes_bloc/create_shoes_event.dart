part of 'create_shoes_bloc.dart';

/// A sealed class representing the create shoes event.
sealed class CreateShoesEvent extends Equatable {
  const CreateShoesEvent();

  @override
  List<Object> get props => <Object>[];
}

/// This class is used to trigger the creation of shoes.
class CreateShoes extends CreateShoesEvent {

  /// Constructs a [CreateShoes] event with the provided [shoes].
  const CreateShoes(this.shoes);

  /// The shoes to be created.
  final Shoes shoes;

  @override
  List<Object> get props => <Object>[shoes];
}
