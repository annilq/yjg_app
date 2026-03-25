import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_app/shared/widgets/main_drawer.dart';

/// 主屏幕 - 采用 Drawer 侧边栏布局
///
/// 左侧滑出抽屉包含个人信息和快捷操作
/// 主体区域为首页内容
class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  ConsumerState<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  /// 打开侧边抽屉
  void _openDrawer() {
    _scaffoldKey.currentState?.openDrawer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: const MainDrawer(),
      body: HomeScreen(onMenuTap: _openDrawer),
    );
  }
}
