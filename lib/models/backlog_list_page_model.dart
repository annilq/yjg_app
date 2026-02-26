class BacklogListPageModel {
  List<BacklogModel>? backlogModels;
  int? total;
  int? page;
  int? rows;

  BacklogListPageModel.fromJson(Map<String, dynamic> json) {
    if (json['backlogModels'] != null) {
      backlogModels = [];
      json['backlogModels'].forEach((v) {
        backlogModels!.add(BacklogModel.fromJson(v));
      });
    }
    total = json['total'];
    page = json['page'];
    rows = json['rows'];
  }
}

class BacklogModel {
  String? id;
  String? title;
  String? createTime;
  String? createUser;
  int? status;

  BacklogModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    createTime = json['createTime'];
    createUser = json['createUser'];
    status = json['status'];
  }
}
