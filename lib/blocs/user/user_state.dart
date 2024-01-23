part of 'user_bloc.dart';

enum UserStatus {
  error,
  initial,
  loaded,
  loading,
}

class UserState extends Equatable {
  final bool? isCool;
  final User user;
  final UserStatus userStatus;

  const UserState({
    this.user = User.emptyUser,
    this.userStatus = UserStatus.initial,
    this.isCool,
  });

  @override
  List<Object?> get props => [
        isCool,
        user,
        userStatus,
      ];

  UserState copyWith({
    bool? isCool,
    User? user,
    UserStatus? userStatus,
  }) {
    return UserState(
      isCool: isCool ?? this.isCool,
      user: user ?? this.user,
      userStatus: userStatus ?? this.userStatus,
    );
  }

  factory UserState.fromJson(Map<String, dynamic> json) {
    return UserState(
      isCool: json['isCool'] ?? '',
      user: User.fromJson(json['user']),
      userStatus: UserStatus.values.firstWhere(
        (status) => status.name.toString() == json['userStatus'],
      ),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'isCool': isCool,
      'user': user.toJson(),
      'userStatus': userStatus.name,
    };
  }
}
