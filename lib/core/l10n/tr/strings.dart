import 'package:intl/intl.dart';

class Strings {
  static String startGame() => Intl.message('Oyunu Başlat', name: 'startGame');
  static String gameOver() => Intl.message('Oyun Bitti', name: 'gameOver');
  static String moves() => Intl.message('Hamleler', name: 'moves');
  static String time() => Intl.message('Süre', name: 'time');
  static String score() => Intl.message('Puan', name: 'score');
  static String hints() => Intl.message('İpuçları', name: 'hints');
  static String restart() => Intl.message('Yeniden Başla', name: 'restart');
  static String next() => Intl.message('İleri', name: 'next');
  static String back() => Intl.message('Geri', name: 'back');

  // Game modes
  static String classicMode() => Intl.message('Klasik Mod', name: 'classicMode');
  static String timeMode() => Intl.message('Zaman Modu', name: 'timeMode');
  static String limitedMoves() => Intl.message('Sınırlı Hamle', name: 'limitedMoves');
  static String dailyChallenge() => Intl.message('Günlük Görev', name: 'dailyChallenge');

  // Difficulty levels
  static String easy() => Intl.message('Kolay', name: 'easy');
  static String medium() => Intl.message('Orta', name: 'medium');
  static String hard() => Intl.message('Zor', name: 'hard');
  static String expert() => Intl.message('Uzman', name: 'expert');

  // Settings
  static String settings() => Intl.message('Ayarlar', name: 'settings');
  static String language() => Intl.message('Dil', name: 'language');
  static String sound() => Intl.message('Ses', name: 'sound');
  static String music() => Intl.message('Müzik', name: 'music');
  static String vibration() => Intl.message('Titreşim', name: 'vibration');
  static String theme() => Intl.message('Tema', name: 'theme');

  // Premium features
  static String premium() => Intl.message('Premium', name: 'premium');
  static String unlockPremium() => Intl.message('Premium\'ı Aç', name: 'unlockPremium');
  static String premiumFeatures() => Intl.message('Premium Özellikler', name: 'premiumFeatures');
  static String unlimitedHints() => Intl.message('Sınırsız İpucu', name: 'unlimitedHints');
  static String noAds() => Intl.message('Reklamsız', name: 'noAds');
  static String allThemes() => Intl.message('Tüm Temalar', name: 'allThemes');
  static String detailedStats() => Intl.message('Detaylı İstatistikler', name: 'detailedStats');

  // Community
  static String community() => Intl.message('Topluluk', name: 'community');
  static String leaderboard() => Intl.message('Sıralama', name: 'leaderboard');
  static String challenges() => Intl.message('Görevler', name: 'challenges');
  static String friends() => Intl.message('Arkadaşlar', name: 'friends');
  static String achievements() => Intl.message('Başarılar', name: 'achievements');
} 