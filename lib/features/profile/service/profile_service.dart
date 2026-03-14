import 'dart:io';
import 'package:flutter_app/network/api_service.dart';

class ProfileService {
  final ApiService _apiService;

  ProfileService() : _apiService = ApiService();

  Future<void> clearCache() async {
    await _apiService.cleanMainMenus();
  }

  Future<void> unbind() async {
    await _apiService.unbindWxLogin();
  }

  Future<String> updateAvatar(File image) async {
    return await _apiService.uploadAvatar(image);
  }
}
