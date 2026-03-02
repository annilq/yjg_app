import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/models/main_reminds_response_model.dart';
import 'package:flutter_app/theme/theme.dart';

class AnnouncementCarouselComponent extends StatelessWidget {
  final List<RemindModel> reminds;

  const AnnouncementCarouselComponent({
    Key? key,
    required this.reminds,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppTheme.cardContainer(
      child: Row(
        children: [
          // 左侧图标
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(CupertinoIcons.news, color: AppTheme.primaryColor),
          ),
          SizedBox(width: 12),
          // 中间公告轮播
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: reminds.map((remind) => Padding(
                padding: EdgeInsets.symmetric(vertical: 4),
                child: Text(remind.title ?? '', style: AppTheme.bodyStyle),
              )).toList(),
            ),
          ),
          // 右侧箭头图标
          IconButton(
            icon: Icon(CupertinoIcons.chevron_forward, color: AppTheme.mediumGray),
            onPressed: () {
              Navigator.pushNamed(context, '/home/docs');
            },
          ),
        ],
      ),
      margin: EdgeInsets.all(0),
    );
  }
}
