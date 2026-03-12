import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/shared/widgets/button_component.dart';
import 'package:flutter_app/features/home/providers/home_providers.dart';

class ContactDetailScreen extends ConsumerWidget {
  const ContactDetailScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userId = GoRouterState.of(context).extra as String? ?? '';
    final contactState = ref.watch(contactDetailProvider(userId));

    return Scaffold(
      appBar: AppBarComponent(
        title: '联系人详情',
      ),
      body: contactState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : contactState.error != null
              ? Center(child: Text(contactState.error!))
              : contactState.contact == null
                  ? const Center(child: Text('联系人不存在'))
                  : SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            child: Text(contactState.contact?.userName?.substring(0, 1) ?? ''),
                          ),
                          const SizedBox(height: 16),
                          Text(contactState.contact?.userName ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Text(contactState.contact?.position ?? '', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                          const SizedBox(height: 8),
                          Text(contactState.contact?.department ?? '', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                          const SizedBox(height: 24),
                          Card(
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ListTile(
                                    leading: const Icon(Icons.phone),
                                    title: Text(contactState.contact?.phone ?? '无'),
                                    onTap: () {
                                    },
                                  ),
                                  ListTile(
                                    leading: const Icon(Icons.email),
                                    title: Text(contactState.contact?.email ?? '无'),
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
                                await ref.read(contactDetailProvider(userId).notifier).toggleFrequent();
                                if (context.mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text(contactState.isFrequent ? '已从常用联系人中移除' : '已添加到常用联系人')),
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
                            text: contactState.isFrequent ? '取消常用' : '设为常用',
                          ),
                        ],
                      ),
                    ),
    );
  }
}
