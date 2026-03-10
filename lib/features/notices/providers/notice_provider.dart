import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/network/api_service.dart';

class NoticeState {
  final List<dynamic> items;
  final bool isLoading;
  final String? keyword;

  const NoticeState({
    this.items = const [],
    this.isLoading = false,
    this.keyword,
  });

  NoticeState copyWith({
    List<dynamic>? items,
    bool? isLoading,
    String? keyword,
  }) {
    return NoticeState(
      items: items ?? this.items,
      isLoading: isLoading ?? this.isLoading,
      keyword: keyword ?? this.keyword,
    );
  }
}

class NoticeNotifier extends StateNotifier<NoticeState> {
  NoticeNotifier() : super(const NoticeState());

  Future<void> loadNotices({String? keyword, bool refresh = false}) async {
    if (state.isLoading) return;

    if (refresh) {
      state = state.copyWith(items: [], keyword: keyword);
    } else {
      state = state.copyWith(isLoading: true, keyword: keyword);
    }

    try {
      var response = await ApiService().getMainReminds();
      final newItems = response['remindModels'] ?? [];
      state = state.copyWith(
        items: refresh ? newItems : [...state.items, ...newItems],
        isLoading: false,
      );
    } catch (e) {
      print('加载提醒列表失败: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> refresh() async {
    await loadNotices(keyword: state.keyword, refresh: true);
  }

  Future<void> loadMore() async {
    await loadNotices(keyword: state.keyword, refresh: false);
  }
}

final noticeProvider = StateNotifierProvider<NoticeNotifier, NoticeState>(
  (ref) => NoticeNotifier(),
);
