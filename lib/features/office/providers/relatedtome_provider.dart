import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/network/api_service.dart';

class RelatedToMeState {
  final List<dynamic> items;
  final bool isLoading;
  final int currentTabIndex;
  final String? keyword;
  final int page;
  final int rows;

  const RelatedToMeState({
    this.items = const [],
    this.isLoading = false,
    this.currentTabIndex = 0,
    this.keyword,
    this.page = 1,
    this.rows = 10,
  });

  RelatedToMeState copyWith({
    List<dynamic>? items,
    bool? isLoading,
    int? currentTabIndex,
    String? keyword,
    int? page,
    int? rows,
    bool clearItems = false,
  }) {
    return RelatedToMeState(
      items: clearItems ? (items ?? []) : (items ?? this.items),
      isLoading: isLoading ?? this.isLoading,
      currentTabIndex: currentTabIndex ?? this.currentTabIndex,
      keyword: keyword ?? this.keyword,
      page: page ?? this.page,
      rows: rows ?? this.rows,
    );
  }
}

class RelatedToMeNotifier extends StateNotifier<RelatedToMeState> {
  RelatedToMeNotifier() : super(const RelatedToMeState());

  Future<void> loadRelatedToMeList({bool refresh = false}) async {
    if (state.isLoading) return;

    if (refresh) {
      state = state.copyWith(items: [], page: 1, clearItems: true);
    } else {
      state = state.copyWith(isLoading: true);
    }

    try {
      var response = await ApiService().getRelatedToMeList(
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
      print('加载我发起的列表失败: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  void onTabChanged(int index) {
    state = state.copyWith(currentTabIndex: index, page: 1, clearItems: true);
    loadRelatedToMeList(refresh: true);
  }

  void onSearch(String keyword) {
    state = state.copyWith(keyword: keyword, page: 1, clearItems: true);
    loadRelatedToMeList(refresh: true);
  }

  Future<void> refresh() async {
    await loadRelatedToMeList(refresh: true);
  }

  Future<void> loadMore() async {
    if (!state.isLoading) {
      state = state.copyWith(page: state.page + 1);
      await loadRelatedToMeList();
    }
  }
}

final relatedToMeProvider = StateNotifierProvider<RelatedToMeNotifier, RelatedToMeState>(
  (ref) => RelatedToMeNotifier(),
);
