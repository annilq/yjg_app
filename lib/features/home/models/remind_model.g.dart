// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'remind_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RemindModelImpl _$$RemindModelImplFromJson(Map<String, dynamic> json) =>
    _$RemindModelImpl(
      id: json['id'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      createTime: json['createTime'] as String?,
      formKey: json['formKey'] as String?,
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$RemindModelImplToJson(_$RemindModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'createTime': instance.createTime,
      'formKey': instance.formKey,
      'count': instance.count,
    };

_$MainRemindsResponseModelImpl _$$MainRemindsResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$MainRemindsResponseModelImpl(
  code: (json['code'] as num?)?.toInt(),
  message: json['message'] as String?,
  remindModels: (json['remindModels'] as List<dynamic>?)
      ?.map((e) => RemindModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$MainRemindsResponseModelImplToJson(
  _$MainRemindsResponseModelImpl instance,
) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'remindModels': instance.remindModels,
};
