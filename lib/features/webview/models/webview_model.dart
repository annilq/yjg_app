import 'package:freezed_annotation/freezed_annotation.dart';

part 'webview_model.freezed.dart';

@freezed
class WebviewConfig with _$WebviewConfig {
  const factory WebviewConfig({
    required String url,
    @Default('') String title,
    @Default(true) bool enableJavaScript,
    @Default(true) bool enableDomStorage,
    @Default(false) bool enableZoom,
  }) = _WebviewConfig;
}

