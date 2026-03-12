import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/features/notices/service/notices_service.dart';
import 'package:flutter_app/features/notices/models/notice_model.dart';

final noticesServiceProvider = Provider<NoticesService>((ref) {
  return NoticesService();
});

final noticeProvider = AsyncNotifierProvider<NoticeNotifier, NoticeListData>(
  NoticeNotifier.new,
);

class NoticeNotifier extends AsyncNotifier<NoticeListData> {
  late final NoticesService _noticesService;

  @override
  Future<NoticeListData> build() async {
    _noticesService = ref.read(noticesServiceProvider);
    return await loadNotices();
  }

  Future<NoticeListData> loadNotices({String? keyword}) async {
    final response = await _noticesService.getNotices(keyword: keyword);
    final remindModels = response['remindModels'] ?? [];
    
    final notices = List<NoticeModel>.from(remindModels.map((item) => NoticeModel.fromJson(item)));
    
    return NoticeListData(notices: notices);
  }

  Future<void> refresh({String? keyword}) async {
    state = await AsyncValue.guard(() => loadNotices(keyword: keyword));
  }
}

