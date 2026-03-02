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
        '/office/notices': (context) => NoticesListPage(),
        '/office/relatedtome': (context) => RelatedToMeListPage(),
      },
    );
  }
}


