import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/features/start/services/start_service.dart';

final startServiceProvider = Provider<StartService>((ref) {
  return StartService();
});

final categoriesProvider = FutureProvider<List<dynamic>>((ref) async {
  final service = ref.watch(startServiceProvider);
  // 暂时使用模拟数据，实际项目中应该调用getCategories()
  return service.getMockCategories();
});
