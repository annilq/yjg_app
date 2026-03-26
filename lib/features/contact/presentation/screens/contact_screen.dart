import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';
import 'package:flutter_app/shared/widgets/index.dart';
import 'package:flutter_app/features/contact/providers/contact_providers.dart';

class ContactScreen extends ConsumerStatefulWidget {
  const ContactScreen({super.key});

  @override
  ConsumerState<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends ConsumerState<ContactScreen> {
  final Set<int> _expandedDepts = {};

  @override
  Widget build(BuildContext context) {
    final addressBookState = ref.watch(addressBookProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? DarkColors.background : LightColors.background,
      appBar: AppBarComponent(
        title: '通讯录',
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.search, size: 22),
            onPressed: () {},
          ),
        ],
      ),
      body: addressBookState.when(
        data: (departments) => departments.isEmpty
            ? Center(
                child: Text('暂无数据',
                    style: AppTypography.bodyMedium.copyWith(
                        color: isDark ? DarkColors.textSecondary : LightColors.textSecondary)),
              )
            : ListView.separated(
                padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg, vertical: AppSpacing.md),
                itemCount: departments.length,
                separatorBuilder: (_, __) =>
                    const SizedBox(height: AppSpacing.sm),
                itemBuilder: (context, index) => _DepartmentTile(
                  dept: departments[index],
                  isExpanded: _expandedDepts.contains(index),
                  onToggle: () => setState(() {
                    if (_expandedDepts.contains(index))
                      _expandedDepts.remove(index);
                    else
                      _expandedDepts.add(index);
                  }),
                ),
              ),
        loading: () => const LoadingComponent(message: '加载中...'),
        error: (error, stack) => ErrorComponent(
          message: '加载失败',
          onRetry: () => ref.invalidate(addressBookProvider),
        ),
      ),
    );
  }
}

class _DepartmentTile extends StatelessWidget {
  final dynamic dept;
  final bool isExpanded;
  final VoidCallback onToggle;

  const _DepartmentTile({
    required this.dept,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? DarkColors.surface : LightColors.surface;
    final children = dept.children as List? ?? [];

    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: AppRadius.allSm,
      ),
      child: Column(
        children: [
          // 部门标题行
          GestureDetector(
            onTap: onToggle,
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.md, vertical: AppSpacing.md),
              child: Row(
                children: [
                  Text(dept.name ?? '',
                      style: AppTypography.bodyMedium.copyWith(
                          fontWeight: AppTypography.weightSemibold)),
                  const SizedBox(width: AppSpacing.xs),
                  Text('${children.length}人',
                      style: AppTypography.caption.copyWith(
                          color: isDark
                              ? DarkColors.textTertiary
                              : LightColors.textTertiary)),
                  const Spacer(),
                  AnimatedRotation(
                    turns: isExpanded ? 0.5 : 0,
                    duration: const Duration(milliseconds: 200),
                    child: Icon(CupertinoIcons.chevron_down,
                        size: 14,
                        color: isDark
                            ? DarkColors.textTertiary
                            : LightColors.textTertiary),
                  ),
                ],
              ),
            ),
          ),
          // 成员列表（色块，无 border）
          AnimatedCrossFade(
            firstChild: const SizedBox.shrink(),
            secondChild: Column(
              children: children.map((user) {
                return GestureDetector(
                  onTap: () =>
                      context.push('/contact-detail', extra: user.userId),
                  behavior: HitTestBehavior.opaque,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSpacing.sm, horizontal: AppSpacing.md),
                    child: Row(
                      children: [
                        Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .primary
                                .withAlpha(26),
                            borderRadius: AppRadius.allFull,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            user.name?.substring(0, 1) ?? '',
                            style: AppTypography.labelSmall.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                              fontWeight: AppTypography.weightSemibold,
                            ),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.name ?? '',
                                  style: AppTypography.bodySmall),
                              if (user.position != null &&
                                  user.position!.isNotEmpty)
                                Text(user.position ?? '',
                                    style: AppTypography.caption.copyWith(
                                        color: isDark
                                            ? DarkColors.textSecondary
                                            : LightColors.textSecondary)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            crossFadeState: isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: const Duration(milliseconds: 200),
          ),
        ],
      ),
    );
  }
}
