import 'package:freezed_annotation/freezed_annotation.dart';

part 'address_book_model.freezed.dart';
part 'address_book_model.g.dart';

@freezed
class ContactModel with _$ContactModel {
  const factory ContactModel({
    String? userId,
    String? userName,
    String? position,
    String? department,
    String? phone,
    String? email,
    bool? isFrequent,
    String? deptName,
  }) = _ContactModel;

  factory ContactModel.fromJson(Map<String, dynamic> json) => _$ContactModelFromJson(json);
}

@freezed
class DeptModel with _$DeptModel {
  const factory DeptModel({
    String? deptId,
    String? deptName,
    List<ContactModel>? userModels,
  }) = _DeptModel;

  factory DeptModel.fromJson(Map<String, dynamic> json) => _$DeptModelFromJson(json);
}

@freezed
class AddressBookFrequentResponseModel with _$AddressBookFrequentResponseModel {
  const factory AddressBookFrequentResponseModel({
    int? code,
    String? message,
    List<ContactModel>? contactModels,
  }) = _AddressBookFrequentResponseModel;

  factory AddressBookFrequentResponseModel.fromJson(Map<String, dynamic> json) => _$AddressBookFrequentResponseModelFromJson(json);
}

@freezed
class AddressBookFullResponseModel with _$AddressBookFullResponseModel {
  const factory AddressBookFullResponseModel({
    int? code,
    String? message,
    List<DeptModel>? deptModels,
  }) = _AddressBookFullResponseModel;

  factory AddressBookFullResponseModel.fromJson(Map<String, dynamic> json) => _$AddressBookFullResponseModelFromJson(json);
}