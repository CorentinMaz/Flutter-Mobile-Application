part of 'create_shoes_bloc.dart';

sealed class CreateShoesEvent extends Equatable {
  const CreateShoesEvent();

  @override
  List<Object> get props => <Object>[];
}

class CreateShoes extends CreateShoesEvent {
  final Shoes shoes;

  const CreateShoes(this.shoes);

  @override
  List<Object> get props => <Object>[shoes];
}
