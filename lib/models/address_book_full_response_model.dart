class AddressBookFullResponseModel {
  List<DeptModel>? deptModels;

  AddressBookFullResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['deptModels'] != null) {
      deptModels = [];
      json['deptModels'].forEach((v) {
        deptModels!.add(DeptModel.fromJson(v));
      });
    }
  }
}

class DeptModel {
  String? deptId;
  String? deptName;
  List<UserModel>? userModels;
  List<DeptModel>? subDepts;

  DeptModel.fromJson(Map<String, dynamic> json) {
    deptId = json['deptId'];
    deptName = json['deptName'];
    if (json['userModels'] != null) {
      userModels = [];
      json['userModels'].forEach((v) {
        userModels!.add(UserModel.fromJson(v));
      });
    }
    if (json['subDepts'] != null) {
      subDepts = [];
      json['subDepts'].forEach((v) {
        subDepts!.add(DeptModel.fromJson(v));
      });
    }
  }
}

class UserModel {
  String? userId;
  String? userName;
  String? phone;
  String? email;
  String? position;

  UserModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    phone = json['phone'];
    email = json['email'];
    position = json['position'];
  }
}
