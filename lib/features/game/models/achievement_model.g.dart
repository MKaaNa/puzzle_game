// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AchievementImpl _$$AchievementImplFromJson(Map<String, dynamic> json) =>
    _$AchievementImpl(
      id: json['id'] as String,
      type: $enumDecode(_$AchievementTypeEnumMap, json['type']),
      tier: $enumDecode(_$AchievementTierEnumMap, json['tier']),
      title: json['title'] as String,
      description: json['description'] as String,
      points: (json['points'] as num).toInt(),
      unlockedAt: DateTime.parse(json['unlockedAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$AchievementImplToJson(_$AchievementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$AchievementTypeEnumMap[instance.type]!,
      'tier': _$AchievementTierEnumMap[instance.tier]!,
      'title': instance.title,
      'description': instance.description,
      'points': instance.points,
      'unlockedAt': instance.unlockedAt.toIso8601String(),
      'metadata': instance.metadata,
    };

const _$AchievementTypeEnumMap = {
  AchievementType.firstGame: 'firstGame',
  AchievementType.timeMaster: 'timeMaster',
  AchievementType.moveMaster: 'moveMaster',
  AchievementType.streakMaster: 'streakMaster',
  AchievementType.hintlessMaster: 'hintlessMaster',
  AchievementType.dailyChallengeMaster: 'dailyChallengeMaster',
};

const _$AchievementTierEnumMap = {
  AchievementTier.bronze: 'bronze',
  AchievementTier.silver: 'silver',
  AchievementTier.gold: 'gold',
  AchievementTier.platinum: 'platinum',
};
