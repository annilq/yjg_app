import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/features/home/service/home_service.dart';
import 'package:flutter_app/features/home/models/remind_model.dart';
import 'package:flutter_app/features/home/models/address_book_model.dart';

final homeServiceProvider = Provider<HomeService>((ref) {
  return HomeService();
});

final homeScreenProvider = AsyncNotifierProvider<HomeScreenNotifier, HomeScreenData>(
  HomeScreenNotifier.new,
);

class HomeScreenData {
  final List<RemindModel> reminds;
  final int backlogCount;

  HomeScreenData({
    required this.reminds,
    required this.backlogCount,
  });
}

class HomeScreenNotifier extends AsyncNotifier<HomeScreenData> {
  @override
  Future<HomeScreenData> build() async {
    final homeService = ref.read(homeServiceProvider);
    
    final remindsResponse = await homeService.getMainReminds();
    final backlogCount = await homeService.getWorkflowBacklogCount();
    
    return HomeScreenData(
      reminds: remindsResponse.remindModels ?? [],
      backlogCount: backlogCount,
    );
  }
}

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
    final homeService = ref.read(homeServiceProvider);
    
    final frequentResponse = await homeService.getAddressBookFrequent();
    final fullResponse = await homeService.getAddressBookFull();
    
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
  late final HomeService _homeService;

  @override
  Future<ContactDetailData> build(String userId) async {
    _homeService = ref.read(homeServiceProvider);
    
    final response = await _homeService.getAddressBookUserDetail(userId);
    final contact = ContactModel.fromJson(response);
    
    return ContactDetailData(
      contact: contact,
      isFrequent: contact.isFrequent ?? false,
    );
  }

  Future<void> toggleFrequent() async {
    final currentState = await future;
    try {
      await _homeService.setAddressBookContactFrequent(arg, !currentState.isFrequent);
      // 重新加载数据以更新状态
      ref.invalidateSelf();
    } catch (e) {
      throw Exception('设置常用联系人失败: $e');
    }
  }
}