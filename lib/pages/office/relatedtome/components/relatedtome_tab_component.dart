import 'package:flutter/material.dart';
import 'package:flutter_app/components/index.dart';


class RelatedToMeTabComponent extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChanged;

  const RelatedToMeTabComponent({
    Key? key,
    required this.currentIndex,
    required this.onTabChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTabComponent(
      items: [
        CupertinoTabItem(
          text: '已通过',
          onTap: () => onTabChanged(0),
        ),
        CupertinoTabItem(
          text: '审核中',
          onTap: () => onTabChanged(1),
        ),
        CupertinoTabItem(
          text: '未批准',
          onTap: () => onTabChanged(2),
        ),
      ],
      activeIndex: currentIndex,
    );
  }
}
