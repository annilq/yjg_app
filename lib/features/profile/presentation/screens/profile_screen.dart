import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/shared/widgets/app_bar_component.dart';
import 'package:flutter_app/shared/widgets/button_component.dart';
import 'package:flutter_app/core/constants/app_images.dart';
import 'package:flutter_app/features/profile/providers/profile_providers.dart';
import 'package:flutter_app/shared/models/login_response_model.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final ImagePicker _imagePicker = ImagePicker();
  LoginResponseModel? _userInfo;

  @override
  void initState() {
    super.initState();
    _loadUserInfo();
  }

  Future<void> _loadUserInfo() async {
    setState(() {
      _userInfo = LoginResponseModel.fromJson({
        'userName': '用户',
        'accountFullName': '用户名',
        'phone': '13800138000',
        'avatar': null,
      });
    });
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  Future<void> _showContactUsDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('联系我们'),
          content: const Text('欢迎拨打云建管人工客服热线：400-006-3359，我们将竭诚为您服务。'),
          actions: [
            CupertinoDialogAction(
              child: const Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text('立即拨号'),
              onPressed: () {
                Navigator.of(context).pop();
                _makePhoneCall('4000063359');
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showClearCacheDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('提示'),
          content: const Text('是否清除缓存'),
          actions: [
            CupertinoDialogAction(
              child: const Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text('确定'),
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await ref.read(profileProvider.notifier).clearCache();
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('清除缓存成功')),
                    );
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('清除缓存失败: $e')),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _showLogoutDialog() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: const Text('提示'),
          content: const Text('是否解除绑定'),
          actions: [
            CupertinoDialogAction(
              child: const Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            CupertinoDialogAction(
              child: const Text('确定'),
              onPressed: () async {
                Navigator.of(context).pop();
                try {
                  await ref.read(profileProvider.notifier).logout();
                  if (mounted) {
                    context.go('/');
                  }
                } catch (e) {
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('解除绑定失败: $e')),
                    );
                  }
                }
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> _pickAvatar() async {
    final XFile? image = await _imagePicker.pickImage(source: ImageSource.gallery);
    if (image != null && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('头像上传功能待完善')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarComponent(
        title: '我的',
        backgroundColor: const Color(0xFFF5F5F5),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildUserInfoSection(),
            _buildMenuSection(),
            _buildActionButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfoSection() {
    return Container(
      height: 130,
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.icon478),
          fit: BoxFit.cover,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 32, left: 16),
        child: Row(
          children: [
            GestureDetector(
              onTap: _pickAvatar,
              child: Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: ClipOval(
                  child: _userInfo?.avatar != null
                      ? Image.network(
                          _userInfo!.avatar!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return Image.asset(AppImages.avatar, fit: BoxFit.cover);
                          },
                        )
                      : Image.asset(AppImages.avatar, fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _userInfo?.userName ?? '用户',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _userInfo?.accountName ?? '',
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.white70,
                    ),
                  ),
                  if (_userInfo?.phone != null)
                    GestureDetector(
                      onTap: () => _makePhoneCall(_userInfo!.phone!),
                      child: Text(
                        _userInfo!.phone!,
                        style: const TextStyle(
                          fontSize: 12,
                          color: Colors.white70,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuSection() {
    final menus = [
      {
        'label': '通讯录',
        'url': '/contact',
      },
      {
        'label': '修改密码',
        'url': '/update-password',
      },
      {
        'label': '多账号管理',
        'url': '/accounts',
      },
    ];

    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            ...menus.map((menu) {
              return ListTile(
                title: Text(menu['label'] as String),
                trailing: const Icon(Icons.chevron_right, color: Colors.grey),
                onTap: () {
                  if (menu['url'] != null && menu['url']!.isNotEmpty) {
                    context.push(menu['url'] as String);
                  }
                },
              );
            }),
            const Divider(height: 1),
            ListTile(
              title: Row(
                children: [
                  Image.asset(
                    AppImages.icon48,
                    width: 14,
                    height: 14,
                  ),
                  const SizedBox(width: 8),
                  const Text('联系我们'),
                ],
              ),
              subtitle: const Text(
                '欢迎咨询与反馈',
                style: TextStyle(fontSize: 12, color: Color(0xFF747476)),
              ),
              onTap: _showContactUsDialog,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButtons() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: ButtonComponent(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black87,
              ),
              onPressed: _showClearCacheDialog,
              text: '清除缓存',
            ),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ButtonComponent(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.red,
              ),
              onPressed: _showLogoutDialog,
              text: '解除绑定',
            ),
          ),
        ],
      ),
    );
  }
}
