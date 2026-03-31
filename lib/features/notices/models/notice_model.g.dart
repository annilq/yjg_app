// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoticeModelImpl _$$NoticeModelImplFromJson(Map<String, dynamic> json) =>
    _$NoticeModelImpl(
      id: json['id'] as String?,
      formKey: json['formKey'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      time: json['time'] as String?,
      functionId: (json['functionId'] as num?)?.toInt(),
      count: (json['count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$$NoticeModelImplToJson(_$NoticeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'formKey': instance.formKey,
      'title': instance.title,
      'content': instance.content,
      'time': instance.time,
      'functionId': instance.functionId,
      'count': instance.count,
    };

_$NoticeListDataImpl _$$NoticeListDataImplFromJson(Map<String, dynamic> json) =>
    _$NoticeListDataImpl(
      notices: (json['notices'] as List<dynamic>?)
          ?.map((e) => NoticeModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$NoticeListDataImplToJson(
  _$NoticeListDataImpl instance,
) => <String, dynamic>{'notices': instance.notices};
