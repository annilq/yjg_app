import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/features/webview/service/webview_service.dart';
import 'package:flutter_app/features/webview/models/webview_model.dart';

final webviewServiceProvider = Provider<WebviewService>((ref) {
  return WebviewService();
});

final webviewProvider = AsyncNotifierProviderFamily<WebviewNotifier, WebviewConfig, String>(
  WebviewNotifier.new,
);

class WebviewNotifier extends FamilyAsyncNotifier<WebviewConfig, String> {
  late final WebviewService _webviewService;
  late final String _url;

  @override
  Future<WebviewConfig> build(String url) async {
    _webviewService = ref.read(webviewServiceProvider);
    _url = url;
    
    final config = await _webviewService.getWebviewConfig(url);
    return WebviewConfig(
      url: url,
      title: config['title'] ?? '',
      enableJavaScript: config['enableJavaScript'] ?? true,
      enableDomStorage: config['enableDomStorage'] ?? true,
      enableZoom: config['enableZoom'] ?? false,
    );
  }

  Future<bool> shouldInterceptRequest(String url) async {
    return await _webviewService.shouldInterceptRequest(url);
  }
}
