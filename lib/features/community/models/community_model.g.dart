// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'community_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserProfileImpl _$$UserProfileImplFromJson(Map<String, dynamic> json) =>
    _$UserProfileImpl(
      id: json['id'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      level: (json['level'] as num).toInt(),
      experience: (json['experience'] as num).toInt(),
      totalGames: (json['totalGames'] as num).toInt(),
      totalWins: (json['totalWins'] as num).toInt(),
      bestTime: (json['bestTime'] as num).toInt(),
      bestMoves: (json['bestMoves'] as num).toInt(),
      friends:
          (json['friends'] as List<dynamic>).map((e) => e as String).toList(),
      achievements: (json['achievements'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      isPremium: json['isPremium'] as bool,
      joinDate: DateTime.parse(json['joinDate'] as String),
      stats: json['stats'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$UserProfileImplToJson(_$UserProfileImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
      'level': instance.level,
      'experience': instance.experience,
      'totalGames': instance.totalGames,
      'totalWins': instance.totalWins,
      'bestTime': instance.bestTime,
      'bestMoves': instance.bestMoves,
      'friends': instance.friends,
      'achievements': instance.achievements,
      'isPremium': instance.isPremium,
      'joinDate': instance.joinDate.toIso8601String(),
      'stats': instance.stats,
    };

_$ChallengeImpl _$$ChallengeImplFromJson(Map<String, dynamic> json) =>
    _$ChallengeImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$ChallengeTypeEnumMap, json['type']),
      status: $enumDecode(_$ChallengeStatusEnumMap, json['status']),
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      participants: (json['participants'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      scores: Map<String, int>.from(json['scores'] as Map),
      isPremium: json['isPremium'] as bool,
      settings: json['settings'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$ChallengeImplToJson(_$ChallengeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': _$ChallengeTypeEnumMap[instance.type]!,
      'status': _$ChallengeStatusEnumMap[instance.status]!,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'participants': instance.participants,
      'scores': instance.scores,
      'isPremium': instance.isPremium,
      'settings': instance.settings,
    };

const _$ChallengeTypeEnumMap = {
  ChallengeType.daily: 'daily',
  ChallengeType.weekly: 'weekly',
  ChallengeType.monthly: 'monthly',
  ChallengeType.custom: 'custom',
};

const _$ChallengeStatusEnumMap = {
  ChallengeStatus.active: 'active',
  ChallengeStatus.completed: 'completed',
  ChallengeStatus.expired: 'expired',
};

_$LeaderboardEntryImpl _$$LeaderboardEntryImplFromJson(
        Map<String, dynamic> json) =>
    _$LeaderboardEntryImpl(
      userId: json['userId'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatarUrl'] as String?,
      score: (json['score'] as num).toInt(),
      rank: (json['rank'] as num).toInt(),
      stats: json['stats'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$LeaderboardEntryImplToJson(
        _$LeaderboardEntryImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'username': instance.username,
      'avatarUrl': instance.avatarUrl,
      'score': instance.score,
      'rank': instance.rank,
      'stats': instance.stats,
    };
