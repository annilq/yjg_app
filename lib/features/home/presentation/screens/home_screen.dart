import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/features/home/presentation/widgets/backlog_menu_component.dart';
import 'package:flutter_app/features/home/presentation/widgets/common_apps_component.dart';
import 'package:flutter_app/features/home/presentation/widgets/announcement_carousel_component.dart';
import 'package:flutter_app/features/home/presentation/widgets/fixed_apps_component.dart';
import 'package:flutter_app/features/home/presentation/widgets/copyright_component.dart';
import 'package:flutter_app/features/home/providers/home_providers.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeScreenProvider);

    return Scaffold(
      appBar: AppBarComponent(
        title: '首页' ,
        actions: [
          Stack(
            children: [
              IconButton(
                icon: const Icon(CupertinoIcons.bell),
                onPressed: () {
                  context.push('/notices');
                },
              ),
              homeState.when(
                data: (data) => data.backlogCount > 0
                    ? Positioned(
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
                            '${data.backlogCount}',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                    : const SizedBox(),
                loading: () => const SizedBox(),
                error: (error, stack) => const SizedBox(),
              ),
            ],
          ),
        ],
      ),
      body: homeState.when(
        data: (data) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BacklogMenuComponent(
                backlogCount: data.backlogCount,
                remindCount: data.reminds.length,
              ),
              const SizedBox(height: 16),
              AnnouncementCarouselComponent(reminds: data.reminds),
              const SizedBox(height: 16),
              const CommonAppsComponent(),
              const SizedBox(height: 16),
              const SizedBox(height: 16),
              const FixedAppsComponent(),
              const SizedBox(height: 16),
              const CopyrightComponent(),
              const SizedBox(height: 16),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('加载失败: $error')),
      ),
    );
  }
}
