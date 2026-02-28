import 'dart:convert';
import 'dart:io';
import 'package:crypto/crypto.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'response_model.dart';

class NetworkUtil {
  static const String BASE_URL = 'http://api.jianguanoa.com/1.0/';
  static const String UC_BASE_URL = 'http://uc.jianguanoa.com/';

  static final NetworkUtil _instance = NetworkUtil._internal();
  factory NetworkUtil() => _instance;
  late Dio _dio;
  bool _netStatus = true;

  NetworkUtil._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: BASE_URL,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      ),
    );
    _monitorNetworking();
  }

  Future<Response> post(String url, Map<String, dynamic> parameters) async {
    try {
      // 根据POSTMETHOD设置Content-Type
      Options? options;
      if (parameters.containsKey('POSTMETHOD') && parameters['POSTMETHOD'] == 'JSON') {
        options = Options(headers: {'Content-Type': 'application/json'});
      } else {
        options = Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'});
      }

      Response response = await _dio.post(url, data: parameters, options: options);
      print('[Request] URL: ${_dio.options.baseUrl}$url');
      print('[Request] params: $parameters');
      print('[Response] Data: ${response.data}');

      Map<String, dynamic> responseData;
      if (response.data is String) {
        responseData = json.decode(response.data);
      } else if (response.data is Map) {
        responseData = response.data;
      } else {
        throw Exception('无效的响应格式');
      }

      ResponseModel<dynamic> responseModel = ResponseModel.fromJson(
        responseData,
      );

      if (parameters.containsKey('POSTMETHOD') &&
          parameters['POSTMETHOD'] == 'JSON') {
        if (responseModel.code == 0) {
          return Response(
            requestOptions: response.requestOptions,
            data: responseModel.data,
            statusCode: response.statusCode,
          );
        } else {
          throw Exception(
            responseModel.info.isNotEmpty ? responseModel.info : '服务器出错',
          );
        }
      }

      if (responseModel.code == 1) {
        return Response(
          requestOptions: response.requestOptions,
          data: responseModel.data,
          statusCode: response.statusCode,
        );
      } else {
        throw Exception(
          responseModel.info.isNotEmpty ? responseModel.info : '服务器出错',
        );
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
    String sha1Authentication = generateSHA1(
      '$lastUpdateTime$userId$currentInterval',
    );

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
    String sha1Authentication = generateSHA1(
      '$lastUpdateTime$userId$currentInterval',
    );

    FormData formData = FormData.fromMap({
      '_uid': userId,
      '_timestamp': currentInterval,
      '_signature': sha1Authentication,
      'img': await MultipartFile.fromFile(
        image.path,
        filename: '${DateTime.now().millisecondsSinceEpoch}.jpg',
      ),
    });

    Response response = await _dio.post(url, data: formData);
    Map<String, dynamic> responseData;
    if (response.data is String) {
      responseData = json.decode(response.data);
    } else if (response.data is Map) {
      responseData = response.data;
    } else {
      throw Exception('无效的响应格式');
    }
    ResponseModel<dynamic> responseModel = ResponseModel.fromJson(responseData);
    if (responseModel.code == 1) {
      Map<String, dynamic> data = responseModel.data as Map<String, dynamic>;
      return data['imgName'] as String;
    } else {
      throw Exception(
        responseModel.info.isNotEmpty ? responseModel.info : '上传失败',
      );
    }
  }
}
