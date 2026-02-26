class LoginTokenModel {
  String? token;
  Map<String, dynamic>? userLoginInfo;

  LoginTokenModel.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    userLoginInfo = json['userLoginInfo'];
  }
}
