import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';
import 'package:flutter_app/features/home/presentation/widgets/backlog_menu_component.dart';
import 'package:flutter_app/features/home/presentation/widgets/common_apps_component.dart';
import 'package:flutter_app/features/home/presentation/widgets/announcement_carousel_component.dart';
import 'package:flutter_app/features/home/presentation/widgets/fixed_apps_component.dart';
import 'package:flutter_app/features/home/presentation/widgets/copyright_component.dart';
import 'package:flutter_app/features/home/providers/home_providers.dart';

/// 首页 - Flat Design 风格
///
/// [onMenuTap] 左侧菜单按钮回调，用于打开侧边抽屉
class HomeScreen extends ConsumerWidget {
  final VoidCallback? onMenuTap;

  const HomeScreen({super.key, this.onMenuTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final homeState = ref.watch(homeScreenProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? DarkColors.background : LightColors.background,
      appBar: AppBar(
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: isDark
                  ? [
                      DarkColors.surface,
                      DarkColors.surface,
                    ]
                  : [
                      AppColors.primaryDark,
                      AppColors.primary,
                    ],
            ),
          ),
        ),
        foregroundColor: AppColors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: onMenuTap != null
            ? IconButton(
                icon: const Icon(CupertinoIcons.bars, size: 24),
                onPressed: onMenuTap,
                tooltip: '菜单',
              )
            : null,
        title: Text(
          '首页',
          style: AppTypography.headlineLarge.copyWith(
            color: AppColors.white,
            fontWeight: AppTypography.weightBold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.add, size: 24),
            onPressed: () => context.push('/start'),
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(
            height: 1,
            color: isDark ? DarkColors.border : LightColors.border,
          ),
        ),
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
              color: isDark
                  ? DarkColors.textSecondary
                  : LightColors.textSecondary,
            ),
          ),
        ),
      ),
    );
  }
}
