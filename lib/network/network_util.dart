import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NetworkUtil {
  static const String BASE_URL = 'http://api.jianguanoa.com/1.0/';
  static const String UC_BASE_URL = 'http://uc.jianguanoa.com/';

  static final NetworkUtil _instance = NetworkUtil._internal();
  factory NetworkUtil() => _instance;
  late Dio _dio;
  bool _netStatus = true;

  NetworkUtil._internal() {
    _dio = Dio(BaseOptions(
      baseUrl: BASE_URL,
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 10),
      headers: {
        'Content-Type': 'application/json',
      },
    ));
    _monitorNetworking();
  }

  Future<Response> post(String url, Map<String, dynamic> parameters) async {
    try {
      Response response = await _dio.post(url, data: parameters);
      print('[Request] URL: ${_dio.options.baseUrl}$url');
      print('[Request] params: $parameters');
      print('[Response] Data: ${response.data}');

      if (response.data is Map) {
        Map<String, dynamic> responseDict = response.data;
        int code = responseDict['code'] ?? 0;

        if (parameters.containsKey('POSTMETHOD') && parameters['POSTMETHOD'] == 'JSON') {
          if (code == 0) {
            return Response(
              requestOptions: response.requestOptions,
              data: responseDict['resp'],
              statusCode: response.statusCode,
            );
          } else {
            String info = responseDict['info'] ?? '服务器出错';
            throw Exception(info);
          }
        }

        if (code == 1) {
          return Response(
            requestOptions: response.requestOptions,
            data: responseDict['data'],
            statusCode: response.statusCode,
          );
        } else {
          String info = responseDict['info'] ?? '服务器出错';
          throw Exception(info);
        }
      } else {
        throw Exception('无效的响应格式');
      }
    } catch (e) {
      if (!_netStatus) {
        throw Exception('当前网络不可用');
      } else {
        throw e;
      }
    }
  }

  Future<Map<String, dynamic>?> getAuthenticationInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? lastUpdateTime = prefs.getString('lastUpdateTime');

    if (userId == null || lastUpdateTime == null) {
      return null;
    }

    int currentInterval = DateTime.now().millisecondsSinceEpoch;
    String sha1Authentication = generateSHA1('$lastUpdateTime$userId$currentInterval');

    return {
      '_uid': userId,
      '_timestamp': currentInterval,
      '_signature': sha1Authentication,
    };
  }

  String generateSHA1(String input) {
    var bytes = utf8.encode(input);
    var digest = sha1.convert(bytes);
    return digest.toString();
  }

  void _monitorNetworking() async {
    // 简单的网络状态监测
    try {
      final result = await InternetAddress.lookup('baidu.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        _netStatus = true;
      } else {
        _netStatus = false;
      }
    } on SocketException catch (_) {
      _netStatus = false;
    }
  }

  // 上传图片
  Future<String> uploadImage(File image, String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? userId = prefs.getString('userId');
    String? lastUpdateTime = prefs.getString('lastUpdateTime');

    int currentInterval = DateTime.now().millisecondsSinceEpoch;
    String sha1Authentication = generateSHA1('$lastUpdateTime$userId$currentInterval');

    FormData formData = FormData.fromMap({
      '_uid': userId,
      '_timestamp': currentInterval,
      '_signature': sha1Authentication,
      'img': await MultipartFile.fromFile(image.path, filename: '${DateTime.now().millisecondsSinceEpoch}.jpg'),
    });

    Response response = await _dio.post(url, data: formData);
    if (response.data['code'] == 1) {
      return response.data['data']['imgName'];
    } else {
      throw Exception(response.data['info'] ?? '上传失败');
    }
  }
}
