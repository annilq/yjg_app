import 'package:flutter/material.dart';
import 'package:flutter_app/shared/widgets/tab_component.dart';

class BacklogTabWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChanged;

  const BacklogTabWidget({
    super.key,
    required this.currentIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TabComponent(
      items: [
        TabItem(
          text: '未批复',
          onTap: () => onTabChanged(0),
        ),
        TabItem(
          text: '已批复',
          onTap: () => onTabChanged(1),
        ),
      ],
      activeIndex: currentIndex,
    );
  }
}
