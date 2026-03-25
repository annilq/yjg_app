import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';
import 'package:flutter_app/shared/widgets/snackbar_helper.dart';
import 'package:flutter_app/core/constants/app_images.dart';
import 'package:flutter_app/features/profile/providers/profile_providers.dart';

/// 侧边抽屉内容组件 - 包含用户信息和菜单
///
/// 用于 MainScreen 的 Drawer，展示个人信息和快捷操作
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      width: 240,
      backgroundColor: colorScheme.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.zero,
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(context, isDark),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: AppSpacing.md),
                    _buildMenuSection(context),
                    const SizedBox(height: AppSpacing.md),
                    _buildLogoutSection(context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 头部 - 用户信息
  Widget _buildHeader(BuildContext context, bool isDark) {
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
                      '用户',
                      style: AppTypography.titleMedium.copyWith(
                        color: AppColors.white,
                        fontWeight: AppTypography.weightBold,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '',
                      style: AppTypography.bodySmall.copyWith(
                        color: AppColors.white.withAlpha(179),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              const SizedBox(width: AppSpacing.md),
              _buildMenuItem(
                icon: CupertinoIcons.settings,
                label: '设置',
                onTap: () {
                  Navigator.pop(context);
                  context.push('/settings');
                },
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

  Widget _buildMenuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(color: AppColors.white.withAlpha(26)),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: AppColors.white),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(color: AppColors.white),
            ),
          ],
        ),
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
      {'icon': CupertinoIcons.trash, 'label': '清除缓存', 'action': 'clearCache'},
    ];

    return Padding(
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
                    } else if (menu['action'] == 'clearCache') {
                      Navigator.pop(context);
                      _showClearCacheDialog();
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
    );
  }

  /// 底部退出区域
  Widget _buildLogoutSection(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(color: colorScheme.surface),
        child: _DrawerMenuItem(
          icon: CupertinoIcons.square_arrow_right,
          label: '退出登陆',
          labelColor: colorScheme.error,
          onTap: _showLogoutDialog,
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

  /// 清除缓存
  Future<void> _showClearCacheDialog() async {
    showDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('提示'),
        content: const Text('是否清除缓存'),
        actions: [
          CupertinoDialogAction(
            child: const Text('取消'),
            onPressed: () => Navigator.of(ctx).pop(),
          ),
          CupertinoDialogAction(
            child: const Text('确定'),
            onPressed: () async {
              Navigator.of(ctx).pop();
              try {
                await ref.read(profileProvider.notifier).clearCache();
                if (mounted) SnackBarHelper.showSnackBar(context, '清除缓存成功');
              } catch (e) {
                if (mounted) SnackBarHelper.showSnackBar(context, '清除缓存失败: $e');
              }
            },
          ),
        ],
      ),
    );
  }

  /// 解除绑定
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
              Navigator.pop(context); // 关闭 drawer
              try {
                await ref.read(profileProvider.notifier).logout();
                if (mounted) context.go('/');
              } catch (e) {
                if (mounted) SnackBarHelper.showSnackBar(context, '退出登陆失败: $e');
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
  final Color? labelColor;
  final VoidCallback onTap;

  const _DrawerMenuItem({
    required this.icon,
    required this.label,
    this.labelColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveLabelColor = labelColor ?? colorScheme.onSurface;
    final iconColor = labelColor ?? colorScheme.primary;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          // horizontal: AppSpacing.md,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: iconColor.withAlpha(26),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 16, color: iconColor),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                label,
                style: AppTypography.bodyMedium.copyWith(
                  color: effectiveLabelColor,
                ),
              ),
            ),
            Icon(
              CupertinoIcons.chevron_right,
              size: 14,
              color: isDark
                  ? DarkColors.textTertiary
                  : LightColors.textTertiary,
            ),
          ],
        ),
      ),
    );
  }
}
