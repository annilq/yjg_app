// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'remind_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

RemindModel _$RemindModelFromJson(Map<String, dynamic> json) {
  return _RemindModel.fromJson(json);
}

/// @nodoc
mixin _$RemindModel {
  String? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get createTime => throw _privateConstructorUsedError;
  String? get formKey => throw _privateConstructorUsedError;
  int? get count => throw _privateConstructorUsedError;

  /// Serializes this RemindModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RemindModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RemindModelCopyWith<RemindModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RemindModelCopyWith<$Res> {
  factory $RemindModelCopyWith(
    RemindModel value,
    $Res Function(RemindModel) then,
  ) = _$RemindModelCopyWithImpl<$Res, RemindModel>;
  @useResult
  $Res call({
    String? id,
    String? title,
    String? content,
    String? createTime,
    String? formKey,
    int? count,
  });
}

/// @nodoc
class _$RemindModelCopyWithImpl<$Res, $Val extends RemindModel>
    implements $RemindModelCopyWith<$Res> {
  _$RemindModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RemindModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? content = freezed,
    Object? createTime = freezed,
    Object? formKey = freezed,
    Object? count = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String?,
            createTime: freezed == createTime
                ? _value.createTime
                : createTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            formKey: freezed == formKey
                ? _value.formKey
                : formKey // ignore: cast_nullable_to_non_nullable
                      as String?,
            count: freezed == count
                ? _value.count
                : count // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RemindModelImplCopyWith<$Res>
    implements $RemindModelCopyWith<$Res> {
  factory _$$RemindModelImplCopyWith(
    _$RemindModelImpl value,
    $Res Function(_$RemindModelImpl) then,
  ) = __$$RemindModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? title,
    String? content,
    String? createTime,
    String? formKey,
    int? count,
  });
}

/// @nodoc
class __$$RemindModelImplCopyWithImpl<$Res>
    extends _$RemindModelCopyWithImpl<$Res, _$RemindModelImpl>
    implements _$$RemindModelImplCopyWith<$Res> {
  __$$RemindModelImplCopyWithImpl(
    _$RemindModelImpl _value,
    $Res Function(_$RemindModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of RemindModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? content = freezed,
    Object? createTime = freezed,
    Object? formKey = freezed,
    Object? count = freezed,
  }) {
    return _then(
      _$RemindModelImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String?,
        createTime: freezed == createTime
            ? _value.createTime
            : createTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        formKey: freezed == formKey
            ? _value.formKey
            : formKey // ignore: cast_nullable_to_non_nullable
                  as String?,
        count: freezed == count
            ? _value.count
            : count // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RemindModelImpl implements _RemindModel {
  const _$RemindModelImpl({
    this.id,
    this.title,
    this.content,
    this.createTime,
    this.formKey,
    this.count,
  });

  factory _$RemindModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$RemindModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? title;
  @override
  final String? content;
  @override
  final String? createTime;
  @override
  final String? formKey;
  @override
  final int? count;

  @override
  String toString() {
    return 'RemindModel(id: $id, title: $title, content: $content, createTime: $createTime, formKey: $formKey, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RemindModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.createTime, createTime) ||
                other.createTime == createTime) &&
            (identical(other.formKey, formKey) || other.formKey == formKey) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, content, createTime, formKey, count);

  /// Create a copy of RemindModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RemindModelImplCopyWith<_$RemindModelImpl> get copyWith =>
      __$$RemindModelImplCopyWithImpl<_$RemindModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RemindModelImplToJson(this);
  }
}

abstract class _RemindModel implements RemindModel {
  const factory _RemindModel({
    final String? id,
    final String? title,
    final String? content,
    final String? createTime,
    final String? formKey,
    final int? count,
  }) = _$RemindModelImpl;

  factory _RemindModel.fromJson(Map<String, dynamic> json) =
      _$RemindModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get title;
  @override
  String? get content;
  @override
  String? get createTime;
  @override
  String? get formKey;
  @override
  int? get count;

  /// Create a copy of RemindModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RemindModelImplCopyWith<_$RemindModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MainRemindsResponseModel _$MainRemindsResponseModelFromJson(
  Map<String, dynamic> json,
) {
  return _MainRemindsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$MainRemindsResponseModel {
  int? get code => throw _privateConstructorUsedError;
  String? get message => throw _privateConstructorUsedError;
  List<RemindModel>? get remindModels => throw _privateConstructorUsedError;

  /// Serializes this MainRemindsResponseModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MainRemindsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MainRemindsResponseModelCopyWith<MainRemindsResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MainRemindsResponseModelCopyWith<$Res> {
  factory $MainRemindsResponseModelCopyWith(
    MainRemindsResponseModel value,
    $Res Function(MainRemindsResponseModel) then,
  ) = _$MainRemindsResponseModelCopyWithImpl<$Res, MainRemindsResponseModel>;
  @useResult
  $Res call({int? code, String? message, List<RemindModel>? remindModels});
}

/// @nodoc
class _$MainRemindsResponseModelCopyWithImpl<
  $Res,
  $Val extends MainRemindsResponseModel
>
    implements $MainRemindsResponseModelCopyWith<$Res> {
  _$MainRemindsResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MainRemindsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? remindModels = freezed,
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
            remindModels: freezed == remindModels
                ? _value.remindModels
                : remindModels // ignore: cast_nullable_to_non_nullable
                      as List<RemindModel>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$MainRemindsResponseModelImplCopyWith<$Res>
    implements $MainRemindsResponseModelCopyWith<$Res> {
  factory _$$MainRemindsResponseModelImplCopyWith(
    _$MainRemindsResponseModelImpl value,
    $Res Function(_$MainRemindsResponseModelImpl) then,
  ) = __$$MainRemindsResponseModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int? code, String? message, List<RemindModel>? remindModels});
}

/// @nodoc
class __$$MainRemindsResponseModelImplCopyWithImpl<$Res>
    extends
        _$MainRemindsResponseModelCopyWithImpl<
          $Res,
          _$MainRemindsResponseModelImpl
        >
    implements _$$MainRemindsResponseModelImplCopyWith<$Res> {
  __$$MainRemindsResponseModelImplCopyWithImpl(
    _$MainRemindsResponseModelImpl _value,
    $Res Function(_$MainRemindsResponseModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of MainRemindsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? code = freezed,
    Object? message = freezed,
    Object? remindModels = freezed,
  }) {
    return _then(
      _$MainRemindsResponseModelImpl(
        code: freezed == code
            ? _value.code
            : code // ignore: cast_nullable_to_non_nullable
                  as int?,
        message: freezed == message
            ? _value.message
            : message // ignore: cast_nullable_to_non_nullable
                  as String?,
        remindModels: freezed == remindModels
            ? _value._remindModels
            : remindModels // ignore: cast_nullable_to_non_nullable
                  as List<RemindModel>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$MainRemindsResponseModelImpl implements _MainRemindsResponseModel {
  const _$MainRemindsResponseModelImpl({
    this.code,
    this.message,
    final List<RemindModel>? remindModels,
  }) : _remindModels = remindModels;

  factory _$MainRemindsResponseModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$MainRemindsResponseModelImplFromJson(json);

  @override
  final int? code;
  @override
  final String? message;
  final List<RemindModel>? _remindModels;
  @override
  List<RemindModel>? get remindModels {
    final value = _remindModels;
    if (value == null) return null;
    if (_remindModels is EqualUnmodifiableListView) return _remindModels;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'MainRemindsResponseModel(code: $code, message: $message, remindModels: $remindModels)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MainRemindsResponseModelImpl &&
            (identical(other.code, code) || other.code == code) &&
            (identical(other.message, message) || other.message == message) &&
            const DeepCollectionEquality().equals(
              other._remindModels,
              _remindModels,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    code,
    message,
    const DeepCollectionEquality().hash(_remindModels),
  );

  /// Create a copy of MainRemindsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MainRemindsResponseModelImplCopyWith<_$MainRemindsResponseModelImpl>
  get copyWith =>
      __$$MainRemindsResponseModelImplCopyWithImpl<
        _$MainRemindsResponseModelImpl
      >(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MainRemindsResponseModelImplToJson(this);
  }
}

abstract class _MainRemindsResponseModel implements MainRemindsResponseModel {
  const factory _MainRemindsResponseModel({
    final int? code,
    final String? message,
    final List<RemindModel>? remindModels,
  }) = _$MainRemindsResponseModelImpl;

  factory _MainRemindsResponseModel.fromJson(Map<String, dynamic> json) =
      _$MainRemindsResponseModelImpl.fromJson;

  @override
  int? get code;
  @override
  String? get message;
  @override
  List<RemindModel>? get remindModels;

  /// Create a copy of MainRemindsResponseModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MainRemindsResponseModelImplCopyWith<_$MainRemindsResponseModelImpl>
  get copyWith => throw _privateConstructorUsedError;
}
