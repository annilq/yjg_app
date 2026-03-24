import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/features/auth/providers/auth_providers.dart';

class UpdatePasswordScreen extends ConsumerStatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  ConsumerState<UpdatePasswordScreen> createState() => _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends ConsumerState<UpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  
  bool _isLoading = false;

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  String? _validateOldPassword(String? value) {
    if (value == null || value.isEmpty) {
      return '原密码不能为空';
    }
    return null;
  }

  String? _validateNewPassword(String? value) {
    if (value == null || value.isEmpty) {
      return '新密码不能为空';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return '确认密码不能为空';
    }
    if (value != _newPasswordController.text) {
      return '新密码与确认密码不同';
    }
    return null;
  }

  Future<int> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId') ?? 0;
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final userId = await _getUserId();
      
      final params = {
        'id': userId,
        'oldPasswd': _oldPasswordController.text,
        'newPasswd': _newPasswordController.text,
        'confirmPasswd': _confirmPasswordController.text,
      };

      await ref.read(authProvider.notifier).updatePassword(params);

      if (mounted) {
        _showSuccessDialog();
      }
    } catch (e) {
      if (mounted) {
        _showErrorDialog(e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('提示'),
        content: const Text('密码修改成功'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
            },
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('错误'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('确定'),
          ),
        ],
      ),
    );
  }

  InputDecoration _buildInputDecoration({
    required BuildContext context,
    required String labelText,
    required String hintText,
    required IconData prefixIcon,
  }) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final outlineColor = colorScheme.outline.withValues(alpha: 0.5);

    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      prefixIcon: Icon(prefixIcon),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: colorScheme.primary, width: 2.0),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: outlineColor, width: 1.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: colorScheme.error, width: 1.0),
      ),
      hintStyle: textTheme.bodyMedium?.copyWith(
        color: colorScheme.onSurfaceVariant,
      ),
      labelStyle: textTheme.bodyMedium,
    );
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('修改密码'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 20),
              TextFormField(
                controller: _oldPasswordController,
                decoration: _buildInputDecoration(
                  context: context,
                  labelText: '旧密码',
                  hintText: '请输入旧密码',
                  prefixIcon: Icons.lock_outline,
                ),
                obscureText: true,
                validator: _validateOldPassword,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _newPasswordController,
                decoration: _buildInputDecoration(
                  context: context,
                  labelText: '新密码',
                  hintText: '请输入新密码',
                  prefixIcon: Icons.lock,
                ),
                obscureText: true,
                validator: _validateNewPassword,
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _confirmPasswordController,
                decoration: _buildInputDecoration(
                  context: context,
                  labelText: '确认新密码',
                  hintText: '请再次输入新密码',
                  prefixIcon: Icons.lock_outline,
                ),
                obscureText: true,
                validator: _validateConfirmPassword,
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (_) => _submitForm(),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 48,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _submitForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: colorScheme.primary,
                    foregroundColor: colorScheme.onPrimary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: _isLoading
                      ? SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            color: colorScheme.onPrimary,
                            strokeWidth: 2,
                          ),
                        )
                      : const Text(
                          '确定',
                          style: TextStyle(fontSize: 16),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
