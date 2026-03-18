import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/features/auth/providers/auth_providers.dart';
import 'package:flutter_app/features/auth/models/account_model.dart';
import 'package:flutter_app/shared/widgets/index.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class AccountsScreen extends ConsumerWidget {
  const AccountsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('账号管理'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(accountsProvider),
          ),
        ],
      ),
      body: _AccountsListContent(
        onAddAccount: () => _handleAddAccount(context, ref),
        onRefresh: () => ref.invalidate(accountsProvider),
      ),
    );
  }

  Future<void> _handleAddAccount(BuildContext context, WidgetRef ref) async {
    await context.push('/accounts/add');
    ref.invalidate(accountsProvider);
  }
}

class _AccountsListContent extends ConsumerWidget {
  final VoidCallback onAddAccount;
  final VoidCallback onRefresh;

  const _AccountsListContent({
    required this.onAddAccount,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountsAsync = ref.watch(accountsProvider);

    return accountsAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stack) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('加载失败: $error'),
            const SizedBox(height: 16),
            ElevatedButton(onPressed: onRefresh, child: const Text('重试')),
          ],
        ),
      ),
      data: (accounts) => _buildList(context, ref, accounts),
    );
  }

  Widget _buildList(BuildContext context, WidgetRef ref, List<Account> accounts) {
    return Column(
      children: [
        Expanded(
          child: accounts.isEmpty
              ? const Center(child: Text('暂无账号'))
              : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: accounts.length,
                  itemBuilder: (context, index) {
                    final account = accounts[index];
                    return _AccountCard(
                      account: account,
                      onTap: () => _handleSwitchAccount(context, ref, account),
                      onDelete: () => _handleDeleteAccount(context, ref, account),
                    );
                  },
                ),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: ButtonComponent(onPressed: onAddAccount, text: '新增'),
        ),
      ],
    );
  }

  void _handleSwitchAccount(BuildContext context, WidgetRef ref, Account account) {
    if (account.selected) {
      return;
    }
    
    final accountService = ref.read(accountServiceProvider);
    accountService.switchAccount(account.value).then((_) {
      ref.invalidate(accountsProvider);
      _showMessage(context, '已切换到账号: ${account.label}');
    }).catchError((error) {
      _showMessage(context, '切换失败: $error', isError: true);
    });
  }

  void _handleDeleteAccount(BuildContext context, WidgetRef ref, Account account) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('删除账号'),
        content: Text('确定要删除账号 "${account.label}" 吗？'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(false),
            child: const Text('取消'),
          ),
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(true),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('删除'),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final accountService = ref.read(accountServiceProvider);
      accountService.deleteAccount(account.value).then((_) {
        ref.invalidate(accountsProvider);
        _showMessage(context, '账号已删除');
      }).catchError((error) {
        _showMessage(context, '删除失败: $error', isError: true);
      });
    }
  }

  void _showMessage(BuildContext context, String message, {bool isError = false}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(ctx).pop(),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }
}

class _AccountCard extends StatelessWidget {
  final Account account;
  final VoidCallback onTap;
  final VoidCallback onDelete;

  const _AccountCard({
    required this.account,
    required this.onTap,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return AppTheme.cardContainer(
      margin: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: account.disabled ? null : onTap,
          borderRadius: BorderRadius.circular(AppTheme.cardBorderRadius),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppTheme.primaryColor.withValues(alpha: 0.1),
                  child: Text(
                    account.label.isNotEmpty ? account.label[0] : '?',
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        account.label,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (account.tenantName != null && account.tenantName!.isNotEmpty) ...[
                        const SizedBox(height: 2),
                        Text(
                          account.tenantName!,
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.mediumGray,
                          ),
                        ),
                      ],
                      if (account.selected) ...[
                        const SizedBox(height: 4),
                        Text(
                          '当前使用中',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (!account.selected && !account.disabled)
                  IconButton(
                    icon: Icon(Icons.delete_outline, color: Colors.red[400]),
                    onPressed: onDelete,
                  ),
                if (account.selected)
                  Icon(Icons.check_circle, color: AppTheme.primaryColor)
                else if (!account.disabled)
                  Icon(Icons.chevron_right, color: AppTheme.mediumGray),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
