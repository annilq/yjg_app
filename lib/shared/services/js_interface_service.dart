import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:file_selector/file_selector.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class JsInterfaceService {
  static final JsInterfaceService _instance = JsInterfaceService._internal();
  factory JsInterfaceService() => _instance;
  JsInterfaceService._internal();

  static const MethodChannel _channel = MethodChannel('com.jg.app/jsinterface');

  Function(String callbackId, String result)? onNativeCallback;

  void init() {
    _channel.setMethodCallHandler(_handleMethodCall);
  }

  Future<dynamic> _handleMethodCall(MethodCall call) async {
    switch (call.method) {
      case 'NativeCallback':
        final callbackId = call.arguments['callbackId'] as String?;
        final result = call.arguments['result'] as String?;
        if (callbackId != null && result != null && onNativeCallback != null) {
          onNativeCallback!(callbackId, result);
        }
        break;
    }
  }

  Future<void> close() async {
    try {
      await _channel.invokeMethod('close');
    } catch (e) {
      print('close error: $e');
    }
  }

  Future<Map<String, dynamic>> getUserInfo() async {
    try {
      final result = await _channel.invokeMethod('getUserInfo');
      if (result != null && result is String) {
        return json.decode(result);
      }
    } catch (e) {
      print('getUserInfo error: $e');
    }
    return _getUserInfoFromLocal();
  }

  Future<Map<String, dynamic>> _getUserInfoFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return {
      'userId': prefs.getInt('userId'),
      'userName': prefs.getString('userName'),
      'realName': prefs.getString('realName'),
      'deptId': prefs.getInt('deptId'),
      'deptName': prefs.getString('deptName'),
      'phone': prefs.getString('phone'),
      'email': prefs.getString('email'),
    };
  }

  Future<Map<String, dynamic>> getSign() async {
    try {
      print('getSign result');
      final result = await _channel.invokeMethod('getSign');
      if (result != null && result is String) {
        return json.decode(result);
      }
    } catch (e) {
      print('getSign error: $e');
    }
    return _getSignFromLocal();
  }

  Future<Map<String, dynamic>> _getSignFromLocal() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    String? lastUpdateTime = prefs.getString('lastUpdateTime');
    if (userId == null || lastUpdateTime == null) {
      return {};
    }
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    return {
      '_uid': userId,
      '_timestamp': timestamp,
      '_signature': '',
    };
  }

  String getSignStr(Map<String, dynamic> sign) {
    final query = StringBuffer();
    sign.forEach((key, value) {
      if (value != null) {
        query.write('$key=${Uri.encodeComponent(value.toString())}&');
      }
    });
    final result = query.toString();
    return result.isNotEmpty ? result.substring(0, result.length - 1) : result;
  }

  Future<Map<String, dynamic>> getUrlParams(Map<String, dynamic>? initialParams) async {
    try {
      final result = await _channel.invokeMethod('getUrlParams');
      if (result != null && result is String) {
        return json.decode(result);
      }
    } catch (e) {
      print('getUrlParams error: $e');
    }
    return initialParams ?? {};
  }

  Future<void> photoPreview({
    required List<String> urls,
    int index = 0,
    bool showbtn = true,
  }) async {
    try {
      await _channel.invokeMethod('photoPreview', {
        'data': urls,
        'index': index,
        'showbtn': showbtn,
      });
    } catch (e) {
      print('photoPreview error: $e');
    }
  }

  Future<void> openUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print('openUrl error: $e');
    }
  }

  Future<void> attachPreview(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      print('attachPreview error: $e');
    }
  }

  Future<String?> choosePhoto({
    int num = 1,
    String type = 'album',
    Map<String, dynamic>? data,
  }) async {
    debugPrint('choosePhoto 开始执行: num=$num, type=$type');
    try {
      if (type == 'camera') {
        final ImagePicker picker = ImagePicker();
        debugPrint('选择相机');
        final XFile? image = await picker.pickImage(source: ImageSource.camera);
        if (image != null) {
          return image.path;
        }
        return null;
      } else {
        debugPrint('尝试使用 file_selector');
        try {
          final XTypeGroup typeGroup = XTypeGroup(
            label: 'images',
            extensions: ['jpg', 'jpeg', 'png', 'gif', 'webp', 'heic'],
          );
          
          debugPrint('打开文件选择器');
          if (num == 1) {
            final XFile? file = await openFile(acceptedTypeGroups: [typeGroup]);
            debugPrint('选择了文件: ${file?.path}');
            return file?.path;
          } else {
            final List<XFile> files = await openFiles(acceptedTypeGroups: [typeGroup]);
            debugPrint('选择了 ${files.length} 个文件');
            if (files.isEmpty) return null;
            if (files.length == 1) {
              return files.first.path;
            }
            return json.encode(files.map((e) => e.path).toList());
          }
        } catch (e) {
          debugPrint('file_selector 失败: $e, 尝试 image_picker');
          final ImagePicker picker = ImagePicker();
          final List<XFile> images = await picker.pickMultiImage();
          debugPrint('image_picker 选择了 ${images.length} 张');
          if (images.isEmpty) return null;
          if (images.length == 1) return images.first.path;
          return json.encode(images.map((e) => e.path).toList());
        }
      }
    } catch (e) {
      debugPrint('choosePhoto 错误: $e');
      return null;
    }
  }

  Future<bool> confirm({
    required String title,
    required String info,
  }) async {
    try {
      final result = await _channel.invokeMethod('confirm', {
        'title': title,
        'info': info,
      });
      return result == true;
    } catch (e) {
      print('confirm error: $e');
      return false;
    }
  }

  Future<void> beep() async {
    try {
      await _channel.invokeMethod('beep');
    } catch (e) {
      print('beep error: $e');
    }
  }

  Future<void> alert({
    required String title,
    required String info,
  }) async {
    try {
      await _channel.invokeMethod('alert', {
        'title': title,
        'info': info,
      });
    } catch (e) {
      print('alert error: $e');
    }
  }

  Future<void> updateProcess() async {
    try {
      await _channel.invokeMethod('updateProcess');
    } catch (e) {
      print('updateProcess error: $e');
    }
  }

  Future<void> login() async {
    try {
      await _channel.invokeMethod('login');
    } catch (e) {
      print('login error: $e');
    }
  }
}
