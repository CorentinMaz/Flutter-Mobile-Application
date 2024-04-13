part of 'get_user_bloc.dart';

/// Sealed class representing events for fetching user information.
///
/// Extends [Equatable] for equality comparison.
///
/// Each event class should be a subclass of [GetUserEvent].
sealed class GetUserEvent extends Equatable {
  const GetUserEvent();

  @override
  List<Object> get props => <Object>[];
}

/// Event indicating a request to fetch user information.
class GetUser extends GetUserEvent{}
