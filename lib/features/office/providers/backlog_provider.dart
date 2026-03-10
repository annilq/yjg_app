import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/network/api_service.dart';

class BacklogState {
  final List<dynamic> items;
  final bool isLoading;
  final int currentTabIndex;
  final String? keyword;
  final int page;
  final int rows;

  const BacklogState({
    this.items = const [],
    this.isLoading = false,
    this.currentTabIndex = 0,
    this.keyword,
    this.page = 1,
    this.rows = 10,
  });

  BacklogState copyWith({
    List<dynamic>? items,
    bool? isLoading,
    int? currentTabIndex,
    String? keyword,
    int? page,
    int? rows,
    bool clearItems = false,
  }) {
    return BacklogState(
      items: clearItems ? (items ?? []) : (items ?? this.items),
      isLoading: isLoading ?? this.isLoading,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      keyword: keyword ?? this.keyword,
      page: page ?? this.page,
      rows: rows ?? this.rows,
    );
  }
}

class BacklogNotifier extends StateNotifier<BacklogState> {
  BacklogNotifier() : super(const BacklogState());

  Future<void> loadBacklogList({bool refresh = false}) async {
    if (state.isLoading) return;

    if (refresh) {
      state = state.copyWith(items: [], page: 1, clearItems: true);
    } else {
      state = state.copyWith(isLoading: true);
    }

    try {
      var response = await ApiService().getBacklogList(
        state.currentTabIndex,
        state.keyword,
        state.page,
        state.rows,
      );
      final newItems = response['rows'] ?? [];
      state = state.copyWith(
        items: refresh ? newItems : [...state.items, ...newItems],
        isLoading: false,
      );
    } catch (e) {
      print('加载待办列表失败: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  void onTabChanged(int index) {
    state = state.copyWith(currentTabIndex: index, page: 1, clearItems: true);
    loadBacklogList(refresh: true);
  }

  void onSearch(String keyword) {
    state = state.copyWith(keyword: keyword, page: 1, clearItems: true);
    loadBacklogList(refresh: true);
  }

  Future<void> refresh() async {
    await loadBacklogList(refresh: true);
  }

  Future<void> loadMore() async {
    if (!state.isLoading) {
      state = state.copyWith(page: state.page + 1);
      await loadBacklogList();
    }
  }
}

final backlogProvider = StateNotifierProvider<BacklogNotifier, BacklogState>(
  (ref) => BacklogNotifier(),
);
