import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/features/contact/models/address_book_model.dart';

class ContactService {
  final ApiService _apiService = ApiService();

  Future<AddressBookResponseModel> getAddressBook() async {
    try {
      var response = await _apiService.getAddressBookFull();
      // 转换数据格式以匹配新的模型结构
      List<DeptModel> deptModels = [];
      if (response['deptModels'] != null) {
        for (var deptData in response['deptModels']) {
          deptModels.add(DeptModel.fromJson(deptData));
        }
      }
      return AddressBookResponseModel(
        code: 1,
        data: deptModels,
      );
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