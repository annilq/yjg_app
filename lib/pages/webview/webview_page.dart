import 'package:flutter/material.dart';
import 'package:flutter_app/components/app_bar.dart';

class WebviewPage extends StatefulWidget {
  final Map<String, dynamic>? params;

  const WebviewPage({
    Key? key,
    this.params,
  }) : super(key: key);

  @override
  _WebviewPageState createState() => _WebviewPageState();
}

class _WebviewPageState extends State<WebviewPage> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // 模拟加载完成
    Future.delayed(Duration(seconds: 1), () {
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

    // 构建完整的URL
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
      appBar: CustomAppBar(
        title: '详情',
      ),
      body: url.isEmpty
          ? Center(child: Text('无效的URL'))
          : _isLoading
              ? Center(child: CircularProgressIndicator())
              : Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('WebView 功能需要在真实设备上测试'),
                      SizedBox(height: 16),
                      Text('URL: $fullUrl'),
                    ],
                  ),
                ),
    );
  }
}
