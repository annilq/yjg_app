class NoticeModel {
  final String id;
  final String title;
  final String content;
  final String time;
  final bool isRead;

  NoticeModel({
    required this.id,
    required this.title,
    required this.content,
    required this.time,
    required this.isRead,
  });

  factory NoticeModel.fromJson(Map<String, dynamic> json) {
    return NoticeModel(
      id: json['formKey'] ?? json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      time: json['time'] ?? '',
      isRead: json['isRead'] ?? false,
    );
  }
}

class NoticeListData {
  final List<NoticeModel> notices;

  NoticeListData({
    required this.notices,
  });
}
