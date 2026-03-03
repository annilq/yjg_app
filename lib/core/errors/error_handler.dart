import 'dart:io';
import 'package:dio/dio.dart';
import 'failures.dart';
import 'exceptions.dart';

class ErrorHandler {
  static Failure handleException(dynamic exception) {
    if (exception is ServerException) {
      return ServerFailure(exception.message, exception.code);
    } else if (exception is NetworkException) {
      return NetworkFailure(exception.message);
    } else if (exception is CacheException) {
      return CacheFailure(exception.message);
    } else if (exception is AuthenticationException) {
      return AuthenticationFailure(exception.message);
    } else if (exception is ValidationException) {
      return ValidationFailure(exception.message);
    } else if (exception is DioException) {
      return _handleDioException(exception);
    } else if (exception is SocketException) {
      return NetworkFailure('网络连接失败');
    } else if (exception is Exception) {
      return UnknownFailure(exception.toString());
    } else {
      return UnknownFailure('未知错误');
    }
  }

  static Failure _handleDioException(DioException exception) {
    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return NetworkFailure('网络连接超时');
      case DioExceptionType.badResponse:
        final statusCode = exception.response?.statusCode;
        final message = exception.response?.data?['info'] ?? '服务器错误';
        if (statusCode == 401) {
          return AuthenticationFailure('未登录或登录已过期');
        } else if (statusCode == 403) {
          return AuthenticationFailure('没有权限');
        } else if (statusCode == 404) {
          return ServerFailure('请求的资源不存在');
        } else if (statusCode != null && statusCode >= 500) {
          return ServerFailure('服务器内部错误');
        } else {
          return ServerFailure(message, statusCode);
        }
      case DioExceptionType.cancel:
        return NetworkFailure('请求已取消');
      case DioExceptionType.connectionError:
        return NetworkFailure('网络连接失败');
      case DioExceptionType.unknown:
        return NetworkFailure('网络错误');
      default:
        return UnknownFailure('未知错误');
    }
  }
}
