class LoginResponse {
  final String token;
  final UserInfo userInfo;

  LoginResponse({
    required this.token,
    required this.userInfo,
  });

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      token: json['token'] ?? '',
      userInfo: UserInfo.fromJson(json['userInfo'] ?? {}),
    );
  }
}

class UserInfo {
  final String id;
  final String username;
  final String name;
  final String email;

  UserInfo({
    required this.id,
    required this.username,
    required this.name,
    required this.email,
  });

  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      name: json['name'] ?? '',
      email: json['email'] ?? '',
    );
  }
}
