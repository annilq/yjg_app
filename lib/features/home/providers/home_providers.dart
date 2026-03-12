import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/features/home/service/home_service.dart';
import 'package:flutter_app/features/home/models/remind_model.dart';
import 'package:flutter_app/features/home/models/address_book_model.dart';

final homeServiceProvider = Provider<HomeService>((ref) {
  return HomeService();
});

final homeScreenProvider = NotifierProvider<HomeScreenNotifier, HomeScreenState>(
  HomeScreenNotifier.new,
);

class HomeScreenState {
  final List<RemindModel> reminds;
  final int backlogCount;
  final bool isLoading;
  final String? error;

  HomeScreenState({
    this.reminds = const [],
    this.backlogCount = 0,
    this.isLoading = true,
    this.error,
  });

  HomeScreenState copyWith({
    List<RemindModel>? reminds,
    int? backlogCount,
    bool? isLoading,
    String? error,
  }) {
    return HomeScreenState(
      reminds: reminds ?? this.reminds,
      backlogCount: backlogCount ?? this.backlogCount,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class HomeScreenNotifier extends Notifier<HomeScreenState> {
  @override
  HomeScreenState build() {
    // 先返回初始状态
    final initialState = HomeScreenState();
    // 然后在微任务中加载数据，确保状态已初始化
    Future.microtask(() => loadData());
    return initialState;
  }

  Future<void> loadData() async {
    try {
      final homeService = ref.read(homeServiceProvider);
      
      final remindsResponse = await homeService.getMainReminds();
      final backlogCount = await homeService.getWorkflowBacklogCount();
      
      state = state.copyWith(
        reminds: remindsResponse.remindModels ?? [],
        backlogCount: backlogCount,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '加载数据失败: $e',
      );
    }
  }
}

final addressBookProvider = NotifierProvider<AddressBookNotifier, AddressBookState>(
  AddressBookNotifier.new,
);

class AddressBookState {
  final List<ContactModel> frequentContacts;
  final List<DeptModel> departments;
  final bool isLoading;
  final String? error;

  AddressBookState({
    this.frequentContacts = const [],
    this.departments = const [],
    this.isLoading = true,
    this.error,
  });

  AddressBookState copyWith({
    List<ContactModel>? frequentContacts,
    List<DeptModel>? departments,
    bool? isLoading,
    String? error,
  }) {
    return AddressBookState(
      frequentContacts: frequentContacts ?? this.frequentContacts,
      departments: departments ?? this.departments,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AddressBookNotifier extends Notifier<AddressBookState> {
  @override
  AddressBookState build() {
    // 先返回初始状态
    final initialState = AddressBookState();
    // 然后在微任务中加载数据，确保状态已初始化
    Future.microtask(() => loadData());
    return initialState;
  }

  Future<void> loadData() async {
    try {
      final homeService = ref.read(homeServiceProvider);
      
      final frequentResponse = await homeService.getAddressBookFrequent();
      final fullResponse = await homeService.getAddressBookFull();
      
      state = state.copyWith(
        frequentContacts: frequentResponse.contactModels ?? [],
        departments: fullResponse.deptModels ?? [],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '加载数据失败: $e',
      );
    }
  }
}

final contactDetailProvider = NotifierProvider.family<ContactDetailNotifier, ContactDetailState, String>(
  ContactDetailNotifier.new,
);

class ContactDetailState {
  final ContactModel? contact;
  final bool isLoading;
  final bool isFrequent;
  final String? error;

  ContactDetailState({
    this.contact,
    this.isLoading = true,
    this.isFrequent = false,
    this.error,
  });

  ContactDetailState copyWith({
    ContactModel? contact,
    bool? isLoading,
    bool? isFrequent,
    String? error,
  }) {
    return ContactDetailState(
      contact: contact ?? this.contact,
      isLoading: isLoading ?? this.isLoading,
      isFrequent: isFrequent ?? this.isFrequent,
      error: error ?? this.error,
    );
  }
}

class ContactDetailNotifier extends FamilyNotifier<ContactDetailState, String> {
  late final HomeService _homeService;

  @override
  ContactDetailState build(String userId) {
    _homeService = ref.read(homeServiceProvider);
    // 先返回初始状态
    final initialState = ContactDetailState();
    // 然后在微任务中加载数据，确保状态已初始化
    Future.microtask(() => loadContactDetail(userId));
    return initialState;
  }

  Future<void> loadContactDetail(String userId) async {
    try {
      final response = await _homeService.getAddressBookUserDetail(userId);
      final contact = ContactModel.fromJson(response);
      state = state.copyWith(
        contact: contact,
        isFrequent: contact.isFrequent ?? false,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: '加载联系人详情失败: $e',
      );
    }
  }

  Future<void> toggleFrequent() async {
    try {
      await _homeService.setAddressBookContactFrequent(arg, !state.isFrequent);
      state = state.copyWith(
        isFrequent: !state.isFrequent,
      );
    } catch (e) {
      throw Exception('设置常用联系人失败: $e');
    }
  }
}