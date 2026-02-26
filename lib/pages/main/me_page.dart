import 'package:flutter/material.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:flutter_app/pages/auth/update_password_page.dart';
import 'package:flutter_app/pages/main/settings_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class MePage extends StatefulWidget {
  @override
  _MePageState createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  String? _userName;
  String? _accountName;
  String? _avatar;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      _userName = prefs.getString('userName');
      _accountName = prefs.getString('accountName');
      _avatar = prefs.getString('avatar');
      _isLoading = false;
    });
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        String imageUrl = await ApiService().uploadAvatar(File(pickedFile.path));
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('avatar', imageUrl);
        setState(() {
          _avatar = imageUrl;
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('头像上传成功')),
        );
      } catch (e) {
        print('头像上传失败: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('头像上传失败')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacementNamed(context, '/');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('我的'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                // 用户信息
                Container(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap: _pickImage,
                        child: CircleAvatar(
                          radius: 50,
                          backgroundImage: _avatar != null ? NetworkImage(_avatar!) : null,
                          child: _avatar == null ? Text(_userName?.substring(0, 1) ?? '') : null,
                        ),
                      ),
                      SizedBox(height: 16),
                      Text(_userName ?? '', style: TextStyle(fontSize: 18)),
                      Text(_accountName ?? '', style: TextStyle(fontSize: 14, color: Colors.grey)),
                    ],
                  ),
                ),

                // 功能列表
                ListTile(
                  title: Text('修改密码'),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.pushNamed(context, '/update-password');
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('系统设置'),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('关于我们'),
                  trailing: Icon(Icons.arrow_right),
                  onTap: () {
                    // 关于我们
                  },
                ),
                Divider(),
                ListTile(
                  title: Text('退出登录'),
                  trailing: Icon(Icons.arrow_right),
                  onTap: _logout,
                ),
              ],
            ),
    );
  }
}
