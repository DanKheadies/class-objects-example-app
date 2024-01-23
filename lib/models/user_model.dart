import 'package:equatable/equatable.dart';

class User extends Equatable {
  final bool isDarkTheme;
  final List<String> interests;
  final String email;
  final String name;
  final String password;
  final String? organization;
  // final Organization org;

  const User({
    required this.email,
    required this.interests,
    required this.isDarkTheme,
    required this.name,
    required this.password,
    this.organization = '',
  });

  @override
  List<Object?> get props => [
        email,
        interests,
        isDarkTheme,
        name,
        organization,
        password,
      ];

  // copyWith
  User copyWith({
    bool? isDarkTheme,
    List<String>? interests,
    String? email,
    String? name,
    String? organization,
    String? password,
  }) {
    return User(
      email: email ?? this.email,
      interests: interests ?? this.interests,
      isDarkTheme: isDarkTheme ?? this.isDarkTheme,
      name: name ?? this.name,
      organization: organization ?? this.organization,
      password: password ?? this.password,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    List<String> interestsList = [];
    if (json['interests'] != null) {
      interestsList = (json['interests'] as List)
          .map((interest) => interest as String)
          .toList();
    }

    return User(
      email: json['email'] ?? '',
      interests: interestsList,
      isDarkTheme: json['isDarkTheme'] ?? false,
      name: json['name'] ?? '',
      password: json['password'] ?? '',
      organization: json['organization'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'interests': interests,
      'isDarkTheme': isDarkTheme,
      'name': name,
      'password': password,
      'organization': organization,
    };
  }

  // emptyUser
  static const emptyUser = User(
    email: '',
    interests: [],
    isDarkTheme: false,
    name: '',
    password: '',
    // organization: '',
  );

  // exampleUser
  static const davidUser = User(
    email: 'david@portcall.com',
    interests: [
      'portcall',
      'coding',
    ],
    isDarkTheme: false,
    name: 'David Corso',
    password: 'Password1#',
    organization: 'PortCall',
  );

  static const oluUser = emptyUser;
}
