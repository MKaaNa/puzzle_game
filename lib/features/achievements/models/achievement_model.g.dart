// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'achievement_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AchievementImpl _$$AchievementImplFromJson(Map<String, dynamic> json) =>
    _$AchievementImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$AchievementTypeEnumMap, json['type']),
      tier: $enumDecode(_$AchievementTierEnumMap, json['tier']),
      progress: (json['progress'] as num).toInt(),
      target: (json['target'] as num).toInt(),
      isPremium: json['isPremium'] as bool,
      unlockedAt: json['unlockedAt'] == null
          ? null
          : DateTime.parse(json['unlockedAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$AchievementImplToJson(_$AchievementImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': _$AchievementTypeEnumMap[instance.type]!,
      'tier': _$AchievementTierEnumMap[instance.tier]!,
      'progress': instance.progress,
      'target': instance.target,
      'isPremium': instance.isPremium,
      'unlockedAt': instance.unlockedAt?.toIso8601String(),
      'metadata': instance.metadata,
    };

const _$AchievementTypeEnumMap = {
  AchievementType.gameCompletion: 'gameCompletion',
  AchievementType.timeRecord: 'timeRecord',
  AchievementType.moveRecord: 'moveRecord',
  AchievementType.streak: 'streak',
  AchievementType.hintless: 'hintless',
  AchievementType.dailyChallenge: 'dailyChallenge',
  AchievementType.customPuzzle: 'customPuzzle',
};

const _$AchievementTierEnumMap = {
  AchievementTier.bronze: 'bronze',
  AchievementTier.silver: 'silver',
  AchievementTier.gold: 'gold',
  AchievementTier.platinum: 'platinum',
  AchievementTier.diamond: 'diamond',
};
