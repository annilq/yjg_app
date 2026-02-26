class LoginResponseModel {
  String? userId;
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
    accountName = json['accountName'];
    lastUpdateTime = json['lastUpdateTime'];
    token = json['token'];
    avatar = json['avatar'];
    phone = json['phone'];
    email = json['email'];
  }
}
