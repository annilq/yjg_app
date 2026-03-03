import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/models/address_book_frequent_response_model.dart';
import 'package:flutter_app/shared/widgets/index.dart';

class ContactDetailScreen extends ConsumerStatefulWidget {
  final String userId;

  const ContactDetailScreen({super.key, required this.userId});

  @override
  ConsumerState<ContactDetailScreen> createState() => _ContactDetailScreenState();
}

class _ContactDetailScreenState extends ConsumerState<ContactDetailScreen> {
  ContactModel? _contact;
  bool _isLoading = true;
  bool _isFrequent = false;

  @override
  void initState() {
    super.initState();
    _loadContactDetail();
  }

  Future<void> _loadContactDetail() async {
    try {
      var response = await ApiService().getAddressBookUserDetail(widget.userId);
      _contact = ContactModel.fromJson(response);
      setState(() {
        _isFrequent = _contact?.isFrequent ?? false;
      });
    } catch (e) {
      print('加载联系人详情失败: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _toggleFrequent() async {
    try {
      await ApiService().setAddressBookContactFrequent(widget.userId, !_isFrequent);
      setState(() {
        _isFrequent = !_isFrequent;
      });
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(_isFrequent ? '已添加到常用联系人' : '已从常用联系人中移除')),
        );
      }
    } catch (e) {
      print('设置常用联系人失败: $e');
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('操作失败')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: '联系人详情',
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _contact == null
              ? const Center(child: Text('联系人不存在'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        child: Text(_contact?.userName?.substring(0, 1) ?? ''),
                      ),
                      const SizedBox(height: 16),
                      Text(_contact?.userName ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text(_contact?.position ?? '', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 8),
                      Text(_contact?.deptName ?? '', style: const TextStyle(fontSize: 14, color: Colors.grey)),
                      const SizedBox(height: 24),
                      Card(
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: const Icon(Icons.phone),
                                title: Text(_contact?.phone ?? '无'),
                                onTap: () {
                                },
                              ),
                              ListTile(
                                leading: const Icon(Icons.email),
                                title: Text(_contact?.email ?? '无'),
                                onTap: () {
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      ButtonComponent(
                        onPressed: _toggleFrequent,
                        text: _isFrequent ? '取消常用' : '设为常用',
                      ),
                    ],
                  ),
                ),
    );
  }
}
