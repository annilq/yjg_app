import 'package:freezed_annotation/freezed_annotation.dart';

part 'workflow_model.freezed.dart';
part 'workflow_model.g.dart';

@freezed
class WorkflowMenu with _$WorkflowMenu {
  const factory WorkflowMenu({
    String? id,
    String? text,
    String? img,
    List<WorkflowItem>? children,
  }) = _WorkflowMenu;

  factory WorkflowMenu.fromJson(Map<String, dynamic> json) => _$WorkflowMenuFromJson(json);
}

@freezed
class WorkflowItem with _$WorkflowItem {
  const factory WorkflowItem({
    String? id,
    String? text,
    String? img,
  }) = _WorkflowItem;

  factory WorkflowItem.fromJson(Map<String, dynamic> json) => _$WorkflowItemFromJson(json);
}

@freezed
class WorkflowConfig with _$WorkflowConfig {
  const factory WorkflowConfig({
    String? formKey,
    Map<String, dynamic>? formMode,
  }) = _WorkflowConfig;

  factory WorkflowConfig.fromJson(Map<String, dynamic> json) => _$WorkflowConfigFromJson(json);
}
