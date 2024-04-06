part of 'get_shoes_bloc.dart';

/// A sealed class representing events related to fetching shoes.
sealed class GetShoesEvent extends Equatable {
  const GetShoesEvent();

  @override
  List<Object> get props => <Object>[];
}

/// Represents an event to fetch shoes.
class GetShoes extends GetShoesEvent {}
