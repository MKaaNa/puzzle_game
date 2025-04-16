import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError();
});

final localeProvider = StateNotifierProvider<LocaleNotifier, String>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return LocaleNotifier(prefs);
});

final localeControllerProvider = Provider<LocaleController>((ref) {
  return LocaleController(ref);
});

class LocaleController {
  final Ref _ref;

  LocaleController(this._ref);

  void setLocale(Locale locale) {
    _ref.read(localeProvider.notifier).state = locale.toString();
  }

  Locale get currentLocale => Locale(_ref.read(localeProvider));
}

class LocaleNotifier extends StateNotifier<String> {
  final SharedPreferences _prefs;
  
  LocaleNotifier(this._prefs) : super(_prefs.getString('language') ?? 'en');
  
  void setLocale(String locale) {
    _prefs.setString('language', locale);
    state = locale;
  }
} 