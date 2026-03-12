// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workflow_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

WorkflowMenu _$WorkflowMenuFromJson(Map<String, dynamic> json) {
  return _WorkflowMenu.fromJson(json);
}

/// @nodoc
mixin _$WorkflowMenu {
  String? get id => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  String? get img => throw _privateConstructorUsedError;
  List<WorkflowItem>? get children => throw _privateConstructorUsedError;

  /// Serializes this WorkflowMenu to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkflowMenu
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkflowMenuCopyWith<WorkflowMenu> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkflowMenuCopyWith<$Res> {
  factory $WorkflowMenuCopyWith(
    WorkflowMenu value,
    $Res Function(WorkflowMenu) then,
  ) = _$WorkflowMenuCopyWithImpl<$Res, WorkflowMenu>;
  @useResult
  $Res call({
    String? id,
    String? text,
    String? img,
    List<WorkflowItem>? children,
  });
}

/// @nodoc
class _$WorkflowMenuCopyWithImpl<$Res, $Val extends WorkflowMenu>
    implements $WorkflowMenuCopyWith<$Res> {
  _$WorkflowMenuCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkflowMenu
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? text = freezed,
    Object? img = freezed,
    Object? children = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            text: freezed == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String?,
            img: freezed == img
                ? _value.img
                : img // ignore: cast_nullable_to_non_nullable
                      as String?,
            children: freezed == children
                ? _value.children
                : children // ignore: cast_nullable_to_non_nullable
                      as List<WorkflowItem>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkflowMenuImplCopyWith<$Res>
    implements $WorkflowMenuCopyWith<$Res> {
  factory _$$WorkflowMenuImplCopyWith(
    _$WorkflowMenuImpl value,
    $Res Function(_$WorkflowMenuImpl) then,
  ) = __$$WorkflowMenuImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String? id,
    String? text,
    String? img,
    List<WorkflowItem>? children,
  });
}

/// @nodoc
class __$$WorkflowMenuImplCopyWithImpl<$Res>
    extends _$WorkflowMenuCopyWithImpl<$Res, _$WorkflowMenuImpl>
    implements _$$WorkflowMenuImplCopyWith<$Res> {
  __$$WorkflowMenuImplCopyWithImpl(
    _$WorkflowMenuImpl _value,
    $Res Function(_$WorkflowMenuImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkflowMenu
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? text = freezed,
    Object? img = freezed,
    Object? children = freezed,
  }) {
    return _then(
      _$WorkflowMenuImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        text: freezed == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String?,
        img: freezed == img
            ? _value.img
            : img // ignore: cast_nullable_to_non_nullable
                  as String?,
        children: freezed == children
            ? _value._children
            : children // ignore: cast_nullable_to_non_nullable
                  as List<WorkflowItem>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkflowMenuImpl implements _WorkflowMenu {
  const _$WorkflowMenuImpl({
    this.id,
    this.text,
    this.img,
    final List<WorkflowItem>? children,
  }) : _children = children;

  factory _$WorkflowMenuImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkflowMenuImplFromJson(json);

  @override
  final String? id;
  @override
  final String? text;
  @override
  final String? img;
  final List<WorkflowItem>? _children;
  @override
  List<WorkflowItem>? get children {
    final value = _children;
    if (value == null) return null;
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'WorkflowMenu(id: $id, text: $text, img: $img, children: $children)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkflowMenuImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.img, img) || other.img == img) &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    text,
    img,
    const DeepCollectionEquality().hash(_children),
  );

  /// Create a copy of WorkflowMenu
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkflowMenuImplCopyWith<_$WorkflowMenuImpl> get copyWith =>
      __$$WorkflowMenuImplCopyWithImpl<_$WorkflowMenuImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkflowMenuImplToJson(this);
  }
}

abstract class _WorkflowMenu implements WorkflowMenu {
  const factory _WorkflowMenu({
    final String? id,
    final String? text,
    final String? img,
    final List<WorkflowItem>? children,
  }) = _$WorkflowMenuImpl;

  factory _WorkflowMenu.fromJson(Map<String, dynamic> json) =
      _$WorkflowMenuImpl.fromJson;

  @override
  String? get id;
  @override
  String? get text;
  @override
  String? get img;
  @override
  List<WorkflowItem>? get children;

  /// Create a copy of WorkflowMenu
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkflowMenuImplCopyWith<_$WorkflowMenuImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkflowItem _$WorkflowItemFromJson(Map<String, dynamic> json) {
  return _WorkflowItem.fromJson(json);
}

/// @nodoc
mixin _$WorkflowItem {
  String? get id => throw _privateConstructorUsedError;
  String? get text => throw _privateConstructorUsedError;
  String? get img => throw _privateConstructorUsedError;

  /// Serializes this WorkflowItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkflowItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkflowItemCopyWith<WorkflowItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkflowItemCopyWith<$Res> {
  factory $WorkflowItemCopyWith(
    WorkflowItem value,
    $Res Function(WorkflowItem) then,
  ) = _$WorkflowItemCopyWithImpl<$Res, WorkflowItem>;
  @useResult
  $Res call({String? id, String? text, String? img});
}

/// @nodoc
class _$WorkflowItemCopyWithImpl<$Res, $Val extends WorkflowItem>
    implements $WorkflowItemCopyWith<$Res> {
  _$WorkflowItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkflowItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? text = freezed,
    Object? img = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: freezed == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String?,
            text: freezed == text
                ? _value.text
                : text // ignore: cast_nullable_to_non_nullable
                      as String?,
            img: freezed == img
                ? _value.img
                : img // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkflowItemImplCopyWith<$Res>
    implements $WorkflowItemCopyWith<$Res> {
  factory _$$WorkflowItemImplCopyWith(
    _$WorkflowItemImpl value,
    $Res Function(_$WorkflowItemImpl) then,
  ) = __$$WorkflowItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? id, String? text, String? img});
}

/// @nodoc
class __$$WorkflowItemImplCopyWithImpl<$Res>
    extends _$WorkflowItemCopyWithImpl<$Res, _$WorkflowItemImpl>
    implements _$$WorkflowItemImplCopyWith<$Res> {
  __$$WorkflowItemImplCopyWithImpl(
    _$WorkflowItemImpl _value,
    $Res Function(_$WorkflowItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkflowItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? text = freezed,
    Object? img = freezed,
  }) {
    return _then(
      _$WorkflowItemImpl(
        id: freezed == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String?,
        text: freezed == text
            ? _value.text
            : text // ignore: cast_nullable_to_non_nullable
                  as String?,
        img: freezed == img
            ? _value.img
            : img // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkflowItemImpl implements _WorkflowItem {
  const _$WorkflowItemImpl({this.id, this.text, this.img});

  factory _$WorkflowItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkflowItemImplFromJson(json);

  @override
  final String? id;
  @override
  final String? text;
  @override
  final String? img;

  @override
  String toString() {
    return 'WorkflowItem(id: $id, text: $text, img: $img)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkflowItemImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.text, text) || other.text == text) &&
            (identical(other.img, img) || other.img == img));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, text, img);

  /// Create a copy of WorkflowItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkflowItemImplCopyWith<_$WorkflowItemImpl> get copyWith =>
      __$$WorkflowItemImplCopyWithImpl<_$WorkflowItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkflowItemImplToJson(this);
  }
}

abstract class _WorkflowItem implements WorkflowItem {
  const factory _WorkflowItem({
    final String? id,
    final String? text,
    final String? img,
  }) = _$WorkflowItemImpl;

  factory _WorkflowItem.fromJson(Map<String, dynamic> json) =
      _$WorkflowItemImpl.fromJson;

  @override
  String? get id;
  @override
  String? get text;
  @override
  String? get img;

  /// Create a copy of WorkflowItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkflowItemImplCopyWith<_$WorkflowItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

WorkflowConfig _$WorkflowConfigFromJson(Map<String, dynamic> json) {
  return _WorkflowConfig.fromJson(json);
}

/// @nodoc
mixin _$WorkflowConfig {
  String? get formKey => throw _privateConstructorUsedError;
  Map<String, dynamic>? get formMode => throw _privateConstructorUsedError;

  /// Serializes this WorkflowConfig to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of WorkflowConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WorkflowConfigCopyWith<WorkflowConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WorkflowConfigCopyWith<$Res> {
  factory $WorkflowConfigCopyWith(
    WorkflowConfig value,
    $Res Function(WorkflowConfig) then,
  ) = _$WorkflowConfigCopyWithImpl<$Res, WorkflowConfig>;
  @useResult
  $Res call({String? formKey, Map<String, dynamic>? formMode});
}

/// @nodoc
class _$WorkflowConfigCopyWithImpl<$Res, $Val extends WorkflowConfig>
    implements $WorkflowConfigCopyWith<$Res> {
  _$WorkflowConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WorkflowConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? formKey = freezed, Object? formMode = freezed}) {
    return _then(
      _value.copyWith(
            formKey: freezed == formKey
                ? _value.formKey
                : formKey // ignore: cast_nullable_to_non_nullable
                      as String?,
            formMode: freezed == formMode
                ? _value.formMode
                : formMode // ignore: cast_nullable_to_non_nullable
                      as Map<String, dynamic>?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WorkflowConfigImplCopyWith<$Res>
    implements $WorkflowConfigCopyWith<$Res> {
  factory _$$WorkflowConfigImplCopyWith(
    _$WorkflowConfigImpl value,
    $Res Function(_$WorkflowConfigImpl) then,
  ) = __$$WorkflowConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? formKey, Map<String, dynamic>? formMode});
}

/// @nodoc
class __$$WorkflowConfigImplCopyWithImpl<$Res>
    extends _$WorkflowConfigCopyWithImpl<$Res, _$WorkflowConfigImpl>
    implements _$$WorkflowConfigImplCopyWith<$Res> {
  __$$WorkflowConfigImplCopyWithImpl(
    _$WorkflowConfigImpl _value,
    $Res Function(_$WorkflowConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WorkflowConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? formKey = freezed, Object? formMode = freezed}) {
    return _then(
      _$WorkflowConfigImpl(
        formKey: freezed == formKey
            ? _value.formKey
            : formKey // ignore: cast_nullable_to_non_nullable
                  as String?,
        formMode: freezed == formMode
            ? _value._formMode
            : formMode // ignore: cast_nullable_to_non_nullable
                  as Map<String, dynamic>?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$WorkflowConfigImpl implements _WorkflowConfig {
  const _$WorkflowConfigImpl({
    this.formKey,
    final Map<String, dynamic>? formMode,
  }) : _formMode = formMode;

  factory _$WorkflowConfigImpl.fromJson(Map<String, dynamic> json) =>
      _$$WorkflowConfigImplFromJson(json);

  @override
  final String? formKey;
  final Map<String, dynamic>? _formMode;
  @override
  Map<String, dynamic>? get formMode {
    final value = _formMode;
    if (value == null) return null;
    if (_formMode is EqualUnmodifiableMapView) return _formMode;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'WorkflowConfig(formKey: $formKey, formMode: $formMode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WorkflowConfigImpl &&
            (identical(other.formKey, formKey) || other.formKey == formKey) &&
            const DeepCollectionEquality().equals(other._formMode, _formMode));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    formKey,
    const DeepCollectionEquality().hash(_formMode),
  );

  /// Create a copy of WorkflowConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WorkflowConfigImplCopyWith<_$WorkflowConfigImpl> get copyWith =>
      __$$WorkflowConfigImplCopyWithImpl<_$WorkflowConfigImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$WorkflowConfigImplToJson(this);
  }
}

abstract class _WorkflowConfig implements WorkflowConfig {
  const factory _WorkflowConfig({
    final String? formKey,
    final Map<String, dynamic>? formMode,
  }) = _$WorkflowConfigImpl;

  factory _WorkflowConfig.fromJson(Map<String, dynamic> json) =
      _$WorkflowConfigImpl.fromJson;

  @override
  String? get formKey;
  @override
  Map<String, dynamic>? get formMode;

  /// Create a copy of WorkflowConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WorkflowConfigImplCopyWith<_$WorkflowConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
