// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NoticeModelImpl _$$NoticeModelImplFromJson(Map<String, dynamic> json) =>
    _$NoticeModelImpl(
      id: json['id'] as String?,
      title: json['title'] as String?,
      content: json['content'] as String?,
      time: json['time'] as String?,
      isRead: json['isRead'] as bool?,
    );

Map<String, dynamic> _$$NoticeModelImplToJson(_$NoticeModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'content': instance.content,
      'time': instance.time,
      'isRead': instance.isRead,
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
