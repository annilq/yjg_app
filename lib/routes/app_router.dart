import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/core/theme/app_theme.dart';
import 'package:flutter_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_app/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:flutter_app/features/auth/presentation/screens/update_password_screen.dart';
import 'package:flutter_app/features/home/presentation/screens/main_screen.dart';
import 'package:flutter_app/features/home/presentation/screens/home_screen.dart';
import 'package:flutter_app/features/home/presentation/screens/address_book_screen.dart';
import 'package:flutter_app/features/home/presentation/screens/contact_detail_screen.dart';
import 'package:flutter_app/features/notices/presentation/screens/notices_list_screen.dart';
import 'package:flutter_app/features/office/presentation/screens/backlog_list_screen.dart';
import 'package:flutter_app/features/office/presentation/screens/relatedtome_list_screen.dart';
import 'package:flutter_app/features/workflow/presentation/screens/workflow_list_screen.dart';
import 'package:flutter_app/features/workflow/presentation/screens/workflow_setting_screen.dart';
import 'package:flutter_app/features/workflow/presentation/screens/module_list_screen.dart';
import 'package:flutter_app/features/workflow/presentation/screens/module_setting_screen.dart';
import 'package:flutter_app/features/webview/presentation/screens/webview_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) => ResetPasswordScreen(),
      ),
      GoRoute(
        path: '/update-password',
        builder: (context, state) => UpdatePasswordScreen(),
      ),
      GoRoute(
        path: '/main',
        builder: (context, state) => MainScreen(),
      ),
      GoRoute(
        path: '/office/backlog',
        builder: (context, state) => BacklogListScreen(),
      ),
      GoRoute(
        path: '/office/relatedtome',
        builder: (context, state) => RelatedToMeListScreen(),
      ),
      GoRoute(
        path: '/notices',
        builder: (context, state) => NoticesListScreen(),
      ),
      GoRoute(
        path: '/workflow/list',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return WorkflowListScreen(
            workflowCode: args?['workflowCode']?.toString() ?? '',
            dataId: args?['dataId']?.toString() ?? '',
            name: args?['name'] ?? '',
          );
        },
      ),
      GoRoute(
        path: '/workflow/setting',
        builder: (context, state) => WorkflowSettingScreen(),
      ),
      GoRoute(
        path: '/workflow/moduleList',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return ModuleListScreen(
            moduleName: args?['moduleName'] ?? '',
          );
        },
      ),
      GoRoute(
        path: '/workflow/moduleSetting',
        builder: (context, state) => ModuleSettingScreen(),
      ),
      GoRoute(
        path: '/webview',
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>?;
          return WebviewScreen(params: args ?? {});
        },
      ),
    ],
  );
});
