import 'package:freezed_annotation/freezed_annotation.dart';

part 'notice_model.freezed.dart';
part 'notice_model.g.dart';

@freezed
class NoticeModel with _$NoticeModel {
  const factory NoticeModel({
    String? id,
    String? formKey,
    String? title,
    String? content,
    String? time,
    int? functionId,
    int? count,
  }) = _NoticeModel;

  factory NoticeModel.fromJson(Map<String, dynamic> json) => _$NoticeModelFromJson(json);
}

@freezed
class NoticeListData with _$NoticeListData {
  const factory NoticeListData({
    List<NoticeModel>? notices,
  }) = _NoticeListData;

  factory NoticeListData.fromJson(Map<String, dynamic> json) => _$NoticeListDataFromJson(json);
}
