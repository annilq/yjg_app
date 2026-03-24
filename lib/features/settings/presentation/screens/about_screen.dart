import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/shared/widgets/snackbar_helper.dart';
import 'package:flutter_app/core/constants/app_images.dart';

class AboutScreen extends ConsumerWidget {
  const AboutScreen({super.key});

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> _showContactDialog(BuildContext context) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('联系我们'),
          content: const Text('欢迎拨打云建管人工客服热线：400-006-3359，我们将竭诚为您服务。'),
          actions: [
            TextButton(
              child: const Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('立即拨号'),
              onPressed: () {
                Navigator.of(context).pop();
                _makePhoneCall('4000063359');
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: const AppBarComponent(
        title: '关于',
      ),
      body: ListView(
        children: [
          const SizedBox(height: 48),
          Center(
            child: Column(
              children: [
                Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.surfaceContainerHighest,
                  ),
                  child: Image.asset(
                    AppImages.logo,
                    fit: BoxFit.contain,
                  ),
                ),
                const SizedBox(height: 16),
                const Text(
                  '云建管',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '版本 1.0.0',
                  style: TextStyle(
                    fontSize: 14,
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 48),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                ListTile(
                  title: const Text('公司简介'),
                  trailing: Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.onSurfaceVariant),
                  onTap: () {
                    _showCompanyInfo(context);
                  },
                ),
                Divider(height: 1, color: Theme.of(context).colorScheme.outlineVariant),
                ListTile(
                  title: const Text('隐私政策'),
                  trailing: Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.onSurfaceVariant),
                  onTap: () {
                    SnackBarHelper.showSnackBar(
                      context,
                      '隐私政策页面开发中',
                    );
                  },
                ),
                Divider(height: 1, color: Theme.of(context).colorScheme.outlineVariant),
                ListTile(
                  title: const Text('用户协议'),
                  trailing: Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.onSurfaceVariant),
                  onTap: () {
                    SnackBarHelper.showSnackBar(
                      context,
                      '用户协议页面开发中',
                    );
                  },
                ),
                Divider(height: 1, color: Theme.of(context).colorScheme.outlineVariant),
                ListTile(
                  title: const Text('联系我们'),
                  trailing: Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.onSurfaceVariant),
                  onTap: () {
                    _showContactDialog(context);
                  },
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          Center(
            child: Text(
              '© 2024 云建管 版权所有',
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onSurfaceVariant,
              ),
            ),
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

  void _showCompanyInfo(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('公司简介'),
          content: const SingleChildScrollView(
            child: Text(
              '云建管是一款专注于建筑行业的企业管理平台，提供项目管理、人员管理、流程审批等功能，帮助企业实现数字化转型。\n\n我们致力于为建筑行业提供最优质的信息化服务，让管理更高效，让协作更便捷。',
            ),
          ),
          actions: [
            TextButton(
              child: const Text('关闭'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}