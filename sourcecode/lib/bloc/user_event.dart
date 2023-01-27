part of 'user_bloc.dart';

abstract class UserEvent extends Equatable{
  @override
  List<Object> get props => [];
}

class UserReset extends UserEvent{}

class UserFetched extends UserEvent{
  final int page;

  UserFetched(this.page);
}

class UserRefresh extends UserEvent{}

class UserSelected extends UserEvent{
  final UserModel user;

  UserSelected(this.user);
}