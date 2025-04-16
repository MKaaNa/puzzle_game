import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = [
    Locale('en'),
    Locale('tr'),
  ];

  // Game related strings
  String get startGame => Intl.message('Start Game', name: 'startGame');
  String get gameOver => Intl.message('Game Over', name: 'gameOver');
  String get moves => Intl.message('Moves', name: 'moves');
  String get time => Intl.message('Time', name: 'time');
  String get score => Intl.message('Score', name: 'score');
  String get hints => Intl.message('Hints', name: 'hints');
  String get restart => Intl.message('Restart', name: 'restart');
  String get next => Intl.message('Next', name: 'next');
  String get back => Intl.message('Back', name: 'back');

  // Game modes
  String get classicMode => Intl.message('Classic Mode', name: 'classicMode');
  String get timeMode => Intl.message('Time Mode', name: 'timeMode');
  String get limitedMoves => Intl.message('Limited Moves', name: 'limitedMoves');
  String get dailyChallenge => Intl.message('Daily Challenge', name: 'dailyChallenge');

  // Difficulty levels
  String get easy => Intl.message('Easy', name: 'easy');
  String get medium => Intl.message('Medium', name: 'medium');
  String get hard => Intl.message('Hard', name: 'hard');
  String get expert => Intl.message('Expert', name: 'expert');

  // Settings
  String get settings => Intl.message('Settings', name: 'settings');
  String get language => Intl.message('Language', name: 'language');
  String get sound => Intl.message('Sound', name: 'sound');
  String get music => Intl.message('Music', name: 'music');
  String get vibration => Intl.message('Vibration', name: 'vibration');
  String get theme => Intl.message('Theme', name: 'theme');

  // Premium features
  String get premium => Intl.message('Premium', name: 'premium');
  String get unlockPremium => Intl.message('Unlock Premium', name: 'unlockPremium');
  String get premiumFeatures => Intl.message('Premium Features', name: 'premiumFeatures');
  String get unlimitedHints => Intl.message('Unlimited Hints', name: 'unlimitedHints');
  String get noAds => Intl.message('No Ads', name: 'noAds');
  String get allThemes => Intl.message('All Themes', name: 'allThemes');
  String get detailedStats => Intl.message('Detailed Stats', name: 'detailedStats');

  // Community
  String get community => Intl.message('Community', name: 'community');
  String get leaderboard => Intl.message('Leaderboard', name: 'leaderboard');
  String get challenges => Intl.message('Challenges', name: 'challenges');
  String get friends => Intl.message('Friends', name: 'friends');
  String get achievements => Intl.message('Achievements', name: 'achievements');
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'tr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
} 