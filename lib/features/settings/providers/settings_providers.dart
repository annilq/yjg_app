import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AppThemeMode { light, dark, system }

// ── SharedPreferences 异步初始化 ──────────────────────────────
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be overridden in ProviderScope');
});

// ── ThemeMode Provider ────────────────────────────────────────
final themeModeProvider = StateNotifierProvider<ThemeModeNotifier, AppThemeMode>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ThemeModeNotifier(prefs);
});

class ThemeModeNotifier extends StateNotifier<AppThemeMode> {
  static const _key = 'app_theme_mode';
  final SharedPreferences _prefs;

  ThemeModeNotifier(this._prefs) : super(_load(_prefs));

  static AppThemeMode _load(SharedPreferences prefs) {
    final saved = prefs.getString(_key);
    switch (saved) {
      case 'light':
        return AppThemeMode.light;
      case 'dark':
        return AppThemeMode.dark;
      default:
        return AppThemeMode.system;
    }
  }

  Future<void> setThemeMode(AppThemeMode mode) async {
    state = mode;
    await _prefs.setString(_key, mode.name);
  }
}

// ── 将 AppThemeMode → Flutter ThemeMode ──────────────────────
extension AppThemeModeX on AppThemeMode {
  ThemeMode toFlutterThemeMode() {
    switch (this) {
      case AppThemeMode.light:
        return ThemeMode.light;
      case AppThemeMode.dark:
        return ThemeMode.dark;
      case AppThemeMode.system:
        return ThemeMode.system;
    }
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