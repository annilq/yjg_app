import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/shared/widgets/button_component.dart';
import 'package:flutter_app/features/contact/providers/contact_providers.dart';

class ContactDetailScreen extends ConsumerWidget {
  const ContactDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = GoRouterState.of(context).extra;
    // 处理 userId 的类型转换，支持 int 和 String 类型
    String userIdStr;
    if (userId is int) {
      userIdStr = userId.toString();
    } else if (userId is String) {
      userIdStr = userId;
    } else {
      userIdStr = '';
    }
    final contactState = ref.watch(contactDetailProvider(userIdStr));

    return Scaffold(
      appBar: AppBarComponent(
        title: '联系人详情',
      ),
      body: contactState.when(
        data: (contact) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                child: Text(contact.name?.substring(0, 1) ?? ''),
              ),
              const SizedBox(height: 16),
              Text(contact.name ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              Text(contact.position ?? '', style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 8),
              Text(contact.dept ?? '', style: const TextStyle(fontSize: 14, color: Colors.grey)),
              const SizedBox(height: 24),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.phone),
                        title: Text(contact.phone ?? '无'),
                        onTap: () {
                        },
                      ),
                      ListTile(
                        leading: const Icon(Icons.email),
                        title: Text(contact.email ?? '无'),
                        onTap: () {
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              ButtonComponent(
                onPressed: () async {
                  try {
                    await ref.read(contactDetailProvider(userIdStr).notifier).toggleFrequent();
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(contact.fc ?? false ? '已从常用联系人中移除' : '已添加到常用联系人')),
                      );
                    }
                  } catch (e) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('操作失败')),
                      );
                    }
                  }
                },
                text: (contact.fc ?? false) ? '取消常用' : '设为常用',
              ),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('加载失败: $error')),
      ),
    );
  }
}