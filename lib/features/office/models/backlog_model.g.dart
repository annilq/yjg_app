// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'backlog_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BacklogItemImpl _$$BacklogItemImplFromJson(Map<String, dynamic> json) =>
    _$BacklogItemImpl(
      id: json['id'] as String?,
      title: json['title'] as String?,
      status: json['status'] as String?,
      createTime: json['createTime'] as String?,
      assignee: json['assignee'] as String?,
    );

Map<String, dynamic> _$$BacklogItemImplToJson(_$BacklogItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'status': instance.status,
      'createTime': instance.createTime,
      'assignee': instance.assignee,
    };

_$BacklogListDataImpl _$$BacklogListDataImplFromJson(
  Map<String, dynamic> json,
) => _$BacklogListDataImpl(
  items: (json['items'] as List<dynamic>?)
      ?.map((e) => BacklogItem.fromJson(e as Map<String, dynamic>))
      .toList(),
  hasMore: json['hasMore'] as bool?,
);

Map<String, dynamic> _$$BacklogListDataImplToJson(
  _$BacklogListDataImpl instance,
) => <String, dynamic>{'items': instance.items, 'hasMore': instance.hasMore};
