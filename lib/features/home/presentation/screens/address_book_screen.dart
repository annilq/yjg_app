import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/models/address_book_frequent_response_model.dart';
import 'package:flutter_app/models/address_book_full_response_model.dart';
import 'package:flutter_app/features/home/presentation/screens/contact_detail_screen.dart';

class AddressBookScreen extends ConsumerStatefulWidget {
  const AddressBookScreen({super.key});

  @override
  ConsumerState<AddressBookScreen> createState() => _AddressBookScreenState();
}

class _AddressBookScreenState extends ConsumerState<AddressBookScreen> {
  List<ContactModel> _frequentContacts = [];
  List<DeptModel> _departments = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    try {
      var frequentResponse = await ApiService().getAddressBookFrequent();
      AddressBookFrequentResponseModel frequentModel = AddressBookFrequentResponseModel.fromJson(frequentResponse);
      _frequentContacts = frequentModel.contactModels ?? [];

      var fullResponse = await ApiService().getAddressBookFull();
      AddressBookFullResponseModel fullModel = AddressBookFullResponseModel.fromJson(fullResponse);
      _departments = fullModel.deptModels ?? [];
    } catch (e) {
      print('加载数据失败: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
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
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
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
                    itemCount: _frequentContacts.length,
                    itemBuilder: (context, index) {
                      ContactModel contact = _frequentContacts[index];
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ContactDetailScreen(userId: contact.userId ?? ''),
                            ),
                          );
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
                  ..._departments.map((dept) => _buildDepartment(dept)),
                ],
              ),
            ),
    );
  }

  Widget _buildDepartment(DeptModel dept) {
    return ExpansionTile(
      title: Text(dept.deptName ?? ''),
      children: dept.userModels?.map((user) => ListTile(
            leading: CircleAvatar(
              child: Text(user.userName?.substring(0, 1) ?? ''),
            ),
            title: Text(user.userName ?? ''),
            subtitle: Text(user.position ?? ''),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ContactDetailScreen(userId: user.userId ?? ''),
                ),
              );
            },
          )).toList() ?? [],
    );
  }
}
