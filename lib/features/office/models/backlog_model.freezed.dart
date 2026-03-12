// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'backlog_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

BacklogItem _$BacklogItemFromJson(Map<String, dynamic> json) {
  return _BacklogItem.fromJson(json);
}

/// @nodoc
mixin _$BacklogItem {
  String? get id => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  String? get createTime => throw _privateConstructorUsedError;
  String? get assignee => throw _privateConstructorUsedError;

  /// Serializes this BacklogItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BacklogItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BacklogItemCopyWith<BacklogItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BacklogItemCopyWith<$Res> {
  factory $BacklogItemCopyWith(
    BacklogItem value,
    $Res Function(BacklogItem) then,
  ) = _$BacklogItemCopyWithImpl<$Res, BacklogItem>;
  @useResult
  $Res call({
    String? id,
    String? title,
    String? status,
    String? createTime,
    String? assignee,
  });
}

/// @nodoc
class _$BacklogItemCopyWithImpl<$Res, $Val extends BacklogItem>
    implements $BacklogItemCopyWith<$Res> {
  _$BacklogItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BacklogItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? status = freezed,
    Object? createTime = freezed,
    Object? assignee = freezed,
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
            status: freezed == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String?,
            createTime: freezed == createTime
                ? _value.createTime
                : createTime // ignore: cast_nullable_to_non_nullable
                      as String?,
            assignee: freezed == assignee
                ? _value.assignee
                : assignee // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BacklogItemImplCopyWith<$Res>
    implements $BacklogItemCopyWith<$Res> {
  factory _$$BacklogItemImplCopyWith(
    _$BacklogItemImpl value,
    $Res Function(_$BacklogItemImpl) then,
  ) = __$$BacklogItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? title,
    String? status,
    String? createTime,
    String? assignee,
  });
}

/// @nodoc
class __$$BacklogItemImplCopyWithImpl<$Res>
    extends _$BacklogItemCopyWithImpl<$Res, _$BacklogItemImpl>
    implements _$$BacklogItemImplCopyWith<$Res> {
  __$$BacklogItemImplCopyWithImpl(
    _$BacklogItemImpl _value,
    $Res Function(_$BacklogItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BacklogItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? title = freezed,
    Object? status = freezed,
    Object? createTime = freezed,
    Object? assignee = freezed,
  }) {
    return _then(
      _$BacklogItemImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        title: freezed == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String?,
        status: freezed == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String?,
        createTime: freezed == createTime
            ? _value.createTime
            : createTime // ignore: cast_nullable_to_non_nullable
                  as String?,
        assignee: freezed == assignee
            ? _value.assignee
            : assignee // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BacklogItemImpl implements _BacklogItem {
  const _$BacklogItemImpl({
    this.id,
    this.title,
    this.status,
    this.createTime,
    this.assignee,
  });

  factory _$BacklogItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$BacklogItemImplFromJson(json);

  @override
  final String? id;
  @override
  final String? title;
  @override
  final String? status;
  @override
  final String? createTime;
  @override
  final String? assignee;

  @override
  String toString() {
    return 'BacklogItem(id: $id, title: $title, status: $status, createTime: $createTime, assignee: $assignee)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BacklogItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createTime, createTime) ||
                other.createTime == createTime) &&
            (identical(other.assignee, assignee) ||
                other.assignee == assignee));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, title, status, createTime, assignee);

  /// Create a copy of BacklogItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BacklogItemImplCopyWith<_$BacklogItemImpl> get copyWith =>
      __$$BacklogItemImplCopyWithImpl<_$BacklogItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$BacklogItemImplToJson(this);
  }
}

abstract class _BacklogItem implements BacklogItem {
  const factory _BacklogItem({
    final String? id,
    final String? title,
    final String? status,
    final String? createTime,
    final String? assignee,
  }) = _$BacklogItemImpl;

  factory _BacklogItem.fromJson(Map<String, dynamic> json) =
      _$BacklogItemImpl.fromJson;

  @override
  String? get id;
  @override
  String? get title;
  @override
  String? get status;
  @override
  String? get createTime;
  @override
  String? get assignee;

  /// Create a copy of BacklogItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BacklogItemImplCopyWith<_$BacklogItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

BacklogListData _$BacklogListDataFromJson(Map<String, dynamic> json) {
  return _BacklogListData.fromJson(json);
}

/// @nodoc
mixin _$BacklogListData {
  List<BacklogItem>? get items => throw _privateConstructorUsedError;
  bool? get hasMore => throw _privateConstructorUsedError;

  /// Serializes this BacklogListData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of BacklogListData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $BacklogListDataCopyWith<BacklogListData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BacklogListDataCopyWith<$Res> {
  factory $BacklogListDataCopyWith(
    BacklogListData value,
    $Res Function(BacklogListData) then,
  ) = _$BacklogListDataCopyWithImpl<$Res, BacklogListData>;
  @useResult
  $Res call({List<BacklogItem>? items, bool? hasMore});
}

/// @nodoc
class _$BacklogListDataCopyWithImpl<$Res, $Val extends BacklogListData>
    implements $BacklogListDataCopyWith<$Res> {
  _$BacklogListDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of BacklogListData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = freezed, Object? hasMore = freezed}) {
    return _then(
      _value.copyWith(
            items: freezed == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<BacklogItem>?,
            hasMore: freezed == hasMore
                ? _value.hasMore
                : hasMore // ignore: cast_nullable_to_non_nullable
                      as bool?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$BacklogListDataImplCopyWith<$Res>
    implements $BacklogListDataCopyWith<$Res> {
  factory _$$BacklogListDataImplCopyWith(
    _$BacklogListDataImpl value,
    $Res Function(_$BacklogListDataImpl) then,
  ) = __$$BacklogListDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<BacklogItem>? items, bool? hasMore});
}

/// @nodoc
class __$$BacklogListDataImplCopyWithImpl<$Res>
    extends _$BacklogListDataCopyWithImpl<$Res, _$BacklogListDataImpl>
    implements _$$BacklogListDataImplCopyWith<$Res> {
  __$$BacklogListDataImplCopyWithImpl(
    _$BacklogListDataImpl _value,
    $Res Function(_$BacklogListDataImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of BacklogListData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? items = freezed, Object? hasMore = freezed}) {
    return _then(
      _$BacklogListDataImpl(
        items: freezed == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<BacklogItem>?,
        hasMore: freezed == hasMore
            ? _value.hasMore
            : hasMore // ignore: cast_nullable_to_non_nullable
                  as bool?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$BacklogListDataImpl implements _BacklogListData {
  const _$BacklogListDataImpl({final List<BacklogItem>? items, this.hasMore})
    : _items = items;

  factory _$BacklogListDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$BacklogListDataImplFromJson(json);

  final List<BacklogItem>? _items;
  @override
  List<BacklogItem>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final bool? hasMore;

  @override
  String toString() {
    return 'BacklogListData(items: $items, hasMore: $hasMore)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$BacklogListDataImpl &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.hasMore, hasMore) || other.hasMore == hasMore));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_items),
    hasMore,
  );

  /// Create a copy of BacklogListData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$BacklogListDataImplCopyWith<_$BacklogListDataImpl> get copyWith =>
      __$$BacklogListDataImplCopyWithImpl<_$BacklogListDataImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$BacklogListDataImplToJson(this);
  }
}

abstract class _BacklogListData implements BacklogListData {
  const factory _BacklogListData({
    final List<BacklogItem>? items,
    final bool? hasMore,
  }) = _$BacklogListDataImpl;

  factory _BacklogListData.fromJson(Map<String, dynamic> json) =
      _$BacklogListDataImpl.fromJson;

  @override
  List<BacklogItem>? get items;
  @override
  bool? get hasMore;

  /// Create a copy of BacklogListData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$BacklogListDataImplCopyWith<_$BacklogListDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
