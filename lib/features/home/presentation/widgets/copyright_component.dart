import 'package:flutter/material.dart';

class CopyrightComponent extends StatelessWidget {
  const CopyrightComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('© 2026 企业管理系统', style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant)),
    );
  }
}
