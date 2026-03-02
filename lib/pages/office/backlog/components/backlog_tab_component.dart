import 'package:flutter/material.dart';
import 'package:flutter_app/components/index.dart';


class BacklogTabComponent extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChanged;

  const BacklogTabComponent({
    Key? key,
    required this.currentIndex,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabComponent(
      items: [
        CupertinoTabItem(
          text: '未批复',
          onTap: () => onTabChanged(0),
        ),
        CupertinoTabItem(
          text: '已批复',
          onTap: () => onTabChanged(1),
        ),
      ],
      activeIndex: currentIndex,
    );
  }
}
