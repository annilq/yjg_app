import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_app/features/home/models/remind_model.dart';
import 'package:flutter_app/shared/widgets/card_item_component.dart';
import 'package:flutter_app/shared/widgets/business_icon_component.dart';

class AnnouncementCarouselComponent extends StatefulWidget {
  final List<RemindModel> reminds;

  const AnnouncementCarouselComponent({super.key, required this.reminds});

  @override
  State<AnnouncementCarouselComponent> createState() =>
      _AnnouncementCarouselComponentState();
}

class _AnnouncementCarouselComponentState
    extends State<AnnouncementCarouselComponent> {
  int _currentIndex = 0;
  final Duration _scrollDuration = Duration(seconds: 3);
  final Duration _animationDuration = Duration(milliseconds: 500);

  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    Future.delayed(_scrollDuration, () {
      if (mounted && widget.reminds.isNotEmpty) {
        setState(() {
          _currentIndex = (_currentIndex + 1) % widget.reminds.length;
        });
        _startAutoScroll();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return  Row(
        children: [
          Expanded(
            child: SizedBox(
              height: 40,
              child: Stack(
                children: [
                  if (widget.reminds.isNotEmpty)
                    AnimatedPositioned(
                      duration: _animationDuration,
                      curve: Curves.easeInOut,
                      top: _currentIndex * -40.0,
                      left: 0,
                      right: 0,
                      child: Column(
                        children: widget.reminds
                            .map(
                              (remind) => SizedBox(
                                height: 40,
                                child: Row(
                                  children: [
                                    // 左侧图标
                                    BusinessIcon(formKey: remind.formKey??"",size: 24),
                                    SizedBox(width: 12),
                                    Expanded(
                                      child: Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          remind.title ?? '',
                                          style: textTheme.bodyMedium?.copyWith(
                                            color: colorScheme.onSurface,
                                          ),
                                        ),
                                      ),
                                    ),
                                    CardItemComponent.countBadge(remind.count!),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    )
                  else
                    SizedBox(
                      height: 40,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '暂无公告',
                          style: textTheme.bodyMedium?.copyWith(
                            color: colorScheme.onSurface,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ),
          // 右侧箭头图标
          IconButton(
            icon: Icon(
              CupertinoIcons.chevron_forward,
              color: colorScheme.onSurfaceVariant,
            ),
            onPressed: () {
              context.push('/notices');
            },
          ),
        ],
      );
  }
}
