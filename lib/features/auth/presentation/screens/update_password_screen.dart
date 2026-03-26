import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/core/theme/tokens/tokens.dart';
import 'package:flutter_app/features/auth/providers/auth_providers.dart';
import 'package:flutter_app/shared/widgets/index.dart';

class UpdatePasswordScreen extends ConsumerStatefulWidget {
  const UpdatePasswordScreen({super.key});

  @override
  ConsumerState<UpdatePasswordScreen> createState() =>
      _UpdatePasswordScreenState();
}

class _UpdatePasswordScreenState extends ConsumerState<UpdatePasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _oldPwd = TextEditingController();
  final _newPwd = TextEditingController();
  final _confirmPwd = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _oldPwd.dispose();
    _newPwd.dispose();
    _confirmPwd.dispose();
    super.dispose();
  }

  Future<int> _getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt('userId') ?? 0;
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    try {
      final userId = await _getUserId();
      await ref.read(authProvider.notifier).updatePassword({
        'id': userId,
        'oldPasswd': _oldPwd.text,
        'newPasswd': _newPwd.text,
        'confirmPasswd': _confirmPwd.text,
      });
      if (mounted) {
        showDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: const Text('提示'),
            content: const Text('密码修改成功'),
            actions: [
              CupertinoDialogAction(
                child: const Text('确定'),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (ctx) => CupertinoAlertDialog(
            title: const Text('错误'),
            content: Text(e.toString()),
            actions: [
              CupertinoDialogAction(
                child: const Text('确定'),
                onPressed: () => Navigator.of(ctx).pop(),
              ),
            ],
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  OutlineInputBorder _border(BuildContext context, {bool focused = false}) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return OutlineInputBorder(
      borderRadius: AppRadius.inputRadius,
      borderSide: BorderSide(
        color: focused
            ? Theme.of(context).colorScheme.primary
            : (isDark ? DarkColors.border : LightColors.border),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor = isDark ? DarkColors.surface : LightColors.surface;

    return Scaffold(
      backgroundColor: isDark ? DarkColors.background : LightColors.background,
      appBar: AppBarComponent(title: '修改密码'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
        child: Container(
          margin: const EdgeInsets.only(top: AppSpacing.xxl),
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: AppRadius.allSm,
          ),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormFieldComponent(
                  controller: _oldPwd,
                  decoration: InputDecoration(
                    labelText: '旧密码',
                    hintText: '请输入旧密码',
                    prefixIcon:
                        const Icon(CupertinoIcons.lock, size: 18),
                    border: _border(context),
                    enabledBorder: _border(context),
                    focusedBorder: _border(context, focused: true),
                  ),
                  obscureText: true,
                  validator: (v) =>
                      (v == null || v.isEmpty) ? '请输入旧密码' : null,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppSpacing.lg),
                TextFormFieldComponent(
                  controller: _newPwd,
                  decoration: InputDecoration(
                    labelText: '新密码',
                    hintText: '请输入新密码',
                    prefixIcon:
                        const Icon(CupertinoIcons.lock, size: 18),
                    border: _border(context),
                    enabledBorder: _border(context),
                    focusedBorder: _border(context, focused: true),
                  ),
                  obscureText: true,
                  validator: (v) =>
                      (v == null || v.isEmpty) ? '请输入新密码' : null,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: AppSpacing.lg),
                TextFormFieldComponent(
                  controller: _confirmPwd,
                  decoration: InputDecoration(
                    labelText: '确认新密码',
                    hintText: '请再次输入新密码',
                    prefixIcon:
                        const Icon(CupertinoIcons.lock, size: 18),
                    border: _border(context),
                    enabledBorder: _border(context),
                    focusedBorder: _border(context, focused: true),
                  ),
                  obscureText: true,
                  validator: (v) {
                    if (v == null || v.isEmpty) return '请确认新密码';
                    if (v != _newPwd.text) return '两次密码不一致';
                    return null;
                  },
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submit(),
                ),
                const SizedBox(height: AppSpacing.xxl),
                ButtonComponent(
                  onPressed: _isLoading ? null : _submit,
                  text: '确定',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
