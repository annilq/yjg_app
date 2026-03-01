import 'package:flutter/material.dart';

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
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(0),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: currentIndex == 0 ? Theme.of(context).primaryColor : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  '已通过',
                  style: TextStyle(
                    color: currentIndex == 0 ? Theme.of(context).primaryColor : Colors.grey,
                    fontWeight: currentIndex == 0 ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(1),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: currentIndex == 1 ? Theme.of(context).primaryColor : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  '审核中',
                  style: TextStyle(
                    color: currentIndex == 1 ? Theme.of(context).primaryColor : Colors.grey,
                    fontWeight: currentIndex == 1 ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => onTabChanged(2),
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      color: currentIndex == 2 ? Theme.of(context).primaryColor : Colors.transparent,
                      width: 2,
                    ),
                  ),
                ),
                child: Text(
                  '未批准',
                  style: TextStyle(
                    color: currentIndex == 2 ? Theme.of(context).primaryColor : Colors.grey,
                    fontWeight: currentIndex == 2 ? FontWeight.bold : FontWeight.normal,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
