import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/features/office/presentation/widgets/relatedtome_tab_widget.dart';
import 'package:flutter_app/features/office/presentation/widgets/relatedtome_item_widget.dart';

class RelatedToMeListScreen extends ConsumerStatefulWidget {
  const RelatedToMeListScreen({super.key});

  @override
  ConsumerState<RelatedToMeListScreen> createState() => _RelatedToMeListScreenState();
}

class _RelatedToMeListScreenState extends ConsumerState<RelatedToMeListScreen> {
  int _currentTabIndex = 0;
  List<dynamic> _relatedToMeItems = [];
  bool _isLoading = false;
  int _page = 1;
  int _rows = 10;
  String? _keyword;

  @override
  void initState() {
    super.initState();
    _loadRelatedToMeList();
  }

  Future<void> _loadRelatedToMeList() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var response = await ApiService().getRelatedToMeList(
        _currentTabIndex,
        _keyword,
        _page,
        _rows,
      );
      setState(() {
        _relatedToMeItems = response['rows'] ?? [];
      });
    } catch (e) {
      print('加载我发起的列表失败: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentTabIndex = index;
      _page = 1;
      _relatedToMeItems = [];
    });
    _loadRelatedToMeList();
  }

  void _onSearch(String keyword) {
    setState(() {
      _keyword = keyword;
      _page = 1;
      _relatedToMeItems = [];
    });
    _loadRelatedToMeList();
  }

  Future<void> _refresh() async {
    _page = 1;
    _relatedToMeItems = [];
    await _loadRelatedToMeList();
  }

  Future<void> _loadMore() async {
    if (!_isLoading) {
      setState(() {
        _page++;
      });
      await _loadRelatedToMeList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: '我发起的',
        showSearch: true,
        onSearchPressed: () {
          showSearch(
            context: context,
            delegate: RelatedToMeSearchDelegate(_onSearch),
          );
        },
      ),
      body: Column(
        children: [
          RelatedToMeTabWidget(
            currentIndex: _currentTabIndex,
            onTabChanged: _onTabChanged,
          ),
          Expanded(
            child: _isLoading && _relatedToMeItems.isEmpty
                ? const Center(child: CircularProgressIndicator())
                : RefreshIndicator(
                    onRefresh: _refresh,
                    child: NotificationListener<ScrollEndNotification>(
                      onNotification: (notification) {
                        if (notification.metrics.pixels == notification.metrics.maxScrollExtent) {
                          _loadMore();
                        }
                        return false;
                      },
                      child: ListView.builder(
                        itemCount: _relatedToMeItems.length,
                        itemBuilder: (context, index) {
                          return RelatedToMeItemWidget(
                            item: _relatedToMeItems[index],
                          );
                        },
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class RelatedToMeSearchDelegate extends SearchDelegate {
  final Function(String) onSearch;

  RelatedToMeSearchDelegate(this.onSearch);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(CupertinoIcons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(CupertinoIcons.back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    onSearch(query);
    close(context, null);
    return Container();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Container();
  }
}
