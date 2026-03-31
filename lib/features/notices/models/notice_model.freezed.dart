// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'notice_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

NoticeModel _$NoticeModelFromJson(Map<String, dynamic> json) {
  return _NoticeModel.fromJson(json);
}

/// @nodoc
mixin _$NoticeModel {
  String? get id => throw _privateConstructorUsedError;
  String? get formKey => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get content => throw _privateConstructorUsedError;
  String? get time => throw _privateConstructorUsedError;
  int? get functionId => throw _privateConstructorUsedError;
  int? get count => throw _privateConstructorUsedError;

  /// Serializes this NoticeModel to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NoticeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoticeModelCopyWith<NoticeModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoticeModelCopyWith<$Res> {
  factory $NoticeModelCopyWith(
    NoticeModel value,
    $Res Function(NoticeModel) then,
  ) = _$NoticeModelCopyWithImpl<$Res, NoticeModel>;
  @useResult
  $Res call({
    String? id,
    String? formKey,
    String? title,
    String? content,
    String? time,
    int? functionId,
    int? count,
  });
}

/// @nodoc
class _$NoticeModelCopyWithImpl<$Res, $Val extends NoticeModel>
    implements $NoticeModelCopyWith<$Res> {
  _$NoticeModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoticeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? formKey = freezed,
    Object? title = freezed,
    Object? content = freezed,
    Object? time = freezed,
    Object? functionId = freezed,
    Object? count = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            formKey: freezed == formKey
                ? _value.formKey
                : formKey // ignore: cast_nullable_to_non_nullable
                      as String?,
            title: freezed == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String?,
            content: freezed == content
                ? _value.content
                : content // ignore: cast_nullable_to_non_nullable
                      as String?,
            time: freezed == time
                ? _value.time
                : time // ignore: cast_nullable_to_non_nullable
                      as String?,
            functionId: freezed == functionId
                ? _value.functionId
                : functionId // ignore: cast_nullable_to_non_nullable
                      as int?,
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
abstract class _$$NoticeModelImplCopyWith<$Res>
    implements $NoticeModelCopyWith<$Res> {
  factory _$$NoticeModelImplCopyWith(
    _$NoticeModelImpl value,
    $Res Function(_$NoticeModelImpl) then,
  ) = __$$NoticeModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? formKey,
    String? title,
    String? content,
    String? time,
    int? functionId,
    int? count,
  });
}

/// @nodoc
class __$$NoticeModelImplCopyWithImpl<$Res>
    extends _$NoticeModelCopyWithImpl<$Res, _$NoticeModelImpl>
    implements _$$NoticeModelImplCopyWith<$Res> {
  __$$NoticeModelImplCopyWithImpl(
    _$NoticeModelImpl _value,
    $Res Function(_$NoticeModelImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NoticeModel
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? formKey = freezed,
    Object? title = freezed,
    Object? content = freezed,
    Object? time = freezed,
    Object? functionId = freezed,
    Object? count = freezed,
  }) {
    return _then(
      _$NoticeModelImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        formKey: freezed == formKey
            ? _value.formKey
            : formKey // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        content: freezed == content
            ? _value.content
            : content // ignore: cast_nullable_to_non_nullable
                  as String?,
        time: freezed == time
            ? _value.time
            : time // ignore: cast_nullable_to_non_nullable
                  as String?,
        functionId: freezed == functionId
            ? _value.functionId
            : functionId // ignore: cast_nullable_to_non_nullable
                  as int?,
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
class _$NoticeModelImpl implements _NoticeModel {
  const _$NoticeModelImpl({
    this.id,
    this.formKey,
    this.title,
    this.content,
    this.time,
    this.functionId,
    this.count,
  });

  factory _$NoticeModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoticeModelImplFromJson(json);

  @override
  final String? id;
  @override
  final String? formKey;
  @override
  final String? title;
  @override
  final String? content;
  @override
  final String? time;
  @override
  final int? functionId;
  @override
  final int? count;

  @override
  String toString() {
    return 'NoticeModel(id: $id, formKey: $formKey, title: $title, content: $content, time: $time, functionId: $functionId, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoticeModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.formKey, formKey) || other.formKey == formKey) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.content, content) || other.content == content) &&
            (identical(other.time, time) || other.time == time) &&
            (identical(other.functionId, functionId) ||
                other.functionId == functionId) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    formKey,
    title,
    content,
    time,
    functionId,
    count,
  );

  /// Create a copy of NoticeModel
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoticeModelImplCopyWith<_$NoticeModelImpl> get copyWith =>
      __$$NoticeModelImplCopyWithImpl<_$NoticeModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NoticeModelImplToJson(this);
  }
}

abstract class _NoticeModel implements NoticeModel {
  const factory _NoticeModel({
    final String? id,
    final String? formKey,
    final String? title,
    final String? content,
    final String? time,
    final int? functionId,
    final int? count,
  }) = _$NoticeModelImpl;

  factory _NoticeModel.fromJson(Map<String, dynamic> json) =
      _$NoticeModelImpl.fromJson;

  @override
  String? get id;
  @override
  String? get formKey;
  @override
  String? get title;
  @override
  String? get content;
  @override
  String? get time;
  @override
  int? get functionId;
  @override
  int? get count;

  /// Create a copy of NoticeModel
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoticeModelImplCopyWith<_$NoticeModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

NoticeListData _$NoticeListDataFromJson(Map<String, dynamic> json) {
  return _NoticeListData.fromJson(json);
}

/// @nodoc
mixin _$NoticeListData {
  List<NoticeModel>? get notices => throw _privateConstructorUsedError;

  /// Serializes this NoticeListData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of NoticeListData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $NoticeListDataCopyWith<NoticeListData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NoticeListDataCopyWith<$Res> {
  factory $NoticeListDataCopyWith(
    NoticeListData value,
    $Res Function(NoticeListData) then,
  ) = _$NoticeListDataCopyWithImpl<$Res, NoticeListData>;
  @useResult
  $Res call({List<NoticeModel>? notices});
}

/// @nodoc
class _$NoticeListDataCopyWithImpl<$Res, $Val extends NoticeListData>
    implements $NoticeListDataCopyWith<$Res> {
  _$NoticeListDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of NoticeListData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? notices = freezed}) {
    return _then(
      _value.copyWith(
            notices: freezed == notices
                ? _value.notices
                : notices // ignore: cast_nullable_to_non_nullable
                      as List<NoticeModel>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$NoticeListDataImplCopyWith<$Res>
    implements $NoticeListDataCopyWith<$Res> {
  factory _$$NoticeListDataImplCopyWith(
    _$NoticeListDataImpl value,
    $Res Function(_$NoticeListDataImpl) then,
  ) = __$$NoticeListDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<NoticeModel>? notices});
}

/// @nodoc
class __$$NoticeListDataImplCopyWithImpl<$Res>
    extends _$NoticeListDataCopyWithImpl<$Res, _$NoticeListDataImpl>
    implements _$$NoticeListDataImplCopyWith<$Res> {
  __$$NoticeListDataImplCopyWithImpl(
    _$NoticeListDataImpl _value,
    $Res Function(_$NoticeListDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of NoticeListData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? notices = freezed}) {
    return _then(
      _$NoticeListDataImpl(
        notices: freezed == notices
            ? _value._notices
            : notices // ignore: cast_nullable_to_non_nullable
                  as List<NoticeModel>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$NoticeListDataImpl implements _NoticeListData {
  const _$NoticeListDataImpl({final List<NoticeModel>? notices})
    : _notices = notices;

  factory _$NoticeListDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$NoticeListDataImplFromJson(json);

  final List<NoticeModel>? _notices;
  @override
  List<NoticeModel>? get notices {
    final value = _notices;
    if (value == null) return null;
    if (_notices is EqualUnmodifiableListView) return _notices;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'NoticeListData(notices: $notices)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NoticeListDataImpl &&
            const DeepCollectionEquality().equals(other._notices, _notices));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_notices));

  /// Create a copy of NoticeListData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$NoticeListDataImplCopyWith<_$NoticeListDataImpl> get copyWith =>
      __$$NoticeListDataImplCopyWithImpl<_$NoticeListDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$NoticeListDataImplToJson(this);
  }
}

abstract class _NoticeListData implements NoticeListData {
  const factory _NoticeListData({final List<NoticeModel>? notices}) =
      _$NoticeListDataImpl;

  factory _NoticeListData.fromJson(Map<String, dynamic> json) =
      _$NoticeListDataImpl.fromJson;

  @override
  List<NoticeModel>? get notices;

  /// Create a copy of NoticeListData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$NoticeListDataImplCopyWith<_$NoticeListDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
