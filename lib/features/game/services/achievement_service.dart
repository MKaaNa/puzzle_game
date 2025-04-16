import 'package:puzzle_game/features/game/models/achievement_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AchievementService {
  static const String _achievementsKey = 'achievements';
  static const String _pointsKey = 'total_points';
  
  final SharedPreferences _prefs;
  
  AchievementService(this._prefs);
  
  Future<List<Achievement>> getAchievements() async {
    final achievementsJson = _prefs.getStringList(_achievementsKey) ?? [];
    return achievementsJson.map((json) => Achievement.fromJson(json as Map<String, dynamic>)).toList();
  }
  
  Future<void> unlockAchievement(Achievement achievement) async {
    final achievements = await getAchievements();
    
    // Başarı zaten açılmış mı kontrol et
    if (achievements.any((a) => a.id == achievement.id)) {
      return;
    }
    
    // Yeni başarıyı ekle
    achievements.add(achievement);
    
    // Başarıları kaydet
    final achievementsJson = achievements.map((a) => a.toJson().toString()).toList();
    await _prefs.setStringList(_achievementsKey, achievementsJson);
    
    // Toplam puanı güncelle
    final currentPoints = _prefs.getInt(_pointsKey) ?? 0;
    await _prefs.setInt(_pointsKey, currentPoints + achievement.points);
  }
  
  int getTotalPoints() {
    return _prefs.getInt(_pointsKey) ?? 0;
  }
  
  Future<bool> checkAndUnlockAchievements({
    required int moves,
    required int time,
    required int hintsUsed,
    required bool isDailyChallenge,
  }) async {
    bool anyUnlocked = false;
    
    // Hamle başarıları
    if (moves <= 50) {
      await unlockAchievement(Achievement.moveMaster(
        tier: AchievementTier.bronze,
        moves: moves,
      ));
      anyUnlocked = true;
    }
    
    // Zaman başarıları
    if (time <= 300) { // 5 dakika
      await unlockAchievement(Achievement.timeMaster(
        tier: AchievementTier.bronze,
        time: time,
      ));
      anyUnlocked = true;
    }
    
    // İpucu başarıları
    if (hintsUsed == 0) {
      await unlockAchievement(Achievement.hintlessMaster(
        tier: AchievementTier.bronze,
      ));
      anyUnlocked = true;
    }
    
    // Günlük meydan okuma başarıları
    if (isDailyChallenge) {
      await unlockAchievement(Achievement.dailyChallengeMaster(
        tier: AchievementTier.bronze,
      ));
      anyUnlocked = true;
    }
    
    return anyUnlocked;
  }
} 