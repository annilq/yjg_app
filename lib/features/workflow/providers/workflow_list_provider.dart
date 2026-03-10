import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/features/workflow/providers/workflow_providers.dart';

class WorkflowListState {
  final Map<String, dynamic> config;
  final List<dynamic> dataList;
  final int page;
  final int rows;
  final bool hasMore;
  final bool isLoading;
  final Map<String, dynamic> searchForm;
  final Map<String, dynamic> pickerParams;

  const WorkflowListState({
    this.config = const {},
    this.dataList = const [],
    this.page = 1,
    this.rows = 10,
    this.hasMore = true,
    this.isLoading = true,
    this.searchForm = const {},
    this.pickerParams = const {},
  });

  WorkflowListState copyWith({
    Map<String, dynamic>? config,
    List<dynamic>? dataList,
    int? page,
    int? rows,
    bool? hasMore,
    bool? isLoading,
    Map<String, dynamic>? searchForm,
    Map<String, dynamic>? pickerParams,
    bool clearData = false,
  }) {
    return WorkflowListState(
      config: config ?? this.config,
      dataList: clearData ? (dataList ?? []) : (dataList ?? this.dataList),
      page: page ?? this.page,
      rows: rows ?? this.rows,
      hasMore: hasMore ?? this.hasMore,
      isLoading: isLoading ?? this.isLoading,
      searchForm: searchForm ?? this.searchForm,
      pickerParams: pickerParams ?? this.pickerParams,
    );
  }
}

class WorkflowListNotifier extends StateNotifier<WorkflowListState> {
  final Ref ref;

  WorkflowListNotifier(this.ref) : super(const WorkflowListState());

  Future<void> loadConfig(String dataId) async {
    try {
      final service = ref.read(workflowServiceProvider);
      var configResponse = await service.getConfig();
      if (configResponse.containsKey('datalistconfig')) {
        final config = configResponse['datalistconfig'][dataId] ?? {};
        state = state.copyWith(config: config);
      }
      await initLoadData(dataId);
    } catch (e) {
      print('加载配置失败: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  Future<void> initLoadData(String dataId) async {
    state = state.copyWith(
      hasMore: true,
      dataList: [],
      page: 1,
      isLoading: false, // 这里改为false，因为loadData会设置为true
      clearData: true,
    );
    await loadData(dataId);
  }

  Future<void> loadData(String dataId) async {
    if (!state.hasMore || state.isLoading) return;

    state = state.copyWith(isLoading: true);

    try {
      final params = {
        'rows': state.rows,
        'page': state.page,
        ...state.searchForm,
        ...state.pickerParams,
      };

      final service = ref.read(workflowServiceProvider);
      var response = await service.getDataList(
        dataId,
        params,
        state.page,
        state.rows,
        -1,
      );

      List<dynamic> list = response['rows'] ?? [];
      state = state.copyWith(
        hasMore: !(response['last'] ?? true),
        page: state.page + 1,
        dataList: [...state.dataList, ...list],
        isLoading: false,
      );
    } catch (e) {
      print('加载数据失败: $e');
      state = state.copyWith(isLoading: false);
    }
  }

  void updateSearchForm(Map<String, dynamic> searchForm) {
    state = state.copyWith(searchForm: searchForm, page: 1, clearData: true);
  }

  void updatePickerParams(Map<String, dynamic> pickerParams) {
    state = state.copyWith(pickerParams: pickerParams, page: 1, clearData: true);
  }
}

final workflowListProvider = StateNotifierProvider<WorkflowListNotifier, WorkflowListState>(
  (ref) => WorkflowListNotifier(ref),
);
