import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';
import 'package:flutter_app/shared/widgets/index.dart';
import 'package:flutter_app/core/constants/app_images.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? DarkColors.surface : LightColors.surface;

    return Scaffold(
      backgroundColor: isDark ? DarkColors.background : LightColors.background,
      appBar: AppBarComponent(title: '关于'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.xxxxl),
            // Logo
            Container(
              width: 64,
              height: 64,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: AppRadius.allMd,
              ),
              alignment: Alignment.center,
              child: Image.asset(AppImages.logo, width: 48, height: 48),
            ),
            const SizedBox(height: AppSpacing.md),
            Text('云建管',
                style: AppTypography.headlineSmall.copyWith(
                    fontWeight: AppTypography.weightBold)),
            const SizedBox(height: AppSpacing.xs),
            Text('版本 1.0.0',
                style: AppTypography.bodySmall.copyWith(
                    color: isDark
                        ? DarkColors.textSecondary
                        : LightColors.textSecondary)),
            const SizedBox(height: AppSpacing.xxl),
            // 菜单色块
            Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: AppRadius.allSm,
              ),
              child: Column(children: [
                _menuRow(context, CupertinoIcons.building_2_fill, '公司简介',
                    () => _showCompanyInfo(context)),
                _menuRow(context, CupertinoIcons.doc_text, '隐私政策',
                    () => SnackBarHelper.showSnackBar(context, '开发中')),
                _menuRow(context, CupertinoIcons.doc, '用户协议',
                    () => SnackBarHelper.showSnackBar(context, '开发中')),
                _menuRow(context, CupertinoIcons.phone, '联系我们',
                    () => _showContactDialog(context), isLast: true),
              ]),
            ),
            const SizedBox(height: AppSpacing.xxl),
            Text('© 2024 云建管 版权所有',
                style: AppTypography.caption.copyWith(
                    color: isDark
                        ? DarkColors.textTertiary
                        : LightColors.textTertiary)),
            const SizedBox(height: AppSpacing.lg),
          ],
        ),
      ),
    );
  }

  Widget _menuRow(BuildContext context, IconData icon, String label,
      VoidCallback onTap,
      {bool isLast = false}) {
    final primary = Theme.of(context).colorScheme.primary;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.md),
        decoration: BoxDecoration(
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                      color: isDark ? DarkColors.border : LightColors.border,
                      width: 0.5)),
        ),
        child: Row(children: [
          Icon(icon, size: 18, color: primary),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Text(label, style: AppTypography.bodyMedium)),
          Icon(CupertinoIcons.chevron_right,
              size: 14,
              color: isDark
                  ? DarkColors.textTertiary
                  : LightColors.textTertiary),
        ]),
      ),
    );
  }

  void _showCompanyInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('公司简介'),
        content: const Text(
            '云建管是一款专注于建筑行业的企业管理平台，提供项目管理、人员管理、流程审批等功能，帮助企业实现数字化转型。'),
        actions: [
          CupertinoDialogAction(
              child: const Text('关闭'),
              onPressed: () => Navigator.of(ctx).pop()),
        ],
      ),
    );
  }

  void _showContactDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => CupertinoAlertDialog(
        title: const Text('联系我们'),
        content: const Text('客服热线：400-006-3359'),
        actions: [
          CupertinoDialogAction(
              child: const Text('取消'),
              onPressed: () => Navigator.of(ctx).pop()),
          CupertinoDialogAction(
              child: const Text('立即拨号'),
              onPressed: () {
                Navigator.of(ctx).pop();
                launchUrl(Uri(scheme: 'tel', path: '4000063359'));
              }),
        ],
      ),
    );
  }
}
