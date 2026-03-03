import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';

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
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final params = widget.params ?? {};
    String url = params['url'] ?? '';
    Map<String, dynamic> data = params['data'] ?? {};
    String formKey = params['formKey'] ?? '';
    String processType = params['processType'] ?? '';

    String fullUrl = url;
    if (fullUrl.isNotEmpty) {
      if (!fullUrl.contains('?')) {
        fullUrl += '?';
      } else {
        fullUrl += '&';
      }
      fullUrl += 'formKey=$formKey&processType=$processType&id=${data['id'] ?? ''}';
    }

    return Scaffold(
      appBar: AppBarComponent(
        title: '详情',
      ),
      body: url.isEmpty
          ? const Center(child: Text('无效的URL'))
          : _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('WebView 功能需要在真实设备上测试'),
                      const SizedBox(height: 16),
                      Text('URL: $fullUrl'),
                    ],
                  ),
                ),
    );
  }
}
