import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/models/main_reminds_response_model.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/features/home/presentation/widgets/backlog_menu_component.dart';
import 'package:flutter_app/features/home/presentation/widgets/common_apps_component.dart';
import 'package:flutter_app/features/home/presentation/widgets/announcement_carousel_component.dart';
import 'package:flutter_app/features/home/presentation/widgets/common_modules_component.dart';
import 'package:flutter_app/features/home/presentation/widgets/fixed_apps_component.dart';
import 'package:flutter_app/features/home/presentation/widgets/copyright_component.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  List<RemindModel> _reminds = [];
  int _backlogCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      var remindsResponse = await ApiService().getMainReminds();
      MainRemindsResponseModel remindsModel = MainRemindsResponseModel.fromJson(remindsResponse);
      _reminds = remindsModel.remindModels ?? [];

      _backlogCount = await ApiService().getWorkflowBacklogCount();
    } catch (e) {
      print('加载数据失败: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: null,
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(CupertinoIcons.bell),
                onPressed: () {
                  context.push('/notices');
                },
              ),
              if (_backlogCount > 0)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(2),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 16,
                      minHeight: 16,
                    ),
                    child: Text(
                      '$_backlogCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  BacklogMenuComponent(
                    backlogCount: _backlogCount,
                    remindCount: _reminds.length,
                  ),
                  const SizedBox(height: 16),
                  const CommonAppsComponent(),
                  const SizedBox(height: 16),
                  AnnouncementCarouselComponent(reminds: _reminds),
                  const SizedBox(height: 16),
                  const CommonModulesComponent(),
                  const SizedBox(height: 16),
                  const FixedAppsComponent(),
                  const SizedBox(height: 16),
                  const CopyrightComponent(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
    );
  }
}
