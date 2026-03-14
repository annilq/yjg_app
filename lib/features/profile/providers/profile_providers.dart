import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_app/features/profile/service/profile_service.dart';
import 'package:flutter_app/shared/models/login_response_model.dart';

final profileServiceProvider = Provider<ProfileService>((ref) {
  return ProfileService();
});

final profileProvider = AsyncNotifierProvider<ProfileNotifier, LoginResponseModel?>(
  ProfileNotifier.new,
);

class ProfileNotifier extends AsyncNotifier<LoginResponseModel?> {
  late final ProfileService _profileService;

  @override
  Future<LoginResponseModel?> build() async {
    _profileService = ref.read(profileServiceProvider);
    return null;
  }

  Future<void> clearCache() async {
    await _profileService.clearCache();
  }

  Future<void> logout() async {
    await _profileService.unbind();
    state = const AsyncValue.data(null);
  }
}
