import 'dart:convert';
import 'package:puzzle_game/features/game/models/achievement_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Achievement {
  firstWin(
    id: 'first_win',
    title: 'İlk Zafer',
    description: 'İlk oyununu kazan',
    points: 10,
  ),
  speedRunner(
    id: 'speed_runner',
    title: 'Hız Ustası',
    description: '1 dakikadan kısa sürede kazan',
    points: 20,
  ),
  perfectGame(
    id: 'perfect_game',
    title: 'Mükemmel Oyun',
    description: 'İpucu kullanmadan kazan',
    points: 30,
  ),
  dailyStreak(
    id: 'daily_streak',
    title: 'Günlük Seri',
    description: '7 gün üst üste günlük görevi tamamla',
    points: 50,
  ),
  masterPuzzler(
    id: 'master_puzzler',
    title: 'Bulmaca Ustası',
    description: 'Zor zorluk seviyesinde kazan',
    points: 40,
  );

  final String id;
  final String title;
  final String description;
  final int points;

  const Achievement({
    required this.id,
    required this.title,
    required this.description,
    required this.points,
  });
}

class AchievementService {
  final SharedPreferences _prefs;
  static const String _achievementsKey = 'achievements';
  static const String _totalPointsKey = 'achievement_points';

  AchievementService(this._prefs);

  Set<String> getUnlockedAchievements() {
    final achievements = _prefs.getStringList(_achievementsKey) ?? [];
    return achievements.toSet();
  }

  Future<void> unlockAchievement(Achievement achievement) async {
    final unlockedAchievements = getUnlockedAchievements();
    
    // Başarı zaten açılmışsa bir şey yapma
    if (unlockedAchievements.contains(achievement.id)) return;

    // Başarıyı kaydet
    unlockedAchievements.add(achievement.id);
    await _prefs.setStringList(_achievementsKey, unlockedAchievements.toList());

    // Puanları güncelle
    final currentPoints = _prefs.getInt(_totalPointsKey) ?? 0;
    await _prefs.setInt(_totalPointsKey, currentPoints + achievement.points);
  }

  int getTotalPoints() {
    return _prefs.getInt(_totalPointsKey) ?? 0;
  }

  bool isAchievementUnlocked(Achievement achievement) {
    return getUnlockedAchievements().contains(achievement.id);
  }

  Future<void> checkAndUnlockAchievements({
    required int moves,
    required int time,
    required int hintsUsed,
    required bool isDailyChallenge,
  }) async {
    // İlk zafer
    await unlockAchievement(Achievement.firstWin);

    // Hız ustası (60 saniyeden az)
    if (time < 60) {
      await unlockAchievement(Achievement.speedRunner);
    }

    // Mükemmel oyun (ipucu kullanmadan)
    if (hintsUsed == 0) {
      await unlockAchievement(Achievement.perfectGame);
    }

    // Günlük seri (7 gün) kontrolü DailyChallengeService'de yapılıyor
    if (isDailyChallenge) {
      final streak = _prefs.getInt('daily_streak') ?? 0;
      if (streak >= 7) {
        await unlockAchievement(Achievement.dailyStreak);
      }
    }
  }

  List<Achievement> getAvailableAchievements() {
    return Achievement.values.toList();
  }

  Map<String, dynamic> getProgress() {
    final unlockedAchievements = getUnlockedAchievements();
    final totalAchievements = Achievement.values.length;
    final progress = unlockedAchievements.length / totalAchievements;
    
    return {
      'unlockedCount': unlockedAchievements.length,
      'totalCount': totalAchievements,
      'progress': progress,
      'points': getTotalPoints(),
    };
  }
} 