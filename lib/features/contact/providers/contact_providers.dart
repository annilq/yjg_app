import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/features/contact/service/contact_service.dart';
import 'package:flutter_app/features/contact/models/address_book_model.dart';

final contactServiceProvider = Provider<ContactService>((ref) {
  return ContactService();
});

final addressBookProvider = AsyncNotifierProvider<AddressBookNotifier, AddressBookData>(
  AddressBookNotifier.new,
);

class AddressBookData {
  final List<ContactModel> frequentContacts;
  final List<DeptModel> departments;

  AddressBookData({
    required this.frequentContacts,
    required this.departments,
  });
}

class AddressBookNotifier extends AsyncNotifier<AddressBookData> {
  @override
  Future<AddressBookData> build() async {
    final contactService = ref.read(contactServiceProvider);
    
    final frequentResponse = await contactService.getAddressBookFrequent();
    final fullResponse = await contactService.getAddressBookFull();
    
    return AddressBookData(
      frequentContacts: frequentResponse.contactModels ?? [],
      departments: fullResponse.deptModels ?? [],
    );
  }
}

final contactDetailProvider = AsyncNotifierProvider.family<ContactDetailNotifier, ContactDetailData, String>(
  ContactDetailNotifier.new,
);

class ContactDetailData {
  final ContactModel contact;
  final bool isFrequent;

  ContactDetailData({
    required this.contact,
    required this.isFrequent,
  });
}

class ContactDetailNotifier extends FamilyAsyncNotifier<ContactDetailData, String> {
  late final ContactService _contactService;

  @override
  Future<ContactDetailData> build(String userId) async {
    _contactService = ref.read(contactServiceProvider);
    
    final response = await _contactService.getAddressBookUserDetail(userId);
    final contact = ContactModel.fromJson(response);
    
    return ContactDetailData(
      contact: contact,
      isFrequent: contact.isFrequent ?? false,
    );
  }

  Future<void> toggleFrequent() async {
    final currentState = await future;
    try {
      await _contactService.setAddressBookContactFrequent(arg, !currentState.isFrequent);
      // 重新加载数据以更新状态
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('设置常用联系人失败: $e');
    }
  }
}