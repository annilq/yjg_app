import 'package:flutter/material.dart';
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
    return MaterialApp(
      title: '云建管',
      theme: AppTheme.themeData,
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


