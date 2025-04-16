import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:uuid/uuid.dart';

part 'achievement_model.freezed.dart';
part 'achievement_model.g.dart';

enum AchievementType {
  firstGame,
  timeMaster,
  moveMaster,
  streakMaster,
  hintlessMaster,
  dailyChallengeMaster,
}

enum AchievementTier {
  bronze,
  silver,
  gold,
  platinum,
}

@freezed
class Achievement with _$Achievement {
  const factory Achievement({
    required String id,
    required AchievementType type,
    required AchievementTier tier,
    required String title,
    required String description,
    required int points,
    required DateTime unlockedAt,
    Map<String, dynamic>? metadata,
  }) = _Achievement;

  factory Achievement.fromJson(Map<String, dynamic> json) =>
      _$AchievementFromJson(json);

  factory Achievement.firstGame({
    required AchievementTier tier,
  }) {
    return Achievement(
      id: const Uuid().v4(),
      type: AchievementType.firstGame,
      tier: tier,
      title: 'İlk Oyun',
      description: 'İlk oyununu tamamladın!',
      points: tier.points,
      unlockedAt: DateTime.now(),
    );
  }

  factory Achievement.timeMaster({
    required AchievementTier tier,
    required int time,
  }) {
    return Achievement(
      id: const Uuid().v4(),
      type: AchievementType.timeMaster,
      tier: tier,
      title: 'Zaman Ustası',
      description: '${time} saniyede bulmacayı çözdün!',
      points: tier.points,
      unlockedAt: DateTime.now(),
      metadata: {'time': time},
    );
  }

  factory Achievement.moveMaster({
    required AchievementTier tier,
    required int moves,
  }) {
    return Achievement(
      id: const Uuid().v4(),
      type: AchievementType.moveMaster,
      tier: tier,
      title: 'Hamle Ustası',
      description: '${moves} hamlede bulmacayı çözdün!',
      points: tier.points,
      unlockedAt: DateTime.now(),
      metadata: {'moves': moves},
    );
  }

  factory Achievement.streakMaster({
    required AchievementTier tier,
    required int streak,
  }) {
    return Achievement(
      id: const Uuid().v4(),
      type: AchievementType.streakMaster,
      tier: tier,
      title: 'Seri Ustası',
      description: '${streak} gün üst üste oyun oynadın!',
      points: tier.points,
      unlockedAt: DateTime.now(),
      metadata: {'streak': streak},
    );
  }

  factory Achievement.hintlessMaster({
    required AchievementTier tier,
  }) {
    return Achievement(
      id: const Uuid().v4(),
      type: AchievementType.hintlessMaster,
      tier: tier,
      title: 'İpucu Ustası',
      description: 'İpucu kullanmadan bulmacayı çözdün!',
      points: tier.points,
      unlockedAt: DateTime.now(),
    );
  }

  factory Achievement.dailyChallengeMaster({
    required AchievementTier tier,
  }) {
    return Achievement(
      id: const Uuid().v4(),
      type: AchievementType.dailyChallengeMaster,
      tier: tier,
      title: 'Günlük Meydan Okuma Ustası',
      description: 'Günlük meydan okumayı tamamladın!',
      points: tier.points,
      unlockedAt: DateTime.now(),
    );
  }
}

extension AchievementTierX on AchievementTier {
  String get label {
    switch (this) {
      case AchievementTier.bronze:
        return 'Bronz';
      case AchievementTier.silver:
        return 'Gümüş';
      case AchievementTier.gold:
        return 'Altın';
      case AchievementTier.platinum:
        return 'Platin';
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
    }
  }
} 