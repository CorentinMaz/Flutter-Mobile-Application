part of 'get_shoes_bloc.dart';

sealed class GetShoesState extends Equatable {
  const GetShoesState();

  @override
  List<Object> get props => [];
}

final class GetShoesInitial extends GetShoesState {}

final class GetShoesFailure extends GetShoesState {}
final class GetShoesLoading extends GetShoesState {}
final class GetShoesSuccess extends GetShoesState {
  final List<Shoes> shoes;

  const GetShoesSuccess(this.shoes);

  @override
  List<Object> get props => [shoes];
}
