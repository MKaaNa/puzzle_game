// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$GameStateImpl _$$GameStateImplFromJson(Map<String, dynamic> json) =>
    _$GameStateImpl(
      tiles: (json['tiles'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      emptyTileIndex: (json['emptyTileIndex'] as num).toInt(),
      isComplete: json['isComplete'] as bool,
      moveCount: (json['moveCount'] as num).toInt(),
      elapsedTime: Duration(microseconds: (json['elapsedTime'] as num).toInt()),
      isActive: json['isActive'] as bool,
      score: (json['score'] as num).toInt(),
      difficulty: $enumDecode(_$GameDifficultyEnumMap, json['difficulty']),
      mode: $enumDecode(_$GameModeEnumMap, json['mode']),
      status: $enumDecode(_$GameStatusEnumMap, json['status']),
      isShowingHint: json['isShowingHint'] as bool? ?? false,
      hintTileIndex: (json['hintTileIndex'] as num?)?.toInt(),
      bestScore: (json['bestScore'] as num?)?.toInt() ?? 0,
      bestTime: json['bestTime'] == null
          ? Duration.zero
          : Duration(microseconds: (json['bestTime'] as num).toInt()),
      gamesWon: (json['gamesWon'] as num?)?.toInt() ?? 0,
      gamesPlayed: (json['gamesPlayed'] as num?)?.toInt() ?? 0,
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      bestStreak: (json['bestStreak'] as num?)?.toInt() ?? 0,
      hintsRemaining: (json['hintsRemaining'] as num?)?.toInt() ?? 3,
      correctPositions: (json['correctPositions'] as List<dynamic>?)
              ?.map((e) => (e as List<dynamic>).map((e) => e as bool).toList())
              .toList() ??
          const [],
      previousMoves: (json['previousMoves'] as List<dynamic>?)
              ?.map((e) =>
                  (e as List<dynamic>).map((e) => (e as num).toInt()).toList())
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$GameStateImplToJson(_$GameStateImpl instance) =>
    <String, dynamic>{
      'tiles': instance.tiles,
      'emptyTileIndex': instance.emptyTileIndex,
      'isComplete': instance.isComplete,
      'moveCount': instance.moveCount,
      'elapsedTime': instance.elapsedTime.inMicroseconds,
      'isActive': instance.isActive,
      'score': instance.score,
      'difficulty': _$GameDifficultyEnumMap[instance.difficulty]!,
      'mode': _$GameModeEnumMap[instance.mode]!,
      'status': _$GameStatusEnumMap[instance.status]!,
      'isShowingHint': instance.isShowingHint,
      'hintTileIndex': instance.hintTileIndex,
      'bestScore': instance.bestScore,
      'bestTime': instance.bestTime.inMicroseconds,
      'gamesWon': instance.gamesWon,
      'gamesPlayed': instance.gamesPlayed,
      'currentStreak': instance.currentStreak,
      'bestStreak': instance.bestStreak,
      'hintsRemaining': instance.hintsRemaining,
      'correctPositions': instance.correctPositions,
      'previousMoves': instance.previousMoves,
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
  GameMode.zen: 'zen',
};

const _$GameStatusEnumMap = {
  GameStatus.initial: 'initial',
  GameStatus.inProgress: 'inProgress',
  GameStatus.paused: 'paused',
  GameStatus.completed: 'completed',
  GameStatus.gameOver: 'gameOver',
};
