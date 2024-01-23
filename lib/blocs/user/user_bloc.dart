import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'package:class_objects_example_app/models/models.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends HydratedBloc<UserEvent, UserState> {
  UserBloc() : super(const UserState()) {
    on<ClearUser>(_onClearUser);
    on<LoadUser>(_onLoadUser);
    on<UpdateUser>(_onUpdateUser);
  }

  void _onClearUser(
    ClearUser event,
    Emitter<UserState> emit,
  ) {
    emit(
      state.copyWith(
        isCool: false,
        user: User.emptyUser,
        userStatus: UserStatus.initial,
      ),
    );
  }

  void _onLoadUser(
    LoadUser event,
    Emitter<UserState> emit,
  ) async {
    emit(
      state.copyWith(
        userStatus: UserStatus.loading,
      ),
    );

    try {
      // go to repository like Firebase
      // var user = await Firebase.getUser();
      await Future.delayed(
        const Duration(seconds: 3),
        () {
          print('done waiting on future');
          print(User.oluUser);
        },
      );
      emit(
        state.copyWith(
          isCool: true,
          user: User.oluUser.copyWith(
            email: 'olu@portcall.com',
            interests: [
              'coding',
              'soccer',
            ],
            isDarkTheme: false,
            name: 'Olu Makinde',
            organization: 'Island Innovations',
            password: 'GoodPassword1',
          ),
          userStatus: UserStatus.loaded,
        ),
      );
    } catch (err) {
      print('err: $err');
      emit(
        state.copyWith(
          userStatus: UserStatus.error,
        ),
      );
    }
  }

  void _onUpdateUser(
    UpdateUser event,
    Emitter<UserState> emit,
  ) {
    emit(
      state.copyWith(
        userStatus: UserStatus.loading,
      ),
    );

    // await ... doing stuff

    emit(
      state.copyWith(
        isCool: event.isCool,
        user: event.user,
        userStatus: UserStatus.loaded,
      ),
    );
  }

  @override
  UserState? fromJson(Map<String, dynamic> json) {
    return UserState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(UserState state) {
    return state.toJson();
  }
}
