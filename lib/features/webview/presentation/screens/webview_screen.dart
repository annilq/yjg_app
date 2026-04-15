import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/shared/widgets/snackbar_helper.dart';
import 'package:flutter_app/features/webview/presentation/widgets/js_interface_bridge.dart';

class WebviewScreen extends ConsumerStatefulWidget {
  final Map<String, dynamic>? params;

  const WebviewScreen({
    super.key,
    this.params,
  });

  @override
  ConsumerState<WebviewScreen> createState() => _WebviewScreenState();
}

class _WebviewScreenState extends ConsumerState<WebviewScreen> {
  late final WebViewController _controller;
  JsInterfaceBridge? _jsBridge;
  bool _isLoading = true;
  double _loadingProgress = 0.0;
  bool _isTestMode = false;
  final GlobalKey<ScaffoldMessengerState> _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    final params = widget.params ?? {};
    _isTestMode = params['test'] == true || params['test'] == 'true';
    _initWebViewController();
  }

  void _initWebViewController() {
    _controller = WebViewController();

    _jsBridge = JsInterfaceBridge(
      controller: _controller,
    );

    _jsBridge!.init().then((_) {
      _setupNavigationDelegate();
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _setupJsBridgeCallbacks();
      });
      if (_isTestMode) {
        _loadTestHtml();
      } else {
        _loadUrl();
      }
    });
  }

  void _setupNavigationDelegate() {
    _controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    _controller.setNavigationDelegate(
      NavigationDelegate(
        onPageStarted: (String url) {
          setState(() {
            _isLoading = true;
            _loadingProgress = 0.0;
          });
        },
        onProgress: (int progress) {
          setState(() {
            _loadingProgress = progress / 100.0;
          });
        },
        onPageFinished: (String url) async {
          setState(() {
            _isLoading = false;
          });
          await _reInjectJsInterface();
        },
        onNavigationRequest: (NavigationRequest request) {
          return NavigationDecision.navigate;
        },
      ),
    );
  }

  Future<void> _reInjectJsInterface() async {
    if (_jsBridge != null) {
      await _jsBridge!.injectJsInterface();
    }
  }

  void _setupJsBridgeCallbacks() {
    if (_jsBridge == null) return;
    _jsBridge!.onClose = _handleClose;
    _jsBridge!.onPhotoPreview = _handlePhotoPreview;
    _jsBridge!.onOpenUrl = _handleOpenUrl;
    _jsBridge!.onAttachPreview = _handleAttachPreview;
    _jsBridge!.onChoosePhoto = _handleChoosePhoto;
    _jsBridge!.onConfirm = _handleConfirm;
    _jsBridge!.onAlert = _handleAlert;
    _jsBridge!.onUpdateProcess = _handleUpdateProcess;
    _jsBridge!.onLogin = _handleLogin;
  }

  Future<void> _loadTestHtml() async {
    try {
      final htmlString = await rootBundle.loadString('assets/www/index.html');
      await _controller.loadHtmlString(htmlString);
    } catch (e) {
      debugPrint('加载测试 HTML 失败: $e');
    }
  }

  void _handleClose() {
    if (mounted) {
      Navigator.of(context).pop();
    }
  }

  void _handlePhotoPreview(List<String> urls, int index) {
    _showSnackBar('图片预览: ${urls.length} 张图片');
  }

  void _handleOpenUrl(String url) {
    _showSnackBar('打开外部链接: $url');
  }

  void _handleAttachPreview(String url) {
    _showSnackBar('附件预览: $url');
  }

  void _handleChoosePhoto(int num, String type) {
    _showSnackBar('选择图片: $num 张, 类型: $type');
  }

  void _handleConfirm(String title, String info) {
    _showSnackBar('确认框: $title - $info');
  }

  void _handleAlert(String title, String info) {
    _showSnackBar('提示框: $title - $info');
  }

  void _handleUpdateProcess() {
    _controller.reload();
  }

  void _handleLogin() {
    _showSnackBar('调用登录');
  }

  void _showSnackBar(String message) {
    if (mounted) {
      SnackBarHelper.showSnackBarWithKey(
        _scaffoldMessengerKey,
        message,
      );
    }
  }

  Future<void> _loadUrl() async {
    final params = widget.params ?? {};
    String url = params['url'] ?? '';
    Map<String, dynamic> data = params['data'] ?? {};
    String formKey = params['formKey'] ?? '';
    String processType = params['processType'] ?? '';

    String fullUrl = url;
    if (fullUrl.isNotEmpty) {
      if (!fullUrl.startsWith('http://') && !fullUrl.startsWith('https://')) {
        fullUrl = 'https://$fullUrl';
      }
      if (!fullUrl.contains('?')) {
        fullUrl += '?';
      } else {
        fullUrl += '&';
      }
      fullUrl += 'formKey=$formKey&processType=$processType&id=${data['id'] ?? ''}';
    }

    if (fullUrl.isNotEmpty) {
      try {
        await _controller.loadRequest(Uri.parse(fullUrl));
      } catch (e) {
        debugPrint('加载 URL 失败: $e, URL: $fullUrl');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final params = widget.params ?? {};
    String url = params['url'] ?? '';
    String title = _isTestMode ? '接口测试' : (params['title'] ?? '详情');

    return ScaffoldMessenger(
      key: _scaffoldMessengerKey,
      child: Scaffold(
        appBar: AppBarComponent(
          title: title,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => _controller.reload(),
            ),
          ],
        ),
        body: url.isEmpty && !_isTestMode
            ? const Center(child: Text('无效的URL'))
            : Stack(
                children: [
                  WebViewWidget(controller: _controller),
                  if (_isLoading)
                    LinearProgressIndicator(
                      value: _loadingProgress,
                      backgroundColor: Colors.grey[200],
                      valueColor: AlwaysStoppedAnimation<Color>(
                        Theme.of(context).primaryColor,
                      ),
                    ),
                ],
              ),
      ),
    );
  }
}
