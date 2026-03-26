import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';
import 'package:flutter_app/shared/widgets/index.dart';
import 'package:flutter_app/features/settings/providers/settings_providers.dart';

class LanguageSettingsScreen extends ConsumerWidget {
  const LanguageSettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final current = ref.watch(languageProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? DarkColors.surface : LightColors.surface;
    final primary = Theme.of(context).colorScheme.primary;

    final languages = [
      (AppLanguage.chinese, '中文', '简体中文'),
      (AppLanguage.english, 'English', 'English'),
    ];

    return Scaffold(
      backgroundColor: isDark ? DarkColors.background : LightColors.background,
      appBar: AppBarComponent(title: '语言切换'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Column(
          children: [
            const SizedBox(height: AppSpacing.lg),
            Container(
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: AppRadius.allSm,
              ),
              child: Column(
                children: languages.asMap().entries.map((e) {
                  final i = e.key;
                  final (lang, title, sub) = e.value;
                  final selected = current == lang;
                  return _langRow(
                    context: context,
                    title: title,
                    subtitle: sub,
                    selected: selected,
                    primary: primary,
                    isDark: isDark,
                    isLast: i == languages.length - 1,
                    onTap: () =>
                        ref.read(languageProvider.notifier).setLanguage(lang),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _langRow({
    required BuildContext context,
    required String title,
    required String subtitle,
    required bool selected,
    required Color primary,
    required bool isDark,
    required bool isLast,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Container(
        padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md, vertical: AppSpacing.md),
        decoration: BoxDecoration(
          color: selected ? primary.withAlpha(26) : null,
          border: isLast
              ? null
              : Border(
                  bottom: BorderSide(
                      color: isDark ? DarkColors.border : LightColors.border,
                      width: 0.5)),
        ),
        child: Row(children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: AppTypography.bodyMedium.copyWith(
                        color: selected
                            ? primary
                            : null,
                        fontWeight: selected
                            ? AppTypography.weightSemibold
                            : null)),
                const SizedBox(height: 2),
                Text(subtitle,
                    style: AppTypography.caption.copyWith(
                        color: isDark
                            ? DarkColors.textSecondary
                            : LightColors.textSecondary)),
              ],
            ),
          ),
          if (selected)
            Icon(CupertinoIcons.checkmark, size: 18, color: primary),
        ]),
      ),
    );
  }
}
