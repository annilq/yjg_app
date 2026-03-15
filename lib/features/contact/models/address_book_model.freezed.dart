// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'address_book_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ContactModel _$ContactModelFromJson(Map<String, dynamic> json) {
  return _ContactModel.fromJson(json);
}

/// @nodoc
mixin _$ContactModel {
  String? get userId => throw _privateConstructorUsedError;
  String? get userName => throw _privateConstructorUsedError;
  String? get position => throw _privateConstructorUsedError;
  String? get department => throw _privateConstructorUsedError;
  String? get phone => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  bool? get isFrequent => throw _privateConstructorUsedError;
  String? get deptName => throw _privateConstructorUsedError;

  /// Serializes this ContactModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ContactModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ContactModelCopyWith<ContactModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ContactModelCopyWith<$Res> {
  factory $ContactModelCopyWith(
    ContactModel value,
    $Res Function(ContactModel) then,
  ) = _$ContactModelCopyWithImpl<$Res, ContactModel>;
  @useResult
  $Res call({
    String? userId,
    String? userName,
    String? position,
    String? department,
    String? phone,
    String? email,
    bool? isFrequent,
    String? deptName,
  });
}

/// @nodoc
class _$ContactModelCopyWithImpl<$Res, $Val extends ContactModel>
    implements $ContactModelCopyWith<$Res> {
  _$ContactModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ContactModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? userName = freezed,
    Object? position = freezed,
    Object? department = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? isFrequent = freezed,
    Object? deptName = freezed,
  }) {
    return _then(
      _value.copyWith(
            userId: freezed == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String?,
            userName: freezed == userName
                ? _value.userName
                : userName // ignore: cast_nullable_to_non_nullable
                      as String?,
            position: freezed == position
                ? _value.position
                : position // ignore: cast_nullable_to_non_nullable
                      as String?,
            department: freezed == department
                ? _value.department
                : department // ignore: cast_nullable_to_non_nullable
                      as String?,
            phone: freezed == phone
                ? _value.phone
                : phone // ignore: cast_nullable_to_non_nullable
                      as String?,
            email: freezed == email
                ? _value.email
                : email // ignore: cast_nullable_to_non_nullable
                      as String?,
            isFrequent: freezed == isFrequent
                ? _value.isFrequent
                : isFrequent // ignore: cast_nullable_to_non_nullable
                      as bool?,
            deptName: freezed == deptName
                ? _value.deptName
                : deptName // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ContactModelImplCopyWith<$Res>
    implements $ContactModelCopyWith<$Res> {
  factory _$$ContactModelImplCopyWith(
    _$ContactModelImpl value,
    $Res Function(_$ContactModelImpl) then,
  ) = __$$ContactModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? userId,
    String? userName,
    String? position,
    String? department,
    String? phone,
    String? email,
    bool? isFrequent,
    String? deptName,
  });
}

/// @nodoc
class __$$ContactModelImplCopyWithImpl<$Res>
    extends _$ContactModelCopyWithImpl<$Res, _$ContactModelImpl>
    implements _$$ContactModelImplCopyWith<$Res> {
  __$$ContactModelImplCopyWithImpl(
    _$ContactModelImpl _value,
    $Res Function(_$ContactModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ContactModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? userId = freezed,
    Object? userName = freezed,
    Object? position = freezed,
    Object? department = freezed,
    Object? phone = freezed,
    Object? email = freezed,
    Object? isFrequent = freezed,
    Object? deptName = freezed,
  }) {
    return _then(
      _$ContactModelImpl(
        userId: freezed == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String?,
        userName: freezed == userName
            ? _value.userName
            : userName // ignore: cast_nullable_to_non_nullable
                  as String?,
        position: freezed == position
            ? _value.position
            : position // ignore: cast_nullable_to_non_nullable
                  as String?,
        department: freezed == department
            ? _value.department
            : department // ignore: cast_nullable_to_non_nullable
                  as String?,
        phone: freezed == phone
            ? _value.phone
            : phone // ignore: cast_nullable_to_non_nullable
                  as String?,
        email: freezed == email
            ? _value.email
            : email // ignore: cast_nullable_to_non_nullable
                  as String?,
        isFrequent: freezed == isFrequent
            ? _value.isFrequent
            : isFrequent // ignore: cast_nullable_to_non_nullable
                  as bool?,
        deptName: freezed == deptName
            ? _value.deptName
            : deptName // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ContactModelImpl implements _ContactModel {
  const _$ContactModelImpl({
    this.userId,
    this.userName,
    this.position,
    this.department,
    this.phone,
    this.email,
    this.isFrequent,
    this.deptName,
  });

  factory _$ContactModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$ContactModelImplFromJson(json);

  @override
  final String? userId;
  @override
  final String? userName;
  @override
  final String? position;
  @override
  final String? department;
  @override
  final String? phone;
  @override
  final String? email;
  @override
  final bool? isFrequent;
  @override
  final String? deptName;

  @override
  String toString() {
    return 'ContactModel(userId: $userId, userName: $userName, position: $position, department: $department, phone: $phone, email: $email, isFrequent: $isFrequent, deptName: $deptName)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ContactModelImpl &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.userName, userName) ||
                other.userName == userName) &&
            (identical(other.position, position) ||
                other.position == position) &&
            (identical(other.department, department) ||
                other.department == department) &&
            (identical(other.phone, phone) || other.phone == phone) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.isFrequent, isFrequent) ||
                other.isFrequent == isFrequent) &&
            (identical(other.deptName, deptName) ||
                other.deptName == deptName));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    userId,
    userName,
    position,
    department,
    phone,
    email,
    isFrequent,
    deptName,
  );

  /// Create a copy of ContactModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ContactModelImplCopyWith<_$ContactModelImpl> get copyWith =>
      __$$ContactModelImplCopyWithImpl<_$ContactModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ContactModelImplToJson(this);
  }
}

abstract class _ContactModel implements ContactModel {
  const factory _ContactModel({
    final String? userId,
    final String? userName,
    final String? position,
    final String? department,
    final String? phone,
    final String? email,
    final bool? isFrequent,
    final String? deptName,
  }) = _$ContactModelImpl;

  factory _ContactModel.fromJson(Map<String, dynamic> json) =
      _$ContactModelImpl.fromJson;

  @override
  String? get userId;
  @override
  String? get userName;
  @override
  String? get position;
  @override
  String? get department;
  @override
  String? get phone;
  @override
  String? get email;
  @override
  bool? get isFrequent;
  @override
  String? get deptName;

  /// Create a copy of ContactModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ContactModelImplCopyWith<_$ContactModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

DeptModel _$DeptModelFromJson(Map<String, dynamic> json) {
  return _DeptModel.fromJson(json);
}

/// @nodoc
mixin _$DeptModel {
  String? get deptId => throw _privateConstructorUsedError;
  String? get deptName => throw _privateConstructorUsedError;
  List<ContactModel>? get userModels => throw _privateConstructorUsedError;

  /// Serializes this DeptModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of DeptModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $DeptModelCopyWith<DeptModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $DeptModelCopyWith<$Res> {
  factory $DeptModelCopyWith(DeptModel value, $Res Function(DeptModel) then) =
      _$DeptModelCopyWithImpl<$Res, DeptModel>;
  @useResult
  $Res call({String? deptId, String? deptName, List<ContactModel>? userModels});
}

/// @nodoc
class _$DeptModelCopyWithImpl<$Res, $Val extends DeptModel>
    implements $DeptModelCopyWith<$Res> {
  _$DeptModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of DeptModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deptId = freezed,
    Object? deptName = freezed,
    Object? userModels = freezed,
  }) {
    return _then(
      _value.copyWith(
            deptId: freezed == deptId
                ? _value.deptId
                : deptId // ignore: cast_nullable_to_non_nullable
                      as String?,
            deptName: freezed == deptName
                ? _value.deptName
                : deptName // ignore: cast_nullable_to_non_nullable
                      as String?,
            userModels: freezed == userModels
                ? _value.userModels
                : userModels // ignore: cast_nullable_to_non_nullable
                      as List<ContactModel>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$DeptModelImplCopyWith<$Res>
    implements $DeptModelCopyWith<$Res> {
  factory _$$DeptModelImplCopyWith(
    _$DeptModelImpl value,
    $Res Function(_$DeptModelImpl) then,
  ) = __$$DeptModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? deptId, String? deptName, List<ContactModel>? userModels});
}

/// @nodoc
class __$$DeptModelImplCopyWithImpl<$Res>
    extends _$DeptModelCopyWithImpl<$Res, _$DeptModelImpl>
    implements _$$DeptModelImplCopyWith<$Res> {
  __$$DeptModelImplCopyWithImpl(
    _$DeptModelImpl _value,
    $Res Function(_$DeptModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of DeptModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? deptId = freezed,
    Object? deptName = freezed,
    Object? userModels = freezed,
  }) {
    return _then(
      _$DeptModelImpl(
        deptId: freezed == deptId
            ? _value.deptId
            : deptId // ignore: cast_nullable_to_non_nullable
                  as String?,
        deptName: freezed == deptName
            ? _value.deptName
            : deptName // ignore: cast_nullable_to_non_nullable
                  as String?,
        userModels: freezed == userModels
            ? _value._userModels
            : userModels // ignore: cast_nullable_to_non_nullable
                  as List<ContactModel>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$DeptModelImpl implements _DeptModel {
  const _$DeptModelImpl({
    this.deptId,
    this.deptName,
    final List<ContactModel>? userModels,
  }) : _userModels = userModels;

  factory _$DeptModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$DeptModelImplFromJson(json);

  @override
  final String? deptId;
  @override
  final String? deptName;
  final List<ContactModel>? _userModels;
  @override
  List<ContactModel>? get userModels {
    final value = _userModels;
    if (value == null) return null;
    if (_userModels is EqualUnmodifiableListView) return _userModels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'DeptModel(deptId: $deptId, deptName: $deptName, userModels: $userModels)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$DeptModelImpl &&
            (identical(other.deptId, deptId) || other.deptId == deptId) &&
            (identical(other.deptName, deptName) ||
                other.deptName == deptName) &&
            const DeepCollectionEquality().equals(
              other._userModels,
              _userModels,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    deptId,
    deptName,
    const DeepCollectionEquality().hash(_userModels),
  );

  /// Create a copy of DeptModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$DeptModelImplCopyWith<_$DeptModelImpl> get copyWith =>
      __$$DeptModelImplCopyWithImpl<_$DeptModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$DeptModelImplToJson(this);
  }
}

abstract class _DeptModel implements DeptModel {
  const factory _DeptModel({
    final String? deptId,
    final String? deptName,
    final List<ContactModel>? userModels,
  }) = _$DeptModelImpl;

  factory _DeptModel.fromJson(Map<String, dynamic> json) =
      _$DeptModelImpl.fromJson;

  @override
  String? get deptId;
  @override
  String? get deptName;
  @override
  List<ContactModel>? get userModels;

  /// Create a copy of DeptModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$DeptModelImplCopyWith<_$DeptModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AddressBookFrequentResponseModel _$AddressBookFrequentResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _AddressBookFrequentResponseModel.fromJson(json);
}

/// @nodoc
mixin _$AddressBookFrequentResponseModel {
  int? get code => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<ContactModel>? get contactModels => throw _privateConstructorUsedError;

  /// Serializes this AddressBookFrequentResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddressBookFrequentResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressBookFrequentResponseModelCopyWith<AddressBookFrequentResponseModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressBookFrequentResponseModelCopyWith<$Res> {
  factory $AddressBookFrequentResponseModelCopyWith(
    AddressBookFrequentResponseModel value,
    $Res Function(AddressBookFrequentResponseModel) then,
  ) =
      _$AddressBookFrequentResponseModelCopyWithImpl<
        $Res,
        AddressBookFrequentResponseModel
      >;
  @useResult
  $Res call({int? code, String? message, List<ContactModel>? contactModels});
}

/// @nodoc
class _$AddressBookFrequentResponseModelCopyWithImpl<
  $Res,
  $Val extends AddressBookFrequentResponseModel
>
    implements $AddressBookFrequentResponseModelCopyWith<$Res> {
  _$AddressBookFrequentResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressBookFrequentResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? contactModels = freezed,
  }) {
    return _then(
      _value.copyWith(
            code: freezed == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as int?,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            contactModels: freezed == contactModels
                ? _value.contactModels
                : contactModels // ignore: cast_nullable_to_non_nullable
                      as List<ContactModel>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AddressBookFrequentResponseModelImplCopyWith<$Res>
    implements $AddressBookFrequentResponseModelCopyWith<$Res> {
  factory _$$AddressBookFrequentResponseModelImplCopyWith(
    _$AddressBookFrequentResponseModelImpl value,
    $Res Function(_$AddressBookFrequentResponseModelImpl) then,
  ) = __$$AddressBookFrequentResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? code, String? message, List<ContactModel>? contactModels});
}

/// @nodoc
class __$$AddressBookFrequentResponseModelImplCopyWithImpl<$Res>
    extends
        _$AddressBookFrequentResponseModelCopyWithImpl<
          $Res,
          _$AddressBookFrequentResponseModelImpl
        >
    implements _$$AddressBookFrequentResponseModelImplCopyWith<$Res> {
  __$$AddressBookFrequentResponseModelImplCopyWithImpl(
    _$AddressBookFrequentResponseModelImpl _value,
    $Res Function(_$AddressBookFrequentResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddressBookFrequentResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? contactModels = freezed,
  }) {
    return _then(
      _$AddressBookFrequentResponseModelImpl(
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as int?,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        contactModels: freezed == contactModels
            ? _value._contactModels
            : contactModels // ignore: cast_nullable_to_non_nullable
                  as List<ContactModel>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressBookFrequentResponseModelImpl
    implements _AddressBookFrequentResponseModel {
  const _$AddressBookFrequentResponseModelImpl({
    this.code,
    this.message,
    final List<ContactModel>? contactModels,
  }) : _contactModels = contactModels;

  factory _$AddressBookFrequentResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$AddressBookFrequentResponseModelImplFromJson(json);

  @override
  final int? code;
  @override
  final String? message;
  final List<ContactModel>? _contactModels;
  @override
  List<ContactModel>? get contactModels {
    final value = _contactModels;
    if (value == null) return null;
    if (_contactModels is EqualUnmodifiableListView) return _contactModels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AddressBookFrequentResponseModel(code: $code, message: $message, contactModels: $contactModels)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressBookFrequentResponseModelImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(
              other._contactModels,
              _contactModels,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    code,
    message,
    const DeepCollectionEquality().hash(_contactModels),
  );

  /// Create a copy of AddressBookFrequentResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressBookFrequentResponseModelImplCopyWith<
    _$AddressBookFrequentResponseModelImpl
  >
  get copyWith =>
      __$$AddressBookFrequentResponseModelImplCopyWithImpl<
        _$AddressBookFrequentResponseModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressBookFrequentResponseModelImplToJson(this);
  }
}

abstract class _AddressBookFrequentResponseModel
    implements AddressBookFrequentResponseModel {
  const factory _AddressBookFrequentResponseModel({
    final int? code,
    final String? message,
    final List<ContactModel>? contactModels,
  }) = _$AddressBookFrequentResponseModelImpl;

  factory _AddressBookFrequentResponseModel.fromJson(
    Map<String, dynamic> json,
  ) = _$AddressBookFrequentResponseModelImpl.fromJson;

  @override
  int? get code;
  @override
  String? get message;
  @override
  List<ContactModel>? get contactModels;

  /// Create a copy of AddressBookFrequentResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressBookFrequentResponseModelImplCopyWith<
    _$AddressBookFrequentResponseModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}

AddressBookFullResponseModel _$AddressBookFullResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _AddressBookFullResponseModel.fromJson(json);
}

/// @nodoc
mixin _$AddressBookFullResponseModel {
  int? get code => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<DeptModel>? get deptModels => throw _privateConstructorUsedError;

  /// Serializes this AddressBookFullResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AddressBookFullResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AddressBookFullResponseModelCopyWith<AddressBookFullResponseModel>
  get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddressBookFullResponseModelCopyWith<$Res> {
  factory $AddressBookFullResponseModelCopyWith(
    AddressBookFullResponseModel value,
    $Res Function(AddressBookFullResponseModel) then,
  ) =
      _$AddressBookFullResponseModelCopyWithImpl<
        $Res,
        AddressBookFullResponseModel
      >;
  @useResult
  $Res call({int? code, String? message, List<DeptModel>? deptModels});
}

/// @nodoc
class _$AddressBookFullResponseModelCopyWithImpl<
  $Res,
  $Val extends AddressBookFullResponseModel
>
    implements $AddressBookFullResponseModelCopyWith<$Res> {
  _$AddressBookFullResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AddressBookFullResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? deptModels = freezed,
  }) {
    return _then(
      _value.copyWith(
            code: freezed == code
                ? _value.code
                : code // ignore: cast_nullable_to_non_nullable
                      as int?,
            message: freezed == message
                ? _value.message
                : message // ignore: cast_nullable_to_non_nullable
                      as String?,
            deptModels: freezed == deptModels
                ? _value.deptModels
                : deptModels // ignore: cast_nullable_to_non_nullable
                      as List<DeptModel>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AddressBookFullResponseModelImplCopyWith<$Res>
    implements $AddressBookFullResponseModelCopyWith<$Res> {
  factory _$$AddressBookFullResponseModelImplCopyWith(
    _$AddressBookFullResponseModelImpl value,
    $Res Function(_$AddressBookFullResponseModelImpl) then,
  ) = __$$AddressBookFullResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? code, String? message, List<DeptModel>? deptModels});
}

/// @nodoc
class __$$AddressBookFullResponseModelImplCopyWithImpl<$Res>
    extends
        _$AddressBookFullResponseModelCopyWithImpl<
          $Res,
          _$AddressBookFullResponseModelImpl
        >
    implements _$$AddressBookFullResponseModelImplCopyWith<$Res> {
  __$$AddressBookFullResponseModelImplCopyWithImpl(
    _$AddressBookFullResponseModelImpl _value,
    $Res Function(_$AddressBookFullResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AddressBookFullResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? deptModels = freezed,
  }) {
    return _then(
      _$AddressBookFullResponseModelImpl(
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as int?,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        deptModels: freezed == deptModels
            ? _value._deptModels
            : deptModels // ignore: cast_nullable_to_non_nullable
                  as List<DeptModel>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AddressBookFullResponseModelImpl
    implements _AddressBookFullResponseModel {
  const _$AddressBookFullResponseModelImpl({
    this.code,
    this.message,
    final List<DeptModel>? deptModels,
  }) : _deptModels = deptModels;

  factory _$AddressBookFullResponseModelImpl.fromJson(
    Map<String, dynamic> json,
  ) => _$$AddressBookFullResponseModelImplFromJson(json);

  @override
  final int? code;
  @override
  final String? message;
  final List<DeptModel>? _deptModels;
  @override
  List<DeptModel>? get deptModels {
    final value = _deptModels;
    if (value == null) return null;
    if (_deptModels is EqualUnmodifiableListView) return _deptModels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'AddressBookFullResponseModel(code: $code, message: $message, deptModels: $deptModels)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AddressBookFullResponseModelImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(
              other._deptModels,
              _deptModels,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    code,
    message,
    const DeepCollectionEquality().hash(_deptModels),
  );

  /// Create a copy of AddressBookFullResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AddressBookFullResponseModelImplCopyWith<
    _$AddressBookFullResponseModelImpl
  >
  get copyWith =>
      __$$AddressBookFullResponseModelImplCopyWithImpl<
        _$AddressBookFullResponseModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AddressBookFullResponseModelImplToJson(this);
  }
}

abstract class _AddressBookFullResponseModel
    implements AddressBookFullResponseModel {
  const factory _AddressBookFullResponseModel({
    final int? code,
    final String? message,
    final List<DeptModel>? deptModels,
  }) = _$AddressBookFullResponseModelImpl;

  factory _AddressBookFullResponseModel.fromJson(Map<String, dynamic> json) =
      _$AddressBookFullResponseModelImpl.fromJson;

  @override
  int? get code;
  @override
  String? get message;
  @override
  List<DeptModel>? get deptModels;

  /// Create a copy of AddressBookFullResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AddressBookFullResponseModelImplCopyWith<
    _$AddressBookFullResponseModelImpl
  >
  get copyWith => throw _privateConstructorUsedError;
}
