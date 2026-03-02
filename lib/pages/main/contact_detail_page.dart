import 'package:flutter/material.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/models/address_book_frequent_response_model.dart';
import 'package:flutter_app/components/index.dart';

class ContactDetailPage extends StatefulWidget {
  final String userId;

  ContactDetailPage({required this.userId});

  @override
  _ContactDetailPageState createState() => _ContactDetailPageState();
}

class _ContactDetailPageState extends State<ContactDetailPage> {
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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_isFrequent ? '已添加到常用联系人' : '已从常用联系人中移除')),
      );
    } catch (e) {
      print('设置常用联系人失败: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('操作失败')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('联系人详情'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _contact == null
              ? Center(child: Text('联系人不存在'))
              : SingleChildScrollView(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        child: Text(_contact?.userName?.substring(0, 1) ?? ''),
                      ),
                      SizedBox(height: 16),
                      Text(_contact?.userName ?? '', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      SizedBox(height: 8),
                      Text(_contact?.position ?? '', style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(height: 8),
                      Text(_contact?.deptName ?? '', style: TextStyle(fontSize: 14, color: Colors.grey)),
                      SizedBox(height: 24),
                      Card(
                        child: Padding(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                leading: Icon(Icons.phone),
                                title: Text(_contact?.phone ?? '无'),
                                onTap: () {
                                  // 拨打电话
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.email),
                                title: Text(_contact?.email ?? '无'),
                                onTap: () {
                                  // 发送邮件
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 24),
                      Button(
                        onPressed: _toggleFrequent,
                        text: _isFrequent ? '取消常用' : '设为常用',
                      ),
                    ],
                  ),
                ),
    );
  }
}
