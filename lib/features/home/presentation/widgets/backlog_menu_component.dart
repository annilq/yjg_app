import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class BacklogMenuComponent extends StatelessWidget {
  final int backlogCount;
  final int remindCount;

  const BacklogMenuComponent({
    Key? key,
    required this.backlogCount,
    required this.remindCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A1A1A) : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: isDark
            ? Border.all(color: const Color(0xFF2E2E30), width: 1)
            : null,
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.06),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
      ),
      child: Column(
        children: [
          // ── 第一行：待处理 + 已发起 ─────────────────────────────
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _MenuItemCard(
                    icon: CupertinoIcons.mail,
                    iconColor: const Color(0xFFEF4444),    // 红 — 待处理
                    title: '待处理',
                    count: backlogCount,
                    onTap: () => context.push('/office/backlog'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MenuItemCard(
                    icon: CupertinoIcons.paperplane,
                    iconColor: const Color(0xFF3B82F6),    // 蓝 — 已发起
                    title: '已发起',
                    count: 0,
                    onTap: () => context.push('/office/relatedtome'),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          // ── 第二行：提醒 + 发起 ───────────────────────────────
          IntrinsicHeight(
            child: Row(
              children: [
                Expanded(
                  child: _MenuItemCard(
                    icon: CupertinoIcons.bell,
                    iconColor: const Color(0xFFF59E0B),    // 黄 — 提醒
                    title: '提醒',
                    count: remindCount,
                    onTap: () => context.push('/notices'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _MenuItemCard(
                    icon: CupertinoIcons.add_circled,
                    iconColor: const Color(0xFF10B981),    // 绿 — 发起
                    title: '发起',
                    count: 0,
                    onTap: () {},
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// 单个菜单卡片
class _MenuItemCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final int count;
  final VoidCallback onTap;

  const _MenuItemCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.count,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark
        ? const Color(0xFF252525)
        : const Color(0xFFF5F7FA);
    final textColor = isDark
        ? const Color(0xFFE5E7EB)
        : const Color(0xFF1F2937);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(12),
          border: isDark
              ? Border.all(color: const Color(0xFF2E2E30), width: 0.5)
              : null,
        ),
        child: Row(
          children: [
            // 左侧图标
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 18,
              ),
            ),
            const SizedBox(width: 10),
            // 中间文字
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: textColor,
                    ),
                  ),
                  if (count > 0) ...[
                    const SizedBox(height: 2),
                    Text(
                      '$count 条待办',
                      style: TextStyle(
                        fontSize: 11,
                        color: iconColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ],
              ),
            ),
            // 右侧箭头
            Icon(
              CupertinoIcons.chevron_right,
              size: 14,
              color: isDark
                  ? const Color(0xFF4B5563)
                  : const Color(0xFF9CA3AF),
            ),
          ],
        ),
      ),
    );
  }
}
