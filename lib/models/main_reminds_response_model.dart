class MainRemindsResponseModel {
  List<RemindModel>? remindModels;

  MainRemindsResponseModel.fromJson(Map<String, dynamic> json) {
    if (json['remindModels'] != null) {
      remindModels = [];
      json['remindModels'].forEach((v) {
        remindModels!.add(RemindModel.fromJson(v));
      });
    }
  }
}

class RemindModel {
  String? id;
  String? title;
  String? content;
  String? createTime;
  int? status;

  RemindModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createTime = json['createTime'];
    status = json['status'];
  }
}
