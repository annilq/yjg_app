import 'package:json_annotation/json_annotation.dart';

part 'address_book_model.g.dart';

@JsonSerializable()
class ContactModel {
  final int? userId;
  final String? name;
  final String? position;
  final String? dept;
  final String? phone;
  final String? email;
  final bool? fc;
  final String? firstLetter;

  ContactModel({
    this.userId,
    this.name,
    this.position,
    this.dept,
    this.phone,
    this.email,
    this.fc,
    this.firstLetter,
  });

  factory ContactModel.fromJson(Map<String, dynamic> json) {
    // 处理 fc 字段的类型转换，将 int 转换为 bool
    dynamic fcValue = json['fc'];
    bool? fc;
    if (fcValue is int) {
      fc = fcValue == 1;
    } else if (fcValue is bool) {
      fc = fcValue;
    }

    return ContactModel(
      userId: json['userId'] as int?,
      name: json['name'] as String?,
      position: json['position'] as String?,
      dept: json['dept'] as String?,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      fc: fc,
      firstLetter: json['firstLetter'] as String?,
    );
  }

  Map<String, dynamic> toJson() => _$ContactModelToJson(this);
}

@JsonSerializable()
class DeptModel {
  final String? name;
  final List<ContactModel>? children;

  DeptModel({
    this.name,
    this.children,
  });

  factory DeptModel.fromJson(Map<String, dynamic> json) => _$DeptModelFromJson(json);
  Map<String, dynamic> toJson() => _$DeptModelToJson(this);
}

@JsonSerializable()
class AddressBookResponseModel {
  final int? code;
  final List<DeptModel>? data;

  AddressBookResponseModel({
    this.code,
    this.data,
  });

  factory AddressBookResponseModel.fromJson(Map<String, dynamic> json) => _$AddressBookResponseModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddressBookResponseModelToJson(this);
}