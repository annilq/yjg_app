import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';
import 'package:flutter_app/shared/widgets/snackbar_helper.dart';
import 'package:flutter_app/core/constants/app_images.dart';
import 'package:flutter_app/features/auth/providers/auth_providers.dart';
import 'package:flutter_app/features/profile/providers/profile_providers.dart';
import 'package:flutter_app/features/settings/providers/settings_providers.dart';

/// 侧边抽屉内容组件
class MainDrawer extends ConsumerStatefulWidget {
  const MainDrawer({super.key});

  @override
  ConsumerState<MainDrawer> createState() => _MainDrawerState();
}

class _MainDrawerState extends ConsumerState<MainDrawer> {
  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Drawer(
      width: 260,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context),
            Expanded(child: _buildMenuSection(context)),
            _buildBottomBar(context),
          ],
        ),
      ),
    );
  }

  /// 头部
  Widget _buildHeader(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final authState = ref.watch(authProvider);

    String userName = '用户';
    String accountName = '';

    // 从 AuthNotifier 中获取用户信息
    authState.when(
      data: (loginResponse) {
        if (loginResponse != null && loginResponse.userInfo != null) {
          userName = loginResponse.userInfo?.name ?? '用户';
          accountName = loginResponse.userInfo?.username ?? '';
        }
      },
      loading: () {},
      error: (_, __) {},
    );

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(
        color: isDark ? DarkColors.surfaceVariant : AppColors.primaryDark,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _buildAvatar(),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      userName,
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.white,
                        fontWeight: AppTypography.weightBold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      accountName,
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.white.withAlpha(179),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return GestureDetector(
      onTap: _pickAvatar,
      child: Container(
        width: 56,
        height: 56,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white, width: 2),
        ),
        child: ClipOval(
          child: Image.asset(AppImages.avatar, fit: BoxFit.cover),
        ),
      ),
    );
  }

  /// 底部栏：左侧主题按钮 + 右侧退出
  Widget _buildBottomBar(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? DarkColors.border : LightColors.border;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: borderColor, width: 1)),
      ),
      child: Row(
        children: [
          _buildThemeToggle(context),
          const Spacer(),
          _buildLogoutButton(context),
        ],
      ),
    );
  }

  /// 主题切换按钮 — 单按钮循环切换
  Widget _buildThemeToggle(BuildContext context) {
    final currentMode = ref.watch(themeModeProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final (icon, nextMode) = switch (currentMode) {
      AppThemeMode.system => (Icons.brightness_auto_outlined, AppThemeMode.light),
      AppThemeMode.light => (Icons.light_mode_outlined, AppThemeMode.dark),
      AppThemeMode.dark => (Icons.dark_mode_outlined, AppThemeMode.system),
    };

    return GestureDetector(
      onTap: () => ref.read(themeModeProvider.notifier).setThemeMode(nextMode),
      child: Icon(
        icon,
        size: 22,
        color: isDark ? DarkColors.textSecondary : LightColors.textSecondary,
      ),
    );
  }

  /// 退出按钮
  Widget _buildLogoutButton(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return GestureDetector(
      onTap: _showLogoutDialog,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            CupertinoIcons.square_arrow_right,
            size: 16,
            color: colorScheme.error,
          ),
          const SizedBox(width: AppSpacing.xs),
          Text(
            '退出登陆',
            style: AppTypography.bodySmall.copyWith(color: colorScheme.error),
          ),
        ],
      ),
    );
  }

  /// 菜单列表
  Widget _buildMenuSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor = isDark ? DarkColors.border : LightColors.border;

    final menus = [
      {'icon': CupertinoIcons.book, 'label': '通讯录', 'url': '/contact'},
      {'icon': CupertinoIcons.lock, 'label': '修改密码', 'url': '/update-password'},
      {'icon': CupertinoIcons.person_2, 'label': '多账号管理', 'url': '/accounts'},
      {'icon': CupertinoIcons.info_circle, 'label': '关于', 'url': '/settings/about'},
      {'icon': CupertinoIcons.settings, 'label': '设置', 'url': '/settings'},
    ];

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
        child: Container(
          decoration: BoxDecoration(color: colorScheme.surface),
          child: Column(
            children: menus.asMap().entries.map((entry) {
              final index = entry.key;
              final menu = entry.value;
              return Column(
                children: [
                  _DrawerMenuItem(
                    icon: menu['icon'] as IconData,
                    label: menu['label'] as String,
                    onTap: () {
                      if (menu['url'] != null) {
                        Navigator.pop(context);
                        context.push(menu['url'] as String);
                      }
                    },
                  ),
                  if (index < menus.length - 1)
                    Divider(height: 1, color: borderColor, indent: 56),
                ],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  /// 头像选择
  Future<void> _pickAvatar() async {
    final XFile? image = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );
    if (image != null && mounted) {
      SnackBarHelper.showSnackBar(context, '头像上传成功');
    }
  }



  /// 退出登陆
  Future<void> _showLogoutDialog() async {
    showDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('提示'),
        content: const Text('是否退出登陆？'),
        actions: [
          CupertinoDialogAction(
            child: const Text('取消'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          CupertinoDialogAction(
            child: const Text('确定'),
            onPressed: () async {
              Navigator.of(ctx).pop();
              Navigator.pop(context);
              try {
                await ref.read(profileProvider.notifier).logout();
                if (mounted) context.go('/');
              } catch (e) {
                if (mounted) {
                  SnackBarHelper.showSnackBar(context, '退出登陆失败: $e');
                }
              }
            },
          ),
        ],
      ),
    );
  }
}

/// 抽屉菜单项
class _DrawerMenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _DrawerMenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primaryColor = Theme.of(context).colorScheme.primary;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: primaryColor.withAlpha(26),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 16, color: primaryColor),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                label,
                style: AppTypography.bodyMedium.copyWith(
                  color: Theme.of(context).colorScheme.onSurface,
                ),
              ),
            ),
            Icon(
              CupertinoIcons.chevron_right,
              size: 14,
              color: isDark ? DarkColors.textTertiary : LightColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
