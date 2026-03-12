// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workflow_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$WorkflowMenuImpl _$$WorkflowMenuImplFromJson(Map<String, dynamic> json) =>
    _$WorkflowMenuImpl(
      id: json['id'] as String?,
      text: json['text'] as String?,
      img: json['img'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => WorkflowItem.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$WorkflowMenuImplToJson(_$WorkflowMenuImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'img': instance.img,
      'children': instance.children,
    };

_$WorkflowItemImpl _$$WorkflowItemImplFromJson(Map<String, dynamic> json) =>
    _$WorkflowItemImpl(
      id: json['id'] as String?,
      text: json['text'] as String?,
      img: json['img'] as String?,
    );

Map<String, dynamic> _$$WorkflowItemImplToJson(_$WorkflowItemImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'text': instance.text,
      'img': instance.img,
    };

_$WorkflowConfigImpl _$$WorkflowConfigImplFromJson(Map<String, dynamic> json) =>
    _$WorkflowConfigImpl(
      formKey: json['formKey'] as String?,
      formMode: json['formMode'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$WorkflowConfigImplToJson(
  _$WorkflowConfigImpl instance,
) => <String, dynamic>{
  'formKey': instance.formKey,
  'formMode': instance.formMode,
};
