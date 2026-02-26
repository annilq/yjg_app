class NotificationListPageModel {
  List<NotificationModel>? notificationModels;
  int? total;
  int? page;
  int? rows;

  NotificationListPageModel.fromJson(Map<String, dynamic> json) {
    if (json['notificationModels'] != null) {
      notificationModels = [];
      json['notificationModels'].forEach((v) {
        notificationModels!.add(NotificationModel.fromJson(v));
      });
    }
    total = json['total'];
    page = json['page'];
    rows = json['rows'];
  }
}

class NotificationModel {
  String? id;
  String? title;
  String? content;
  String? createTime;
  int? status;

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createTime = json['createTime'];
    status = json['status'];
  }
}
