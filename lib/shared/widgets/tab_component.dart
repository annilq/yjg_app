import 'package:flutter/material.dart';

class TabComponent extends StatelessWidget {
  final List<TabItem> items;
  final int activeIndex;

  const TabComponent({
    Key? key,
    required this.items,
    required this.activeIndex,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Colors.grey[100],
      ),
      child: Row(
        children: List.generate(
          items.length,
          (index) {
            final item = items[index];
            bool isActive = activeIndex == index;
            return Expanded(
              child: GestureDetector(
                onTap: item.onTap,
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: isActive ? Theme.of(context).primaryColor : Colors.transparent,
                    borderRadius: BorderRadius.horizontal(
                      left: index == 0 ? Radius.circular(24) : Radius.zero,
                      right: index == items.length - 1 ? Radius.circular(24) : Radius.zero,
                    ),
                  ),
                  child: Text(
                    item.text,
                    style: TextStyle(
                      color: isActive ? Colors.white : Colors.grey[700],
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      fontSize: 14,
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

class TabItem {
  final String text;
  final Function() onTap;

  const TabItem({
    required this.text,
    required this.onTap,
  });
}
