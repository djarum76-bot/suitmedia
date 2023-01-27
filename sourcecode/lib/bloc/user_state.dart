part of 'user_bloc.dart';

enum UserStatus { initial, reset, loading, error, fetched, selected }

class UserState extends Equatable{
  const UserState({
    this.status = UserStatus.initial,
    this.users = const <UserModel>[],
    this.user,
    this.page = 1,
    this.message
  });

  final UserStatus status;
  final List<UserModel> users;
  final UserModel? user;
  final int page;
  final String? message;

  @override
  List<Object?> get props => [status, users, user, page, message];

  UserState copyWith({
    UserStatus? status,
    List<UserModel>? users,
    ValueGetter<UserModel?>? user,
    int? page,
    String? message
  }) {
    return UserState(
      status: status ?? this.status,
      users: users ?? this.users,
      user: user != null ? user() : this.user,
      page: page ?? this.page,
      message: message ?? this.message,
    );
  }
}