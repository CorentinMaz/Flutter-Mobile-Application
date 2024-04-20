part of 'create_shoes_bloc.dart';

sealed class CreateShoesState extends Equatable {
  const CreateShoesState();

  @override
  List<Object> get props => <Object>[];
}

final class CreateShoesInitial extends CreateShoesState {}
final class CreateShoesFailure extends CreateShoesState {}
final class CreateShoesLoading extends CreateShoesState {}
final class CreateShoesSuccess extends CreateShoesState {}
