// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameStateImpl _$$GameStateImplFromJson(Map<String, dynamic> json) =>
    _$GameStateImpl(
      id: json['id'] as String,
      puzzle: (json['puzzle'] as List<dynamic>)
          .map((e) =>
              (e as List<dynamic>).map((e) => (e as num).toInt()).toList())
          .toList(),
      moves: (json['moves'] as num).toInt(),
      timeElapsed: (json['timeElapsed'] as num).toInt(),
      timeLimit: (json['timeLimit'] as num).toInt(),
      moveLimit: (json['moveLimit'] as num).toInt(),
      hintsRemaining: (json['hintsRemaining'] as num).toInt(),
      isPaused: json['isPaused'] as bool,
      isComplete: json['isComplete'] as bool,
      hasWon: json['hasWon'] as bool,
      status: $enumDecode(_$GameStatusEnumMap, json['status']),
      mode: $enumDecode(_$GameModeEnumMap, json['mode']),
      difficulty: $enumDecode(_$GameDifficultyEnumMap, json['difficulty']),
      correctPositions: (json['correctPositions'] as List<dynamic>)
          .map((e) => e as bool)
          .toList(),
      previousMoves: (json['previousMoves'] as List<dynamic>)
          .map((e) =>
              (e as List<dynamic>).map((e) => (e as num).toInt()).toList())
          .toList(),
      score: (json['score'] as num?)?.toInt() ?? 0,
      bestScore: (json['bestScore'] as num?)?.toInt() ?? 0,
      bestTime: (json['bestTime'] as num?)?.toInt() ?? 0,
      gamesPlayed: (json['gamesPlayed'] as num?)?.toInt() ?? 0,
      gamesWon: (json['gamesWon'] as num?)?.toInt() ?? 0,
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      bestStreak: (json['bestStreak'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$GameStateImplToJson(_$GameStateImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'puzzle': instance.puzzle,
      'moves': instance.moves,
      'timeElapsed': instance.timeElapsed,
      'timeLimit': instance.timeLimit,
      'moveLimit': instance.moveLimit,
      'hintsRemaining': instance.hintsRemaining,
      'isPaused': instance.isPaused,
      'isComplete': instance.isComplete,
      'hasWon': instance.hasWon,
      'status': _$GameStatusEnumMap[instance.status]!,
      'mode': _$GameModeEnumMap[instance.mode]!,
      'difficulty': _$GameDifficultyEnumMap[instance.difficulty]!,
      'correctPositions': instance.correctPositions,
      'previousMoves': instance.previousMoves,
      'score': instance.score,
      'bestScore': instance.bestScore,
      'bestTime': instance.bestTime,
      'gamesPlayed': instance.gamesPlayed,
      'gamesWon': instance.gamesWon,
      'currentStreak': instance.currentStreak,
      'bestStreak': instance.bestStreak,
    };

const _$GameStatusEnumMap = {
  GameStatus.initial: 'initial',
  GameStatus.inProgress: 'inProgress',
  GameStatus.paused: 'paused',
  GameStatus.completed: 'completed',
  GameStatus.gameOver: 'gameOver',
};

const _$GameModeEnumMap = {
  GameMode.classic: 'classic',
  GameMode.timeTrial: 'timeTrial',
  GameMode.limitedMoves: 'limitedMoves',
  GameMode.zen: 'zen',
};

const _$GameDifficultyEnumMap = {
  GameDifficulty.easy: 'easy',
  GameDifficulty.medium: 'medium',
  GameDifficulty.hard: 'hard',
};
