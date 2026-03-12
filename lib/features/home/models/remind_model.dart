import 'package:freezed_annotation/freezed_annotation.dart';

part 'remind_model.freezed.dart';
part 'remind_model.g.dart';

@freezed
class RemindModel with _$RemindModel {
  const factory RemindModel({
    String? id,
    String? title,
    String? content,
    String? createTime,
    String? formKey,
    int? count,
  }) = _RemindModel;

  factory RemindModel.fromJson(Map<String, dynamic> json) => _$RemindModelFromJson(json);
}

@freezed
class MainRemindsResponseModel with _$MainRemindsResponseModel {
  const factory MainRemindsResponseModel({
    int? code,
    String? message,
    List<RemindModel>? remindModels,
  }) = _MainRemindsResponseModel;

  factory MainRemindsResponseModel.fromJson(Map<String, dynamic> json) => _$MainRemindsResponseModelFromJson(json);
}