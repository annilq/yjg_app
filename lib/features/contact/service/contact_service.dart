import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/features/contact/models/address_book_model.dart';

class ContactService {
  final ApiService _apiService = ApiService();

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