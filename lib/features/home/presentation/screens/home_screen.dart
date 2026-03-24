import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/features/home/presentation/widgets/backlog_menu_component.dart';
import 'package:flutter_app/features/home/presentation/widgets/common_apps_component.dart';
import 'package:flutter_app/features/home/presentation/widgets/announcement_carousel_component.dart';
import 'package:flutter_app/features/home/presentation/widgets/fixed_apps_component.dart';
import 'package:flutter_app/features/home/presentation/widgets/copyright_component.dart';
import 'package:flutter_app/features/home/providers/home_providers.dart';

/// 首页 - Flat Design 风格
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeScreenProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBarComponent(
        title: '首页',
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
                        right: AppSpacing.sm,
                        top: AppSpacing.sm,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: AppColors.error,
                            borderRadius: AppRadius.allFull,
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '${data.backlogCount}',
                            style: AppTypography.overline.copyWith(
                              color: AppColors.white,
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
          padding: AppSpacing.screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              BacklogMenuComponent(
                backlogCount: data.backlogCount,
                remindCount: data.reminds.length,
              ),
              SizedBox(height: AppSpacing.sectionGap),
              AnnouncementCarouselComponent(reminds: data.reminds),
              SizedBox(height: AppSpacing.sectionGap),
              CommonAppsComponent(),
              SizedBox(height: AppSpacing.sectionGap),
              FixedAppsComponent(),
              SizedBox(height: AppSpacing.sectionGap),
              CopyrightComponent(),
              SizedBox(height: AppSpacing.sectionGap),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            '加载失败: $error',
            style: AppTypography.bodyMedium.copyWith(
              color: isDark ? DarkColors.textSecondary : LightColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
