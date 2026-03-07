class WorkflowMenu {
  final String id;
  final String text;
  final String? img;
  final List<WorkflowItem>? children;

  WorkflowMenu({
    required this.id,
    required this.text,
    this.img,
    this.children,
  });

  factory WorkflowMenu.fromJson(Map<String, dynamic> json) {
    return WorkflowMenu(
      id: json['id']?.toString() ?? '',
      text: json['text'] ?? '',
      img: json['img'],
      children: json['children'] != null
          ? (json['children'] as List)
              .map((item) => WorkflowItem.fromJson(item))
              .toList()
          : null,
    );
  }
}

class WorkflowItem {
  final String id;
  final String text;
  final String? img;

  WorkflowItem({
    required this.id,
    required this.text,
    this.img,
  });

  factory WorkflowItem.fromJson(Map<String, dynamic> json) {
    return WorkflowItem(
      id: json['id']?.toString() ?? '',
      text: json['text'] ?? '',
      img: json['img'],
    );
  }
}

class WorkflowConfig {
  final String formKey;
  final Map<String, dynamic> formMode;

  WorkflowConfig({
    required this.formKey,
    required this.formMode,
  });

  factory WorkflowConfig.fromJson(Map<String, dynamic> json) {
    return WorkflowConfig(
      formKey: json['formKey'] ?? '',
      formMode: json['formMode'] ?? {},
    );
  }
}
