// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountImpl _$$AccountImplFromJson(Map<String, dynamic> json) =>
    _$AccountImpl(
      value: (json['value'] as num).toInt(),
      label: json['label'] as String,
      selected: json['selected'] as bool? ?? false,
      disabled: json['disabled'] as bool? ?? false,
    );

Map<String, dynamic> _$$AccountImplToJson(_$AccountImpl instance) =>
    <String, dynamic>{
      'value': instance.value,
      'label': instance.label,
      'selected': instance.selected,
      'disabled': instance.disabled,
    };
