import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/features/workflow/providers/workflow_providers.dart';

class WorkflowListData {
  final Map<String, dynamic> config;
  final List<dynamic> dataList;
  final int page;
  final int rows;
  final bool hasMore;
  final Map<String, dynamic> searchForm;
  final Map<String, dynamic> pickerParams;

  const WorkflowListData({
    this.config = const {},
    this.dataList = const [],
    this.page = 1,
    this.rows = 10,
    this.hasMore = true,
    this.searchForm = const {},
    this.pickerParams = const {},
  });
}

final workflowListProvider = AsyncNotifierProviderFamily<WorkflowListNotifier, WorkflowListData, int>(
  WorkflowListNotifier.new,
);

class WorkflowListNotifier extends FamilyAsyncNotifier<WorkflowListData, int> {
  late final int _dataId;
  int _page = 1;
  final int _rows = 10;
  Map<String, dynamic> _searchForm = {};
  Map<String, dynamic> _pickerParams = {};

  @override
  Future<WorkflowListData> build(int dataId) async {
    _dataId = dataId;
    _page = 1;
    _searchForm = {};
    _pickerParams = {};
    
    final config = await loadConfig();
    return await loadData(refresh: true, config: config);
  }

  Future<Map<String, dynamic>> loadConfig() async {
    final service = ref.read(workflowServiceProvider);
    var configResponse = await service.getConfig();
    if (configResponse.containsKey('datalistconfig')) {
      return configResponse['datalistconfig'][_dataId] ?? {};
    }
    return {};
  }

  Future<WorkflowListData> loadData({bool refresh = false, Map<String, dynamic>? config}) async {
    if (refresh) {
      _page = 1;
    }

    final params = {
      'rows': _rows,
      'page': _page,
      ..._searchForm,
      ..._pickerParams,
    };

    final service = ref.read(workflowServiceProvider);
    var response = await service.getDataList(
      _dataId,
      params,
      _page,
      _rows,
      -1,
    );

    List<dynamic> list = response['rows'] ?? [];
    if (!refresh) {
      final currentState = await future;
      list.insertAll(0, currentState.dataList);
    }

    _page++;
    return WorkflowListData(
      config: config ?? (await future).config,
      dataList: list,
      page: _page,
      rows: _rows,
      hasMore: !(response['last'] ?? true),
      searchForm: _searchForm,
      pickerParams: _pickerParams,
    );
  }

  Future<void> updateSearchForm(Map<String, dynamic> searchForm) async {
    _searchForm = searchForm;
    _page = 1;
    state = await AsyncValue.guard(() => loadData(refresh: true));
  }

  Future<void> updatePickerParams(Map<String, dynamic> pickerParams) async {
    _pickerParams = pickerParams;
    _page = 1;
    state = await AsyncValue.guard(() => loadData(refresh: true));
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() => loadData(refresh: true));
  }

  Future<void> loadMore() async {
    final currentState = await future;
    if (!currentState.hasMore) return;

    state = await AsyncValue.guard(() => loadData(refresh: false));
  }
}

