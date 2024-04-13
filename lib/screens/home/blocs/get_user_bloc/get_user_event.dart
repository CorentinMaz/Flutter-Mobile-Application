part of 'get_user_bloc.dart';

/// Base class for user data retrieval events.
sealed class GetUserEvent extends Equatable {
  const GetUserEvent();

  @override
  List<Object> get props => <Object>[];
}

/// Event triggered to fetch user data.
class GetUser extends GetUserEvent{}
