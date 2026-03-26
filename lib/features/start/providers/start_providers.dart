import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/features/start/services/start_service.dart';

final startServiceProvider = Provider<StartService>((ref) {
  return StartService();
});

final categoriesProvider = FutureProvider<List<dynamic>>((ref) async {
  final service = ref.watch(startServiceProvider);
  return service.getCategories();
});
