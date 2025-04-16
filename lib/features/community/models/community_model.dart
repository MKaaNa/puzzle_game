import 'package:freezed_annotation/freezed_annotation.dart';

part 'community_model.freezed.dart';
part 'community_model.g.dart';

enum ChallengeType {
  daily,
  weekly,
  monthly,
  custom,
}

enum ChallengeStatus {
  active,
  completed,
  expired,
}

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String username,
    required String? avatarUrl,
    required int level,
    required int experience,
    required int totalGames,
    required int totalWins,
    required int bestTime,
    required int bestMoves,
    required List<String> friends,
    required List<String> achievements,
    required bool isPremium,
    required DateTime joinDate,
    required Map<String, dynamic>? stats,
  }) = _UserProfile;

  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  factory UserProfile.initial(String id, String username) {
    return UserProfile(
      id: id,
      username: username,
      avatarUrl: null,
      level: 1,
      experience: 0,
      totalGames: 0,
      totalWins: 0,
      bestTime: 0,
      bestMoves: 0,
      friends: [],
      achievements: [],
      isPremium: false,
      joinDate: DateTime.now(),
      stats: null,
    );
  }
}

@freezed
class Challenge with _$Challenge {
  const factory Challenge({
    required String id,
    required String title,
    required String description,
    required ChallengeType type,
    required ChallengeStatus status,
    required DateTime startDate,
    required DateTime endDate,
    required List<String> participants,
    required Map<String, int> scores,
    required bool isPremium,
    required Map<String, dynamic>? settings,
  }) = _Challenge;

  factory Challenge.fromJson(Map<String, dynamic> json) =>
      _$ChallengeFromJson(json);

  factory Challenge.daily() {
    return Challenge(
      id: 'daily_${DateTime.now().toIso8601String()}',
      title: 'Daily Challenge',
      description: 'Complete today\'s special puzzle',
      type: ChallengeType.daily,
      status: ChallengeStatus.active,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(const Duration(days: 1)),
      participants: [],
      scores: {},
      isPremium: false,
      settings: null,
    );
  }

  factory Challenge.custom({
    required String title,
    required String description,
    required Duration duration,
    required bool isPremium,
  }) {
    return Challenge(
      id: 'custom_${DateTime.now().toIso8601String()}',
      title: title,
      description: description,
      type: ChallengeType.custom,
      status: ChallengeStatus.active,
      startDate: DateTime.now(),
      endDate: DateTime.now().add(duration),
      participants: [],
      scores: {},
      isPremium: isPremium,
      settings: null,
    );
  }
}

@freezed
class LeaderboardEntry with _$LeaderboardEntry {
  const factory LeaderboardEntry({
    required String userId,
    required String username,
    required String? avatarUrl,
    required int score,
    required int rank,
    required Map<String, dynamic>? stats,
  }) = _LeaderboardEntry;

  factory LeaderboardEntry.fromJson(Map<String, dynamic> json) =>
      _$LeaderboardEntryFromJson(json);
}

extension ChallengeTypeExtension on ChallengeType {
  String get label {
    switch (this) {
      case ChallengeType.daily:
        return 'Daily';
      case ChallengeType.weekly:
        return 'Weekly';
      case ChallengeType.monthly:
        return 'Monthly';
      case ChallengeType.custom:
        return 'Custom';
    }
  }

  String get icon {
    switch (this) {
      case ChallengeType.daily:
        return '🌞';
      case ChallengeType.weekly:
        return '📅';
      case ChallengeType.monthly:
        return '📆';
      case ChallengeType.custom:
        return '🎯';
    }
  }
} 