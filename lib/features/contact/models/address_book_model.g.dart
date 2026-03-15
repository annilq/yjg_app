// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ContactModel _$ContactModelFromJson(Map<String, dynamic> json) => ContactModel(
  userId: (json['userId'] as num?)?.toInt(),
  name: json['name'] as String?,
  position: json['position'] as String?,
  dept: json['dept'] as String?,
  phone: json['phone'] as String?,
  email: json['email'] as String?,
  fc: json['fc'] as bool?,
  firstLetter: json['firstLetter'] as String?,
);

Map<String, dynamic> _$ContactModelToJson(ContactModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'name': instance.name,
      'position': instance.position,
      'dept': instance.dept,
      'phone': instance.phone,
      'email': instance.email,
      'fc': instance.fc,
      'firstLetter': instance.firstLetter,
    };

DeptModel _$DeptModelFromJson(Map<String, dynamic> json) => DeptModel(
  name: json['name'] as String?,
  children: (json['children'] as List<dynamic>?)
      ?.map((e) => ContactModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DeptModelToJson(DeptModel instance) => <String, dynamic>{
  'name': instance.name,
  'children': instance.children,
};

AddressBookResponseModel _$AddressBookResponseModelFromJson(
  Map<String, dynamic> json,
) => AddressBookResponseModel(
  code: (json['code'] as num?)?.toInt(),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => DeptModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$AddressBookResponseModelToJson(
  AddressBookResponseModel instance,
) => <String, dynamic>{'code': instance.code, 'data': instance.data};
