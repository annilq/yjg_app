import 'package:freezed_annotation/freezed_annotation.dart';

part 'backlog_model.freezed.dart';
part 'backlog_model.g.dart';

@freezed
class BacklogItem with _$BacklogItem {
  const factory BacklogItem({
    String? id,
    String? title,
    String? status,
    String? createTime,
    String? assignee,
  }) = _BacklogItem;

  factory BacklogItem.fromJson(Map<String, dynamic> json) => _$BacklogItemFromJson(json);
}

@freezed
class BacklogListData with _$BacklogListData {
  const factory BacklogListData({
    List<BacklogItem>? items,
    bool? hasMore,
  }) = _BacklogListData;

  factory BacklogListData.fromJson(Map<String, dynamic> json) => _$BacklogListDataFromJson(json);
}
