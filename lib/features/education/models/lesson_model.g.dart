// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lesson_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$LessonImpl _$$LessonImplFromJson(Map<String, dynamic> json) => _$LessonImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$LessonTypeEnumMap, json['type']),
      difficulty: $enumDecode(_$LessonDifficultyEnumMap, json['difficulty']),
      steps: (json['steps'] as List<dynamic>).map((e) => e as String).toList(),
      tips: (json['tips'] as List<dynamic>).map((e) => e as String).toList(),
      isPremium: json['isPremium'] as bool,
      duration: (json['duration'] as num).toInt(),
      videoUrl: json['videoUrl'] as String?,
      practicePuzzles: (json['practicePuzzles'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$$LessonImplToJson(_$LessonImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'type': _$LessonTypeEnumMap[instance.type]!,
      'difficulty': _$LessonDifficultyEnumMap[instance.difficulty]!,
      'steps': instance.steps,
      'tips': instance.tips,
      'isPremium': instance.isPremium,
      'duration': instance.duration,
      'videoUrl': instance.videoUrl,
      'practicePuzzles': instance.practicePuzzles,
      'metadata': instance.metadata,
    };

const _$LessonTypeEnumMap = {
  LessonType.tutorial: 'tutorial',
  LessonType.strategy: 'strategy',
  LessonType.practice: 'practice',
  LessonType.challenge: 'challenge',
};

const _$LessonDifficultyEnumMap = {
  LessonDifficulty.beginner: 'beginner',
  LessonDifficulty.intermediate: 'intermediate',
  LessonDifficulty.advanced: 'advanced',
};
