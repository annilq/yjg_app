class DataListPageModel {
  List<DataModel>? dataModels;
  int? total;
  int? page;
  int? rows;

  DataListPageModel.fromJson(Map<String, dynamic> json) {
    if (json['dataModels'] != null) {
      dataModels = [];
      json['dataModels'].forEach((v) {
        dataModels!.add(DataModel.fromJson(v));
      });
    }
    total = json['total'];
    page = json['page'];
    rows = json['rows'];
  }
}

class DataModel {
  String? id;
  String? title;
  String? content;
  String? createTime;
  String? createUser;

  DataModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createTime = json['createTime'];
    createUser = json['createUser'];
  }
}
