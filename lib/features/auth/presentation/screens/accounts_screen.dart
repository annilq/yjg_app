import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';
import 'package:flutter_app/features/auth/providers/auth_providers.dart';
import 'package:flutter_app/features/auth/models/account_model.dart';
import 'package:flutter_app/shared/widgets/index.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBarComponent(
        title: '多账号管理',
        actions: [
          IconButton(
            icon: const Icon(CupertinoIcons.refresh, size: 20),
            onPressed: () => ref.invalidate(accountsProvider),
          ),
        ],
      ),
      body: _Body(
        onAdd: () async {
          await context.push('/accounts/add');
          ref.invalidate(accountsProvider);
        },
      ),
    );
  }
}

class _Body extends ConsumerWidget {
  final VoidCallback onAdd;
  const _Body({required this.onAdd});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final async = ref.watch(accountsProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? DarkColors.surface : LightColors.surface;

    return async.when(
      loading: () => const LoadingComponent(message: '加载中...'),
      error: (e, _) => ErrorComponent(
        message: '加载失败',
        onRetry: () => ref.invalidate(accountsProvider),
      ),
      data: (accounts) => accounts.isEmpty
          ? Center(
              child: Text('暂无账号',
                  style: AppTypography.bodyMedium.copyWith(
                      color: isDark
                          ? DarkColors.textSecondary
                          : LightColors.textSecondary)))
          : Column(children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  itemCount: accounts.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: AppSpacing.sm),
                  itemBuilder: (_, i) => _Card(
                    account: accounts[i],
                    bgColor: bgColor,
                    onTap: () => _switchTo(context, ref, accounts[i]),
                    onDelete: () => _delete(context, ref, accounts[i]),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: ButtonComponent(onPressed: onAdd, text: '新增账号'),
              ),
            ]),
    );
  }

  void _switchTo(BuildContext ctx, WidgetRef ref, Account a) {
    if (a.selected) return;
    ref
        .read(accountServiceProvider)
        .switchAccount(a.value)
        .then((_) {
          ref.invalidate(accountsProvider);
          SnackBarHelper.showSnackBar(ctx, '已切换到: ${a.label}');
        })
        .catchError((_) => SnackBarHelper.showSnackBar(ctx, '切换失败'));
  }

  void _delete(BuildContext ctx, WidgetRef ref, Account a) async {
    final ok = await showDialog<bool>(
      context: ctx,
      builder: (c) => CupertinoAlertDialog(
        title: const Text('删除账号'),
        content: Text('确定要删除 "${a.label}" 吗？'),
        actions: [
          CupertinoDialogAction(
              child: const Text('取消'),
              onPressed: () => Navigator.of(c).pop(false)),
          CupertinoDialogAction(
              isDestructiveAction: true,
              child: const Text('删除'),
              onPressed: () => Navigator.of(c).pop(true)),
        ],
      ),
    );
    if (ok == true) {
      ref
          .read(accountServiceProvider)
          .deleteAccount(a.value)
          .then((_) {
            ref.invalidate(accountsProvider);
            SnackBarHelper.showSnackBar(ctx, '已删除');
          })
          .catchError((_) => SnackBarHelper.showSnackBar(ctx, '删除失败'));
    }
  }
}

class _Card extends StatelessWidget {
  final Account account;
  final Color bgColor;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _Card({
    required this.account,
    required this.bgColor,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final primary = Theme.of(context).colorScheme.primary;

    return GestureDetector(
      onTap: account.disabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: AppRadius.allSm,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: primary.withAlpha(26),
                borderRadius: AppRadius.allFull,
              ),
              alignment: Alignment.center,
              child: Text(
                account.label.isNotEmpty ? account.label[0] : '?',
                style: AppTypography.bodyMedium.copyWith(
                  color: primary,
                  fontWeight: AppTypography.weightSemibold,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(account.label,
                      style: AppTypography.bodyMedium.copyWith(
                          fontWeight: AppTypography.weightMedium)),
                  if (account.tenantName != null &&
                      account.tenantName!.isNotEmpty) ...[
                    const SizedBox(height: 2),
                    Text(account.tenantName!,
                        style: AppTypography.caption.copyWith(
                            color: isDark
                                ? DarkColors.textSecondary
                                : LightColors.textSecondary)),
                  ],
                  if (account.selected) ...[
                    const SizedBox(height: 2),
                    Text('当前使用中',
                        style: AppTypography.caption.copyWith(color: primary)),
                  ],
                ],
              ),
            ),
            if (account.selected)
              Icon(CupertinoIcons.checkmark_circle,
                  size: 20, color: primary)
            else if (!account.disabled) ...[
              GestureDetector(
                onTap: onDelete,
                child: Icon(CupertinoIcons.trash,
                    size: 18, color: Theme.of(context).colorScheme.error),
              ),
              const SizedBox(width: AppSpacing.sm),
              Icon(CupertinoIcons.chevron_right,
                  size: 14,
                  color: isDark
                      ? DarkColors.textTertiary
                      : LightColors.textTertiary),
            ],
          ],
        ),
      ),
    );
  }
}
