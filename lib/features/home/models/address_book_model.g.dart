// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'address_book_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ContactModelImpl _$$ContactModelImplFromJson(Map<String, dynamic> json) =>
    _$ContactModelImpl(
      userId: json['userId'] as String?,
      userName: json['userName'] as String?,
      position: json['position'] as String?,
      department: json['department'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      isFrequent: json['isFrequent'] as bool?,
      deptName: json['deptName'] as String?,
    );

Map<String, dynamic> _$$ContactModelImplToJson(_$ContactModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'userName': instance.userName,
      'position': instance.position,
      'department': instance.department,
      'phone': instance.phone,
      'email': instance.email,
      'isFrequent': instance.isFrequent,
      'deptName': instance.deptName,
    };

_$DeptModelImpl _$$DeptModelImplFromJson(Map<String, dynamic> json) =>
    _$DeptModelImpl(
      deptId: json['deptId'] as String?,
      deptName: json['deptName'] as String?,
      userModels: (json['userModels'] as List<dynamic>?)
          ?.map((e) => ContactModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$DeptModelImplToJson(_$DeptModelImpl instance) =>
    <String, dynamic>{
      'deptId': instance.deptId,
      'deptName': instance.deptName,
      'userModels': instance.userModels,
    };

_$AddressBookFrequentResponseModelImpl
_$$AddressBookFrequentResponseModelImplFromJson(Map<String, dynamic> json) =>
    _$AddressBookFrequentResponseModelImpl(
      code: (json['code'] as num?)?.toInt(),
      message: json['message'] as String?,
      contactModels: (json['contactModels'] as List<dynamic>?)
          ?.map((e) => ContactModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$AddressBookFrequentResponseModelImplToJson(
  _$AddressBookFrequentResponseModelImpl instance,
) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'contactModels': instance.contactModels,
};

_$AddressBookFullResponseModelImpl _$$AddressBookFullResponseModelImplFromJson(
  Map<String, dynamic> json,
) => _$AddressBookFullResponseModelImpl(
  code: (json['code'] as num?)?.toInt(),
  message: json['message'] as String?,
  deptModels: (json['deptModels'] as List<dynamic>?)
      ?.map((e) => DeptModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$AddressBookFullResponseModelImplToJson(
  _$AddressBookFullResponseModelImpl instance,
) => <String, dynamic>{
  'code': instance.code,
  'message': instance.message,
  'deptModels': instance.deptModels,
};
