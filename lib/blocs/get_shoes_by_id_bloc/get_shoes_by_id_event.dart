part of 'get_shoes_by_id_bloc.dart';

abstract class GetShoesByIdEvent extends Equatable {
  const GetShoesByIdEvent();

  @override
  List<Object?> get props => [];
}

class GetShoesById extends GetShoesByIdEvent {
  final String id;

  const GetShoesById(this.id);

  @override
  List<Object?> get props => [id];
}
