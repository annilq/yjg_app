import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/core/theme/app_theme.dart';

class BusinessCard extends StatelessWidget {
  final dynamic item;
  final bool editMode;
  final bool isInUserList;
  final VoidCallback onTap;

  const BusinessCard({
    super.key,
    required this.item,
    required this.editMode,
    required this.isInUserList,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withAlpha(25),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  CupertinoIcons.square_grid_2x2,
                  color: AppTheme.primaryColor,
                  size: 24,
                ),
              ),
              if (editMode)
                Positioned(
                  right: 0,
                  top: 0,
                  child: Icon(
                    isInUserList ? CupertinoIcons.delete : CupertinoIcons.add,
                    color: isInUserList ? Colors.red : Colors.green,
                    size: 16,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            item['text'] ?? '',
            style: AppTheme.smallStyle,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
