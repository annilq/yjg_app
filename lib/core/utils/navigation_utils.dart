import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// 导航工具类
class NavigationUtils {
  /// 跳转到详情页面
  /// [context] 上下文
  /// [item] 列表项数据
  /// [type] 类型，用于区分不同的业务逻辑
  static void goToDetail(
    BuildContext context,
    WidgetRef ref,
    dynamic item,
    String type,
  ) {
    switch (type) {
      case 'workflow':
        _goWorkflowDetail(context, ref, item);
        break;
      case 'backlog':
        _goBacklogDetail(context, item);
        break;
      case 'relatedtome':
        _goRelatedToMeDetail(context, item);
        break;
    }
  }

  /// 跳转到流程详情
  static void _goWorkflowDetail(
    BuildContext context,
    WidgetRef ref,
    Map<String, dynamic> item,
  ) {
    // 这里需要根据实际的 provider 实现
    // 暂时使用占位逻辑
    final params = {
      'formKey': item['formKey'] ?? '',
      'processType': 'SEARCH',
      'url': '',
      'data': {'id': item['id']},
    };
    context.push('/webview', extra: params);
  }

  /// 跳转到待办详情
  static void _goBacklogDetail(BuildContext context, dynamic item) {
    final params = {
      'formKey': 'backlog_form',
      'processType': 'SEARCH',
      'url': '',
      'data': {'id': item.id ?? ''},
    };
    context.push('/webview', extra: params);
  }

  /// 跳转到我发起的详情
  static void _goRelatedToMeDetail(BuildContext context, dynamic item) {
    final params = {
      'formKey': 'relatedtome_form',
      'processType': 'SEARCH',
      'url': '',
      'data': {'id': item.id ?? ''},
    };
    context.push('/webview', extra: params);
  }
}
