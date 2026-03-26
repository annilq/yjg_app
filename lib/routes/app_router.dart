import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter_app/features/auth/presentation/screens/reset_password_screen.dart';
import 'package:flutter_app/features/auth/presentation/screens/update_password_screen.dart';
import 'package:flutter_app/features/auth/presentation/screens/accounts_screen.dart';
import 'package:flutter_app/features/auth/presentation/screens/add_account_screen.dart';
import 'package:flutter_app/features/home/presentation/screens/main_screen.dart';
import 'package:flutter_app/features/contact/presentation/screens/contact_detail_screen.dart';

import 'package:flutter_app/features/notices/presentation/screens/notices_list_screen.dart';
import 'package:flutter_app/features/office/presentation/screens/backlog_list_screen.dart';
import 'package:flutter_app/features/office/presentation/screens/relatedtome_list_screen.dart';
import 'package:flutter_app/features/workflow/presentation/screens/workflow_list_screen.dart';
import 'package:flutter_app/features/workflow/presentation/screens/workflow_setting_screen.dart';
import 'package:flutter_app/features/workflow/presentation/screens/module_list_screen.dart';
import 'package:flutter_app/features/workflow/presentation/screens/module_setting_screen.dart';
import 'package:flutter_app/features/start/presentation/screens/start_screen.dart';
import 'package:flutter_app/features/webview/presentation/screens/webview_screen.dart';
import 'package:flutter_app/features/contact/presentation/screens/contact_screen.dart';
import 'package:flutter_app/features/settings/presentation/screens/settings_screen.dart';

import 'package:flutter_app/features/settings/presentation/screens/language_settings_screen.dart';
import 'package:flutter_app/features/settings/presentation/screens/notification_settings_screen.dart';
import 'package:flutter_app/features/settings/presentation/screens/about_screen.dart';

final routerProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(path: '/', builder: (context, state) => LoginScreen()),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) => ResetPasswordScreen(),
      ),
      GoRoute(
        path: '/update-password',
        builder: (context, state) => UpdatePasswordScreen(),
      ),
      GoRoute(
        path: '/accounts',
        builder: (context, state) => const AccountsScreen(),
      ),
      GoRoute(
        path: '/accounts/add',
        builder: (context, state) => const AddAccountScreen(),
      ),
      GoRoute(path: '/main', builder: (context, state) => MainScreen()),
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
          return ModuleListScreen(moduleName: args?['moduleName'] ?? '');
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
      GoRoute(
        path: '/contact',
        builder: (context, state) => const ContactScreen(),
      ),
      GoRoute(
        path: '/contact-detail',
        builder: (context, state) => const ContactDetailScreen(),
      ),
      GoRoute(
        path: '/settings/language',
        builder: (context, state) => const LanguageSettingsScreen(),
      ),
      GoRoute(
        path: '/settings/notification',
        builder: (context, state) => const NotificationSettingsScreen(),
      ),
      GoRoute(
        path: '/settings/about',
        builder: (context, state) => const AboutScreen(),
      ),
      GoRoute(
        path: '/settings',
        builder: (context, state) => const SettingsScreen(),
      ),
      GoRoute(
        path: '/start',
        builder: (context, state) => const StartScreen(),
      ),
    ],
  );
});
