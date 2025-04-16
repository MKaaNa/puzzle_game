import 'package:freezed_annotation/freezed_annotation.dart';
import '../../game/models/game_state.dart';

part 'achievement_model.freezed.dart';
part 'achievement_model.g.dart';

enum AchievementType {
  gameCompletion,
  timeRecord,
  moveRecord,
  streak,
  hintless,
  dailyChallenge,
  customPuzzle,
}

enum AchievementTier {
  bronze,
  silver,
  gold,
  platinum,
  diamond,
}

@freezed
class Achievement with _$Achievement {
  const factory Achievement({
    required String id,
    required String title,
    required String description,
    required AchievementType type,
    required AchievementTier tier,
    required int progress,
    required int target,
    required bool isPremium,
    required DateTime? unlockedAt,
    required Map<String, dynamic>? metadata,
  }) = _Achievement;

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);

  factory Achievement.firstGame() {
    return Achievement(
      id: 'first_game',
      title: 'First Steps',
      description: 'Complete your first game',
      type: AchievementType.gameCompletion,
      tier: AchievementTier.bronze,
      progress: 0,
      target: 1,
      isPremium: false,
      unlockedAt: null,
      metadata: null,
    );
  }

  factory Achievement.timeMaster(GameDifficulty difficulty) {
    return Achievement(
      id: 'time_master_${difficulty.name}',
      title: 'Time Master (${difficulty.label})',
      description: 'Complete a game in record time',
      type: AchievementType.timeRecord,
      tier: AchievementTier.gold,
      progress: 0,
      target: 1,
      isPremium: true,
      unlockedAt: null,
      metadata: {'difficulty': difficulty.name},
    );
  }

  factory Achievement.moveMaster(GameDifficulty difficulty) {
    return Achievement(
      id: 'move_master_${difficulty.name}',
      title: 'Move Master (${difficulty.label})',
      description: 'Complete a game with minimal moves',
      type: AchievementType.moveRecord,
      tier: AchievementTier.gold,
      progress: 0,
      target: 1,
      isPremium: true,
      unlockedAt: null,
      metadata: {'difficulty': difficulty.name},
    );
  }

  factory Achievement.streakMaster(int days) {
    return Achievement(
      id: 'streak_$days',
      title: '$days Day Streak',
      description: 'Play for $days consecutive days',
      type: AchievementType.streak,
      tier: _getStreakTier(days),
      progress: 0,
      target: days,
      isPremium: days > 7,
      unlockedAt: null,
      metadata: {'days': days},
    );
  }

  factory Achievement.hintlessMaster(GameDifficulty difficulty) {
    return Achievement(
      id: 'hintless_${difficulty.name}',
      title: 'Hintless Master (${difficulty.label})',
      description: 'Complete a game without using hints',
      type: AchievementType.hintless,
      tier: AchievementTier.platinum,
      progress: 0,
      target: 1,
      isPremium: true,
      unlockedAt: null,
      metadata: {'difficulty': difficulty.name},
    );
  }
}

extension AchievementTierExtension on AchievementTier {
  String get label {
    switch (this) {
      case AchievementTier.bronze:
        return 'Bronze';
      case AchievementTier.silver:
        return 'Silver';
      case AchievementTier.gold:
        return 'Gold';
      case AchievementTier.platinum:
        return 'Platinum';
      case AchievementTier.diamond:
        return 'Diamond';
    }
  }

  int get points {
    switch (this) {
      case AchievementTier.bronze:
        return 10;
      case AchievementTier.silver:
        return 25;
      case AchievementTier.gold:
        return 50;
      case AchievementTier.platinum:
        return 100;
      case AchievementTier.diamond:
        return 250;
    }
  }
}

AchievementTier _getStreakTier(int days) {
  if (days <= 3) return AchievementTier.bronze;
  if (days <= 7) return AchievementTier.silver;
  if (days <= 14) return AchievementTier.gold;
  if (days <= 30) return AchievementTier.platinum;
  return AchievementTier.diamond;
} 