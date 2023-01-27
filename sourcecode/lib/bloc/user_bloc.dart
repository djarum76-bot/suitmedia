import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:suitmedia/model/user_model.dart';
import 'package:suitmedia/repository/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({required this.userRepository}) : super(const UserState()) {
    on<UserReset>(
      _onUserReset
    );
    on<UserFetched>(
      _onUserFetched
    );
    on<UserRefresh>(
      _onUserRefresh
    );
    on<UserSelected>(
      _onUserSelected
    );
  }

  void _onUserReset(UserReset event, Emitter<UserState> emit)async{
    emit(state.copyWith(
        status: UserStatus.reset,
        users: <UserModel>[],
        user: () => null,
        page: 1,
        message: null
    ));
  }

  Future<void> _onUserFetched(UserFetched event, Emitter<UserState> emit)async{
    emit(state.copyWith(status: UserStatus.loading));
    try{
      final users = await userRepository.getAllUser(event.page);

      emit(state.copyWith(
        status: UserStatus.fetched,
        users: users,
        page: event.page
      ));
    }catch(e){
      emit(state.copyWith(
        status: UserStatus.error,
        message: e.toString()
      ));
      throw Exception(e);
    }
  }

  Future<void> _onUserRefresh(UserRefresh event, Emitter<UserState> emit)async{
    emit(state.copyWith(status: UserStatus.loading));
    try{
      final users = await userRepository.getAllUser(state.page);

      emit(state.copyWith(
        status: UserStatus.fetched,
        users: users,
      ));
    }catch(e){
      emit(state.copyWith(
          status: UserStatus.error,
          message: e.toString()
      ));
      throw Exception(e);
    }
  }

  void _onUserSelected(UserSelected event, Emitter<UserState> emit)async{
    emit(state.copyWith(status: UserStatus.loading));
    try{
      emit(state.copyWith(
        status: UserStatus.selected,
        user: () => event.user,
      ));
    }catch(e){
      emit(state.copyWith(
          status: UserStatus.error,
          message: e.toString()
      ));
      throw Exception(e);
    }
  }
}
