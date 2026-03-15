import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/features/contact/service/contact_service.dart';
import 'package:flutter_app/features/contact/models/address_book_model.dart';

final contactServiceProvider = Provider<ContactService>((ref) {
  return ContactService();
});

final addressBookProvider = AsyncNotifierProvider<AddressBookNotifier, List<DeptModel>>(
  AddressBookNotifier.new,
);

class AddressBookNotifier extends AsyncNotifier<List<DeptModel>> {
  @override
  Future<List<DeptModel>> build() async {
    final contactService = ref.read(contactServiceProvider);
    
    final response = await contactService.getAddressBook();
    return response.data ?? [];
  }
}

final contactDetailProvider = AsyncNotifierProvider.family<ContactDetailNotifier, ContactModel, String>(
  ContactDetailNotifier.new,
);

class ContactDetailNotifier extends FamilyAsyncNotifier<ContactModel, String> {
  late final ContactService _contactService;

  @override
  Future<ContactModel> build(String userId) async {
    _contactService = ref.read(contactServiceProvider);
    
    final response = await _contactService.getAddressBookUserDetail(userId);
    return ContactModel.fromJson(response);
  }

  Future<void> toggleFrequent() async {
    final currentState = await future;
    try {
      await _contactService.setAddressBookContactFrequent(arg, !(currentState.fc ?? false));
      // 重新加载数据以更新状态
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('设置常用联系人失败: $e');
    }
  }
}