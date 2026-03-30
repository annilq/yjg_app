import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/shared/widgets/button_component.dart';
import 'package:flutter_app/shared/widgets/snackbar_helper.dart';
import 'package:flutter_app/features/contact/providers/contact_providers.dart';

/// 联系人详情页 - Flat Design 风格
class ContactDetailScreen extends ConsumerWidget {
  const ContactDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = GoRouterState.of(context).extra;
    final userIdStr = _parseUserId(userId);
    final contactState = ref.watch(contactDetailProvider(userIdStr));
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? DarkColors.background : LightColors.background,
      appBar: AppBarComponent(title: '联系人详情'),
      body: contactState.when(
        data: (contact) => SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Column(
            children: [
              // 头像区域
              _buildAvatarSection(context, contact.name, isDark),
              const SizedBox(height: AppSpacing.xxl),
              // 信息卡片
              _buildInfoCard(context, contact, isDark),
              const SizedBox(height: AppSpacing.xxl),
              // 操作按钮
              _buildActionButton(context, ref, userIdStr, contact, isDark),
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

  String _parseUserId(dynamic userId) {
    if (userId is int) return userId.toString();
    if (userId is String) return userId;
    return '';
  }

  /// 头像区域
  Widget _buildAvatarSection(BuildContext context, String? name, bool isDark) {
    final firstChar = (name?.isNotEmpty == true) ? name!.substring(0, 1) : '?';
    final primary = Theme.of(context).colorScheme.primary;

    return Container(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        children: [
          // 头像
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: primary.withAlpha(15),
              borderRadius: BorderRadius.circular(40),
            ),
            alignment: Alignment.center,
            child: Text(
              firstChar,
              style: AppTypography.headlineLarge.copyWith(
                color: primary,
                fontWeight: AppTypography.weightBold,
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          // 姓名
          Text(
            name ?? '未知',
            style: AppTypography.headlineSmall.copyWith(
              fontWeight: AppTypography.weightBold,
            ),
          ),
        ],
      ),
    );
  }

  /// 信息卡片
  Widget _buildInfoCard(BuildContext context, dynamic contact, bool isDark) {
    final surface = isDark ? DarkColors.surface : LightColors.surface;

    return Container(
      decoration: BoxDecoration(
        color: surface,
        borderRadius: AppRadius.allSm,
      ),
      child: Column(
        children: [
          // 电话
          _buildInfoItem(
            context,
            icon: CupertinoIcons.phone_fill,
            label: '电话',
            value: contact.phone ?? '暂无',
            onTap: contact.phone != null ? () => _makePhoneCall(context, contact.phone!) : null,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          // 邮箱
          _buildInfoItem(
            context,
            icon: CupertinoIcons.envelope_fill,
            label: '邮箱',
            value: contact.email ?? '暂无',
            onTap: contact.email != null ? () => _sendEmail(context, contact.email!) : null,
            isDark: isDark,
          ),
          _buildDivider(isDark),
          // 职位
          _buildInfoItem(
            context,
            icon: CupertinoIcons.briefcase_fill,
            label: '职位',
            value: contact.position ?? '暂无',
            isDark: isDark,
          ),
          _buildDivider(isDark),
          // 部门
          _buildInfoItem(
            context,
            icon: CupertinoIcons.building_2_fill,
            label: '部门',
            value: contact.dept ?? '暂无',
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  /// 信息项
  Widget _buildInfoItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    VoidCallback? onTap,
    required bool isDark,
  }) {
    final textSecondary = isDark ? DarkColors.textSecondary : LightColors.textSecondary;
    final primary = Theme.of(context).colorScheme.primary;
    final canTap = onTap != null;

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.md,
        ),
        child: Row(
          children: [
            Icon(icon, size: 18, color: canTap ? primary : textSecondary),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: AppTypography.caption.copyWith(color: textSecondary),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    value,
                    style: AppTypography.bodyMedium.copyWith(
                      color: canTap ? primary : null,
                      fontWeight: canTap ? AppTypography.weightMedium : null,
                    ),
                  ),
                ],
              ),
            ),
            if (canTap)
              Icon(
                CupertinoIcons.chevron_right,
                size: 14,
                color: textSecondary,
              ),
          ],
        ),
      ),
    );
  }

  /// 分割线
  Widget _buildDivider(bool isDark) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.lg + 18 + AppSpacing.md),
      child: Divider(
        height: 1,
        thickness: 0.5,
        color: isDark ? DarkColors.border : LightColors.border,
      ),
    );
  }

  /// 操作按钮
  Widget _buildActionButton(
    BuildContext context,
    WidgetRef ref,
    String userId,
    dynamic contact,
    bool isDark,
  ) {
    final isFrequent = contact.fc ?? false;

    return ButtonComponent(
      onPressed: () async {
        try {
          await ref.read(contactDetailProvider(userId).notifier).toggleFrequent();
          if (context.mounted) {
            SnackBarHelper.success(
              context,
              isFrequent ? '已从常用联系人中移除' : '已添加到常用联系人',
            );
          }
        } catch (e) {
          if (context.mounted) {
            SnackBarHelper.error(context, '操作失败，请重试');
          }
        }
      },
      text: isFrequent ? '取消常用' : '设为常用',
      isFullWidth: true,
    );
  }

  /// 拨打电话
  void _makePhoneCall(BuildContext context, String phone) async {
    final uri = Uri(scheme: 'tel', path: phone);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        SnackBarHelper.error(context, '无法拨打电话');
      }
    }
  }

  /// 发送邮件
  void _sendEmail(BuildContext context, String email) async {
    final uri = Uri(scheme: 'mailto', path: email);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      if (context.mounted) {
        SnackBarHelper.error(context, '无法发送邮件');
      }
    }
  }
}
