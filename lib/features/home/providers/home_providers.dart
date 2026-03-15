import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/features/home/service/home_service.dart';
import 'package:flutter_app/features/home/models/remind_model.dart';

final homeServiceProvider = Provider<HomeService>((ref) {
  return HomeService();
});

final homeScreenProvider = AsyncNotifierProvider<HomeScreenNotifier, HomeScreenData>(
  HomeScreenNotifier.new,
);

class HomeScreenData {
  final List<RemindModel> reminds;
  final int backlogCount;

  HomeScreenData({
    required this.reminds,
    required this.backlogCount,
  });
}

class HomeScreenNotifier extends AsyncNotifier<HomeScreenData> {
  @override
  Future<HomeScreenData> build() async {
    final homeService = ref.read(homeServiceProvider);
    
    final remindsResponse = await homeService.getMainReminds();
    final backlogCount = await homeService.getWorkflowBacklogCount();
    
    return HomeScreenData(
      reminds: remindsResponse.remindModels ?? [],
      backlogCount: backlogCount,
    );
  }
}