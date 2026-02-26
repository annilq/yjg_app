import 'package:flutter/material.dart';
import 'package:flutter_app/pages/main/home_page.dart';
import 'package:flutter_app/pages/main/workflow_page.dart';
import 'package:flutter_app/pages/main/address_book_page.dart';
import 'package:flutter_app/pages/main/notification_page.dart';
import 'package:flutter_app/pages/main/me_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    HomePage(),
    WorkflowPage(),
    AddressBookPage(),
    NotificationPage(),
    MePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: '首页',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: '工作流',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: '通讯录',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: '通知',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: '我的',
          ),
        ],
      ),
    );
  }
}
