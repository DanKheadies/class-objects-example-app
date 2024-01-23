part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object?> get props => [];
}

class LoadUser extends UserEvent {}

class UpdateUser extends UserEvent {
  final bool? isCool;
  final User user;

  const UpdateUser({
    required this.user,
    this.isCool,
  });

  @override
  List<Object?> get props => [
        isCool,
        user,
      ];
}

class ClearUser extends UserEvent {}
