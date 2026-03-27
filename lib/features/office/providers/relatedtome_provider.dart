import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/features/office/service/office_service.dart';
import 'package:flutter_app/features/office/models/backlog_model.dart';
import 'package:flutter_app/features/office/providers/backlog_provider.dart';

final relatedToMeProvider = AsyncNotifierProvider<RelatedToMeNotifier, BacklogListData>(
  RelatedToMeNotifier.new,
);

class RelatedToMeNotifier extends AsyncNotifier<BacklogListData> {
  late final OfficeService _officeService;
  int _currentTabIndex = 0;
  String? _keyword;
  int _page = 1;
  final int _rows = 10;

  @override
  Future<BacklogListData> build() async {
    _officeService = ref.read(officeServiceProvider);
    return await loadRelatedToMeList(refresh: true);
  }

  Future<BacklogListData> loadRelatedToMeList({bool refresh = false}) async {
    if (refresh) {
      _page = 1;
    }

    final response = await _officeService.getRelatedToMeList(
      _currentTabIndex,
      _keyword,
      _page,
      _rows,
    );

    final rows = response?['rows'] as List<dynamic>?;
    final items = List<BacklogItem>.from((rows ?? []).map((item) => BacklogItem.fromJson(item)));
    final hasMore = !(response?['last'] ?? true);

    if (!refresh) {
      final currentState = await future;
      items.insertAll(0, currentState.items ?? []);
    }

    _page++;
    return BacklogListData(items: items, hasMore: hasMore);
  }

  Future<void> onTabChanged(int index) {
    _currentTabIndex = index;
    _page = 1;
    return refresh();
  }

  Future<void> onSearch(String keyword) {
    _keyword = keyword;
    _page = 1;
    return refresh();
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() => loadRelatedToMeList(refresh: true));
  }

  Future<void> loadMore() async {
    final currentState = await future;
    if (!(currentState.hasMore ?? false)) return;

    state = await AsyncValue.guard(() => loadRelatedToMeList(refresh: false));
  }
}

