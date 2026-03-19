import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AppThemeMode { light, dark, system }

final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, AppThemeMode>((ref) {
  return ThemeModeNotifier();
});

class ThemeModeNotifier extends StateNotifier<AppThemeMode> {
  ThemeModeNotifier() : super(AppThemeMode.system);

  void setThemeMode(AppThemeMode mode) {
    state = mode;
  }
}

enum AppLanguage { chinese, english }

final languageProvider = StateNotifierProvider<LanguageNotifier, AppLanguage>((ref) {
  return LanguageNotifier();
});

class LanguageNotifier extends StateNotifier<AppLanguage> {
  LanguageNotifier() : super(AppLanguage.chinese);

  void setLanguage(AppLanguage language) {
    state = language;
  }
}

class NotificationSettings {
  final bool pushEnabled;
  final bool soundEnabled;
  final bool vibrationEnabled;
  final bool workFlowNotification;
  final bool noticeNotification;
  final bool messageNotification;

  const NotificationSettings({
    this.pushEnabled = true,
    this.soundEnabled = true,
    this.vibrationEnabled = true,
    this.workFlowNotification = true,
    this.noticeNotification = true,
    this.messageNotification = true,
  });

  NotificationSettings copyWith({
    bool? pushEnabled,
    bool? soundEnabled,
    bool? vibrationEnabled,
    bool? workFlowNotification,
    bool? noticeNotification,
    bool? messageNotification,
  }) {
    return NotificationSettings(
      pushEnabled: pushEnabled ?? this.pushEnabled,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      vibrationEnabled: vibrationEnabled ?? this.vibrationEnabled,
      workFlowNotification: workFlowNotification ?? this.workFlowNotification,
      noticeNotification: noticeNotification ?? this.noticeNotification,
      messageNotification: messageNotification ?? this.messageNotification,
    );
  }
}

final notificationSettingsProvider = StateNotifierProvider<NotificationSettingsNotifier, NotificationSettings>((ref) {
  return NotificationSettingsNotifier();
});

class NotificationSettingsNotifier extends StateNotifier<NotificationSettings> {
  NotificationSettingsNotifier() : super(const NotificationSettings());

  void togglePushEnabled(bool value) {
    state = state.copyWith(pushEnabled: value);
  }

  void toggleSoundEnabled(bool value) {
    state = state.copyWith(soundEnabled: value);
  }

  void toggleVibrationEnabled(bool value) {
    state = state.copyWith(vibrationEnabled: value);
  }

  void toggleWorkFlowNotification(bool value) {
    state = state.copyWith(workFlowNotification: value);
  }

  void toggleNoticeNotification(bool value) {
    state = state.copyWith(noticeNotification: value);
  }

  void toggleMessageNotification(bool value) {
    state = state.copyWith(messageNotification: value);
  }
}