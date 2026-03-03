import 'package:flutter/material.dart';
import 'package:flutter_app/shared/widgets/tab_component.dart';

class RelatedToMeTabWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChanged;

  const RelatedToMeTabWidget({
    super.key,
    required this.currentIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TabComponent(
      items: [
        TabItem(
          text: '已通过',
          onTap: () => onTabChanged(0),
        ),
        TabItem(
          text: '审核中',
          onTap: () => onTabChanged(1),
        ),
        TabItem(
          text: '未批准',
          onTap: () => onTabChanged(2),
        ),
      ],
      activeIndex: currentIndex,
    );
  }
}
