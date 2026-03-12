import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/features/home/models/remind_model.dart';
import 'package:flutter_app/features/home/models/address_book_model.dart';

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

  Future<AddressBookFrequentResponseModel> getAddressBookFrequent() async {
    try {
      var response = await _apiService.getAddressBookFrequent();
      return AddressBookFrequentResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<AddressBookFullResponseModel> getAddressBookFull() async {
    try {
      var response = await _apiService.getAddressBookFull();
      return AddressBookFullResponseModel.fromJson(response);
    } catch (e) {
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getAddressBookUserDetail(String userId) async {
    try {
      return await _apiService.getAddressBookUserDetail(userId);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> setAddressBookContactFrequent(String userId, bool isFrequent) async {
    try {
      await _apiService.setAddressBookContactFrequent(userId, isFrequent);
    } catch (e) {
      rethrow;
    }
  }
}