class LoginResponseModel {
  int? userId;
  String? userName;
  String? accountName;
  String? lastUpdateTime;
  String? token;
  String? avatar;
  String? phone;
  String? email;

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    accountName = json['accountFullName'];
    lastUpdateTime = json['lastUpdateTime'];
    token = json['token'];
    avatar = json['avatar'];
    phone = json['phone'];
    email = json['email'];
  }
}
