part of 'get_shoes_bloc.dart';

sealed class GetShoesEvent extends Equatable {
  const GetShoesEvent();

  @override
  List<Object> get props => [];
}

class GetShoes extends GetShoesEvent{}