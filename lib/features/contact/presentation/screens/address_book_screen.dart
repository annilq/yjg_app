import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/features/contact/providers/contact_providers.dart';
import 'package:go_router/go_router.dart';

class AddressBookScreen extends ConsumerWidget {
  const AddressBookScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final addressBookState = ref.watch(addressBookProvider);

    return Scaffold(
      appBar: AppBarComponent(
        title: '通讯录',
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
            },
          ),
        ],
      ),
      body: addressBookState.when(
        data: (departments) => SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('部门列表', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              const SizedBox(height: 8),
              ...departments.map((dept) => _buildDepartment(context, dept)),
            ],
          ),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('加载失败: $error')),
      ),
    );
  }

  Widget _buildDepartment(BuildContext context, dynamic dept) {
    List<Widget> children = [];
    if (dept.children != null) {
      for (var user in dept.children) {
        children.add(ListTile(
          leading: CircleAvatar(
            child: Text(user.name?.substring(0, 1) ?? ''),
          ),
          title: Text(user.name ?? ''),
          subtitle: Text(user.position ?? ''),
          onTap: () {
            context.push('/contact-detail', extra: user.userId);
          },
        ));
      }
    }

    return ExpansionTile(
      title: Text(dept.name ?? ''),
      children: children,
    );
  }
}