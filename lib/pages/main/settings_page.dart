import 'package:flutter/material.dart';
import 'package:flutter_app/network/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _pushEnabled = false;
  int _leftDays = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    try {
      // 获取推送状态
      _pushEnabled = await ApiService().getPushStatus();

      // 获取剩余天数
      _leftDays = await ApiService().getLeftDays();
    } catch (e) {
      print('加载设置失败: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _togglePush() async {
    try {
      // 这里需要获取设备的 registrationId，实际项目中应该从推送服务获取
      String registrationId = 'test_registration_id';
      await ApiService().togglePushStatus(registrationId);
      setState(() {
        _pushEnabled = !_pushEnabled;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_pushEnabled ? '推送已开启' : '推送已关闭')),
      );
    } catch (e) {
      print('切换推送状态失败: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('操作失败')),
      );
    }
  }

  Future<void> _clearCache() async {
    try {
      // 清理缓存
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('menuCache');
      await prefs.remove('workflowCache');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('缓存已清理')),
      );
    } catch (e) {
      print('清理缓存失败: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('操作失败')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('系统设置'),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                ListTile(
                  title: Text('推送通知'),
                  trailing: Switch(
                    value: _pushEnabled,
                    onChanged: (value) {
                      _togglePush();
                    },
                  ),
                ),
                Divider(),
                ListTile(
                  title: Text('清理缓存'),
                  trailing: Icon(Icons.arrow_right),
                  onTap: _clearCache,
                ),
                Divider(),
                ListTile(
                  title: Text('系统剩余天数'),
                  trailing: Text('$_leftDays 天'),
                ),
                Divider(),
                ListTile(
                  title: Text('版本信息'),
                  trailing: Text('1.0.0'),
                ),
              ],
            ),
    );
  }
}
