import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/features/home/presentation/screens/contact_detail_screen.dart';
import 'package:flutter_app/features/home/providers/home_providers.dart';
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
      body: addressBookState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : addressBookState.error != null
              ? Center(child: Text(addressBookState.error!))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('常用联系人', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      GridView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 4,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: addressBookState.frequentContacts.length,
                        itemBuilder: (context, index) {
                          final contact = addressBookState.frequentContacts[index];
                          return GestureDetector(
                            onTap: () {
                              context.push('/contact-detail', extra: contact.userId);
                            },
                            child: Column(
                              children: [
                                CircleAvatar(
                                  child: Text(contact.userName?.substring(0, 1) ?? ''),
                                ),
                                const SizedBox(height: 8),
                                Text(contact.userName ?? '', style: const TextStyle(fontSize: 12)),
                              ],
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 16),
                      const Text('部门列表', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      ...addressBookState.departments.map((dept) => _buildDepartment(context, dept)),
                    ],
                  ),
                ),
    );
  }

  Widget _buildDepartment(BuildContext context, dynamic dept) {
    return ExpansionTile(
      title: Text(dept.deptName ?? ''),
      children: dept.userModels?.map((user) => ListTile(
            leading: CircleAvatar(
              child: Text(user.userName?.substring(0, 1) ?? ''),
            ),
            title: Text(user.userName ?? ''),
            subtitle: Text(user.position ?? ''),
            onTap: () {
              context.push('/contact-detail', extra: user.userId);
            },
          )).toList() ?? [],
    );
  }
}
