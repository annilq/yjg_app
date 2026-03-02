import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_app/pages/auth/login_page.dart';
import 'package:flutter_app/pages/auth/reset_password_page.dart';
import 'package:flutter_app/pages/auth/update_password_page.dart';
import 'package:flutter_app/pages/main/main_page.dart';
import 'package:flutter_app/pages/office/backlog/backlog_list_page.dart';
import 'package:flutter_app/pages/notices/notices_list_page.dart';
import 'package:flutter_app/pages/office/relatedtome/relatedtome_list_page.dart';
import 'package:flutter_app/pages/workflow/list/workflow_list_page.dart';
import 'package:flutter_app/pages/workflow/setting/workflow_setting_page.dart';
import 'package:flutter_app/pages/workflow/module_list/module_list_page.dart';
import 'package:flutter_app/pages/workflow/module_setting/module_setting_page.dart';
import 'package:flutter_app/pages/webview/webview_page.dart';
import 'package:flutter_app/theme/theme.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return PlatformApp(
      title: '云建管',
      material: (context, platform) => MaterialAppData(
        theme: AppTheme.themeData,
      ),
      cupertino: (_, __) => CupertinoAppData(
        theme: AppTheme.cupertinoThemeData,
      ),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('zh', 'CN'),
      ],
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/reset-password': (context) => ResetPasswordPage(),
        '/update-password': (context) => UpdatePasswordPage(),
        '/main': (context) => MainPage(),
        '/office/backlog': (context) => BacklogListPage(),
        '/office/relatedtome': (context) => RelatedToMeListPage(),
        '/notices': (context) => NoticesListPage(),
        '/workflow/list': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
          return WorkflowListPage(
            workflowCode: args['workflowCode'] ?? '',
            dataId: args['dataId'] ?? '',
            name: args['name'] ?? '',
          );
        },
        '/workflow/setting': (context) => WorkflowSettingPage(),
        '/workflow/moduleList': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
          return ModuleListPage(
            moduleName: args['moduleName'] ?? '',
          );
        },
        '/workflow/moduleSetting': (context) => ModuleSettingPage(),
        '/webview': (context) {
          final args = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
          return WebviewPage(params: args);
        },
      },
    );
  }
}


