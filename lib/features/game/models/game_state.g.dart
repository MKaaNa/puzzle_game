// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameStateImpl _$$GameStateImplFromJson(Map<String, dynamic> json) =>
    _$GameStateImpl(
      status: $enumDecodeNullable(_$GameStatusEnumMap, json['status']) ??
          GameStatus.initial,
      puzzle: (json['puzzle'] as List<dynamic>?)
              ?.map((e) =>
                  (e as List<dynamic>).map((e) => (e as num).toInt()).toList())
              .toList() ??
          const [],
      moves: (json['moves'] as num?)?.toInt() ?? 0,
      score: (json['score'] as num?)?.toInt() ?? 0,
      time: (json['time'] as num?)?.toInt() ?? 0,
      correctPositions: (json['correctPositions'] as List<dynamic>?)
              ?.map((e) => e as bool)
              .toList() ??
          const [],
      difficulty:
          $enumDecodeNullable(_$GameDifficultyEnumMap, json['difficulty']) ??
              GameDifficulty.medium,
      mode: $enumDecodeNullable(_$GameModeEnumMap, json['mode']) ??
          GameMode.classic,
      canUndo: json['canUndo'] as bool? ?? false,
      isGameOver: json['isGameOver'] as bool? ?? false,
    );

Map<String, dynamic> _$$GameStateImplToJson(_$GameStateImpl instance) =>
    <String, dynamic>{
      'status': _$GameStatusEnumMap[instance.status]!,
      'puzzle': instance.puzzle,
      'moves': instance.moves,
      'score': instance.score,
      'time': instance.time,
      'correctPositions': instance.correctPositions,
      'difficulty': _$GameDifficultyEnumMap[instance.difficulty]!,
      'mode': _$GameModeEnumMap[instance.mode]!,
      'canUndo': instance.canUndo,
      'isGameOver': instance.isGameOver,
    };

const _$GameStatusEnumMap = {
  GameStatus.initial: 'initial',
  GameStatus.inProgress: 'inProgress',
  GameStatus.paused: 'paused',
  GameStatus.completed: 'completed',
};

const _$GameDifficultyEnumMap = {
  GameDifficulty.easy: 'easy',
  GameDifficulty.medium: 'medium',
  GameDifficulty.hard: 'hard',
};

const _$GameModeEnumMap = {
  GameMode.classic: 'classic',
  GameMode.timeTrial: 'timeTrial',
  GameMode.limitedMoves: 'limitedMoves',
  GameMode.dailyChallenge: 'dailyChallenge',
};
