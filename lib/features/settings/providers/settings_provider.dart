import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../features/game/models/game_state.dart';
import '../../../features/game/models/game_difficulty.dart';

class Settings {
  final bool isSoundEnabled;
  final bool isVibrationEnabled;
  final bool isDarkMode;
  final String language;
  final GameDifficulty defaultDifficulty;
  final GameMode defaultGameMode;

  const Settings({
    required this.isSoundEnabled,
    required this.isVibrationEnabled,
    required this.isDarkMode,
    required this.language,
    required this.defaultDifficulty,
    required this.defaultGameMode,
  });

  Settings copyWith({
    bool? isSoundEnabled,
    bool? isVibrationEnabled,
    bool? isDarkMode,
    String? language,
    GameDifficulty? defaultDifficulty,
    GameMode? defaultGameMode,
  }) {
    return Settings(
      isSoundEnabled: isSoundEnabled ?? this.isSoundEnabled,
      isVibrationEnabled: isVibrationEnabled ?? this.isVibrationEnabled,
      isDarkMode: isDarkMode ?? this.isDarkMode,
      language: language ?? this.language,
      defaultDifficulty: defaultDifficulty ?? this.defaultDifficulty,
      defaultGameMode: defaultGameMode ?? this.defaultGameMode,
    );
  }
}

class SettingsNotifier extends StateNotifier<Settings> {
  final SharedPreferences _prefs;

  SettingsNotifier(this._prefs)
      : super(Settings(
          isSoundEnabled: true,
          isVibrationEnabled: true,
          isDarkMode: false,
          language: 'en',
          defaultDifficulty: GameDifficulty.easy,
          defaultGameMode: GameMode.classic,
        )) {
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    state = Settings(
      isSoundEnabled: _prefs.getBool('sound_enabled') ?? true,
      isVibrationEnabled: _prefs.getBool('vibration_enabled') ?? true,
      isDarkMode: _prefs.getBool('dark_mode') ?? false,
      language: _prefs.getString('language') ?? 'en',
      defaultDifficulty: GameDifficulty.values[_prefs.getInt('default_difficulty') ?? 0],
      defaultGameMode: GameMode.values[_prefs.getInt('default_game_mode') ?? 0],
    );
  }

  Future<void> _saveSettings() async {
    await _prefs.setBool('sound_enabled', state.isSoundEnabled);
    await _prefs.setBool('vibration_enabled', state.isVibrationEnabled);
    await _prefs.setBool('dark_mode', state.isDarkMode);
    await _prefs.setString('language', state.language);
    await _prefs.setInt('default_difficulty', state.defaultDifficulty.index);
    await _prefs.setInt('default_game_mode', state.defaultGameMode.index);
  }

  void toggleSound() {
    state = state.copyWith(isSoundEnabled: !state.isSoundEnabled);
    _saveSettings();
  }

  void toggleVibration() {
    state = state.copyWith(isVibrationEnabled: !state.isVibrationEnabled);
    _saveSettings();
  }

  void toggleDarkMode() {
    final newValue = !state.isDarkMode;
    _prefs.setBool('dark_mode', newValue);
    state = state.copyWith(isDarkMode: newValue);
    _saveSettings();
  }

  void setLanguage(String language) {
    _prefs.setString('language', language);
    state = state.copyWith(language: language);
    _saveSettings();
  }

  void setDefaultDifficulty(GameDifficulty difficulty) {
    state = state.copyWith(defaultDifficulty: difficulty);
    _saveSettings();
  }

  void setDefaultGameMode(GameMode mode) {
    state = state.copyWith(defaultGameMode: mode);
    _saveSettings();
  }
}

final settingsProvider = StateNotifierProvider<SettingsNotifier, Settings>((ref) {
  throw UnimplementedError('Initialize this provider with SharedPreferences in main.dart');
}); 