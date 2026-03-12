class BacklogItem {
  final String id;
  final String title;
  final String status;
  final String createTime;
  final String assignee;

  BacklogItem({
    required this.id,
    required this.title,
    required this.status,
    required this.createTime,
    required this.assignee,
  });

  factory BacklogItem.fromJson(Map<String, dynamic> json) {
    return BacklogItem(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      status: json['status'] ?? '',
      createTime: json['createTime'] ?? '',
      assignee: json['assignee'] ?? '',
    );
  }
}

class BacklogListData {
  final List<BacklogItem> items;
  final bool hasMore;

  BacklogListData({
    required this.items,
    required this.hasMore,
  });
}
