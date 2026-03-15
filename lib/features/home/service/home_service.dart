import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/features/home/models/remind_model.dart';

class HomeService {
  final ApiService _apiService = ApiService();

  Future<MainRemindsResponseModel> getMainReminds() async {
    try {
      var response = await _apiService.getMainReminds();
      return MainRemindsResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<int> getWorkflowBacklogCount() async {
    try {
      return await _apiService.getWorkflowBacklogCount();
    } catch (e) {
      rethrow;
    }
  }
}