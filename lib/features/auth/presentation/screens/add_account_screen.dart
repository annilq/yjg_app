import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/features/auth/providers/auth_providers.dart';
import 'package:flutter_app/shared/widgets/index.dart';

class AddAccountScreen extends ConsumerStatefulWidget {
  const AddAccountScreen({super.key});

  @override
  ConsumerState<AddAccountScreen> createState() => _AddAccountScreenState();
}

class _AddAccountScreenState extends ConsumerState<AddAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tenantNameController = TextEditingController();
  final _loginNameController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _tenantNameController.dispose();
    _loginNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _validateTenantName(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入组织名';
    }
    return null;
  }

  String? _validateLoginName(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入用户名';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return '请输入密码';
    }
    return null;
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final accountService = ref.read(accountServiceProvider);

      await accountService.addAccount(
        tenantName: _tenantNameController.text,
        loginName: _loginNameController.text,
        password: _passwordController.text,
      );

      if (mounted) {
        ref.invalidate(accountsProvider);

        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('提示'),
            content: const Text('添加成功'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(ctx).pop();
                  context.pop();
                },
                child: const Text('确定'),
              ),
            ],
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('错误'),
            content: Text('添加失败: $e'),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(ctx).pop(),
                child: const Text('确定'),
              ),
            ],
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('新增账号'), centerTitle: true),
      body: Builder(
        builder: (innerContext) => SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                TextFormFieldComponent(
                  controller: _tenantNameController,
                  decoration: const InputDecoration(
                    labelText: '组织名',
                    hintText: '请输入组织名',
                    prefixIcon: Icon(Icons.business),
                  ),
                  validator: _validateTenantName,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormFieldComponent(
                  controller: _loginNameController,
                  decoration: const InputDecoration(
                    labelText: '用户名',
                    hintText: '请输入用户名',
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: _validateLoginName,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(height: 20),
                TextFormFieldComponent(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: '密码',
                    hintText: '请输入密码',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  obscureText: true,
                  validator: _validatePassword,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _submitForm(),
                ),
                const SizedBox(height: 40),
                ButtonComponent(
                  onPressed: _isLoading ? null : _submitForm,
                  text: '添加账号',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
