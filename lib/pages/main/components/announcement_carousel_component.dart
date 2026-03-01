import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/main_reminds_response_model.dart';

class AnnouncementCarouselComponent extends StatelessWidget {
  final List<RemindModel> reminds;

  const AnnouncementCarouselComponent({
    Key? key,
    required this.reminds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Row(
          children: [
            // 左侧图标
            Icon(CupertinoIcons.news, color: Colors.blue),
            SizedBox(width: 12),
            // 中间公告轮播
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: reminds.map((remind) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 4),
                  child: Text(remind.title ?? '', style: TextStyle(fontSize: 14)),
                )).toList(),
              ),
            ),
            // 右侧箭头图标
            IconButton(
              icon: Icon(CupertinoIcons.chevron_forward),
              onPressed: () {
                Navigator.pushNamed(context, '/home/docs');
              },
            ),
          ],
        ),
      ),
    );
  }
}
