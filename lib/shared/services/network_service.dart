import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/core/constants/app_constants.dart';
import 'package:flutter_app/core/utils/encryption_util.dart';
import 'package:flutter_app/core/errors/exceptions.dart';

class NetworkService {
  static final NetworkService _instance = NetworkService._internal();
  factory NetworkService() => _instance;
  late Dio _dio;
  bool _netStatus = true;

  NetworkService._internal() {
    _dio = Dio(
      BaseOptions(
        baseUrl: AppConstants.API_BASE_URL,
        connectTimeout: Duration(seconds: AppConstants.CONNECT_TIMEOUT),
        receiveTimeout: Duration(seconds: AppConstants.RECEIVE_TIMEOUT),
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      ),
    );
    _addInterceptors();
    _monitorNetworking();
  }

  void _addInterceptors() {
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) {
        print('[Request] URL: ${options.uri}');
        print('[Request] params: ${options.data}');
        handler.next(options);
      },
      onResponse: (response, handler) {
        print('[Response] Data: ${response.data}');
        handler.next(response);
      },
      onError: (error, handler) {
        print('[Error] ${error.message}');
        handler.next(error);
      },
    ));
  }

  Future<Response> post(String url, Map<String, dynamic> parameters) async {
    try {
      Options? options;
      if (parameters.containsKey('POSTMETHOD') && parameters['POSTMETHOD'] == 'JSON') {
        options = Options(headers: {'Content-Type': 'application/json'});
      } else {
        options = Options(headers: {'Content-Type': 'application/x-www-form-urlencoded'});
      }

      Response response = await _dio.post(url, data: parameters, options: options);

      Map<String, dynamic> responseData;
      if (response.data is String) {
        responseData = json.decode(response.data);
      } else if (response.data is Map) {
        responseData = response.data;
      } else {
        throw ServerException('无效的响应格式');
      }

      ResponseModel<dynamic> responseModel = ResponseModel.fromJson(responseData);

      if (parameters.containsKey('POSTMETHOD') && parameters['POSTMETHOD'] == 'JSON') {
        if (responseModel.code == 0) {
          return Response(
            requestOptions: response.requestOptions,
            data: responseModel.data,
            statusCode: response.statusCode,
          );
        } else {
          throw ServerException(
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
        throw ServerException(
          responseModel.info.isNotEmpty ? responseModel.info : '服务器出错',
        );
      }
    } catch (e) {
      if (!_netStatus) {
        throw NetworkException('当前网络不可用');
      } else {
        rethrow;
      }
    }
  }

  Future<Map<String, dynamic>?> getAuthenticationInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    String? lastUpdateTime = prefs.getString('lastUpdateTime');

    if (userId == null || lastUpdateTime == null) {
      return null;
    }

    int currentInterval = DateTime.now().millisecondsSinceEpoch;
    String sha1Authentication = EncryptionUtil.generateSHA1(
      '$lastUpdateTime$userId$currentInterval',
    );

    return {
      '_uid': userId,
      '_timestamp': currentInterval,
      '_signature': sha1Authentication,
    };
  }

  void _monitorNetworking() async {
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

  Future<String> uploadImage(File image, String url) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int? userId = prefs.getInt('userId');
    String? lastUpdateTime = prefs.getString('lastUpdateTime');

    int currentInterval = DateTime.now().millisecondsSinceEpoch;
    String sha1Authentication = EncryptionUtil.generateSHA1(
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
      throw ServerException('无效的响应格式');
    }
    ResponseModel<dynamic> responseModel = ResponseModel.fromJson(responseData);
    if (responseModel.code == 1) {
      Map<String, dynamic> data = responseModel.data as Map<String, dynamic>;
      return data['imgName'] as String;
    } else {
      throw ServerException(
        responseModel.info.isNotEmpty ? responseModel.info : '上传失败',
      );
    }
  }
}

class ResponseModel<T> {
  final int code;
  final String info;
  final T? data;

  ResponseModel({required this.code, required this.info, this.data});

  factory ResponseModel.fromJson(Map<String, dynamic> json) {
    return ResponseModel(
      code: json['code'] ?? 0,
      info: json['info'] ?? '',
      data: json['data'] ?? json['resp'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'code': code, 'info': info, 'data': data};
  }
}
