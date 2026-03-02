import 'package:flutter/material.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/components/app_bar.dart';
import 'package:flutter_app/models/address_book_frequent_response_model.dart';
import 'package:flutter_app/models/address_book_full_response_model.dart';
import 'package:flutter_app/pages/main/contact_detail_page.dart';

class AddressBookPage extends StatefulWidget {
  @override
  _AddressBookPageState createState() => _AddressBookPageState();
}

class _AddressBookPageState extends State<AddressBookPage> {
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
      // 获取常用联系人
      var frequentResponse = await ApiService().getAddressBookFrequent();
      AddressBookFrequentResponseModel frequentModel = AddressBookFrequentResponseModel.fromJson(frequentResponse);
      _frequentContacts = frequentModel.contactModels ?? [];

      // 获取完整通讯录
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
      appBar: CustomAppBar(
        title: '通讯录',
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              // 搜索功能
            },
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 常用联系人
                  Text('常用联系人', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                              builder: (context) => ContactDetailPage(userId: contact.userId ?? ''),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            CircleAvatar(
                              child: Text(contact.userName?.substring(0, 1) ?? ''),
                            ),
                            SizedBox(height: 8),
                            Text(contact.userName ?? '', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      );
                    },
                  ),
                  SizedBox(height: 16),

                  // 部门列表
                  Text('部门列表', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
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
                  builder: (context) => ContactDetailPage(userId: user.userId ?? ''),
                ),
              );
            },
          )).toList() ?? [],
    );
  }
}
