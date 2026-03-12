// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'webview_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WebviewConfig {
  String get url => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  bool get enableJavaScript => throw _privateConstructorUsedError;
  bool get enableDomStorage => throw _privateConstructorUsedError;
  bool get enableZoom => throw _privateConstructorUsedError;

  /// Create a copy of WebviewConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WebviewConfigCopyWith<WebviewConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebviewConfigCopyWith<$Res> {
  factory $WebviewConfigCopyWith(
    WebviewConfig value,
    $Res Function(WebviewConfig) then,
  ) = _$WebviewConfigCopyWithImpl<$Res, WebviewConfig>;
  @useResult
  $Res call({
    String url,
    String title,
    bool enableJavaScript,
    bool enableDomStorage,
    bool enableZoom,
  });
}

/// @nodoc
class _$WebviewConfigCopyWithImpl<$Res, $Val extends WebviewConfig>
    implements $WebviewConfigCopyWith<$Res> {
  _$WebviewConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebviewConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? title = null,
    Object? enableJavaScript = null,
    Object? enableDomStorage = null,
    Object? enableZoom = null,
  }) {
    return _then(
      _value.copyWith(
            url: null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                      as String,
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            enableJavaScript: null == enableJavaScript
                ? _value.enableJavaScript
                : enableJavaScript // ignore: cast_nullable_to_non_nullable
                      as bool,
            enableDomStorage: null == enableDomStorage
                ? _value.enableDomStorage
                : enableDomStorage // ignore: cast_nullable_to_non_nullable
                      as bool,
            enableZoom: null == enableZoom
                ? _value.enableZoom
                : enableZoom // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WebviewConfigImplCopyWith<$Res>
    implements $WebviewConfigCopyWith<$Res> {
  factory _$$WebviewConfigImplCopyWith(
    _$WebviewConfigImpl value,
    $Res Function(_$WebviewConfigImpl) then,
  ) = __$$WebviewConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String url,
    String title,
    bool enableJavaScript,
    bool enableDomStorage,
    bool enableZoom,
  });
}

/// @nodoc
class __$$WebviewConfigImplCopyWithImpl<$Res>
    extends _$WebviewConfigCopyWithImpl<$Res, _$WebviewConfigImpl>
    implements _$$WebviewConfigImplCopyWith<$Res> {
  __$$WebviewConfigImplCopyWithImpl(
    _$WebviewConfigImpl _value,
    $Res Function(_$WebviewConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WebviewConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? url = null,
    Object? title = null,
    Object? enableJavaScript = null,
    Object? enableDomStorage = null,
    Object? enableZoom = null,
  }) {
    return _then(
      _$WebviewConfigImpl(
        url: null == url
            ? _value.url
            : url // ignore: cast_nullable_to_non_nullable
                  as String,
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        enableJavaScript: null == enableJavaScript
            ? _value.enableJavaScript
            : enableJavaScript // ignore: cast_nullable_to_non_nullable
                  as bool,
        enableDomStorage: null == enableDomStorage
            ? _value.enableDomStorage
            : enableDomStorage // ignore: cast_nullable_to_non_nullable
                  as bool,
        enableZoom: null == enableZoom
            ? _value.enableZoom
            : enableZoom // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc

class _$WebviewConfigImpl implements _WebviewConfig {
  const _$WebviewConfigImpl({
    required this.url,
    this.title = '',
    this.enableJavaScript = true,
    this.enableDomStorage = true,
    this.enableZoom = false,
  });

  @override
  final String url;
  @override
  @JsonKey()
  final String title;
  @override
  @JsonKey()
  final bool enableJavaScript;
  @override
  @JsonKey()
  final bool enableDomStorage;
  @override
  @JsonKey()
  final bool enableZoom;

  @override
  String toString() {
    return 'WebviewConfig(url: $url, title: $title, enableJavaScript: $enableJavaScript, enableDomStorage: $enableDomStorage, enableZoom: $enableZoom)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebviewConfigImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.enableJavaScript, enableJavaScript) ||
                other.enableJavaScript == enableJavaScript) &&
            (identical(other.enableDomStorage, enableDomStorage) ||
                other.enableDomStorage == enableDomStorage) &&
            (identical(other.enableZoom, enableZoom) ||
                other.enableZoom == enableZoom));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    url,
    title,
    enableJavaScript,
    enableDomStorage,
    enableZoom,
  );

  /// Create a copy of WebviewConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebviewConfigImplCopyWith<_$WebviewConfigImpl> get copyWith =>
      __$$WebviewConfigImplCopyWithImpl<_$WebviewConfigImpl>(this, _$identity);
}

abstract class _WebviewConfig implements WebviewConfig {
  const factory _WebviewConfig({
    required final String url,
    final String title,
    final bool enableJavaScript,
    final bool enableDomStorage,
    final bool enableZoom,
  }) = _$WebviewConfigImpl;

  @override
  String get url;
  @override
  String get title;
  @override
  bool get enableJavaScript;
  @override
  bool get enableDomStorage;
  @override
  bool get enableZoom;

  /// Create a copy of WebviewConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebviewConfigImplCopyWith<_$WebviewConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
