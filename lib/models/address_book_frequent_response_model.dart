class AddressBookFrequentResponseModel {
  List<ContactModel>? contactModels;

  AddressBookFrequentResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['contactModels'] != null) {
      contactModels = [];
      json['contactModels'].forEach((v) {
        contactModels!.add(ContactModel.fromJson(v));
      });
    }
  }
}

class ContactModel {
  String? userId;
  String? userName;
  String? phone;
  String? email;
  String? position;
  String? deptName;
  bool? isFrequent;

  ContactModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    userName = json['userName'];
    phone = json['phone'];
    email = json['email'];
    position = json['position'];
    deptName = json['deptName'];
    isFrequent = json['isFrequent'];
  }
}
