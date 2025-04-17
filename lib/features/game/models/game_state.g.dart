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
      correctPositions: (json['correctPositions'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as bool).toList())
          .toList(),
      hintsRemaining: (json['hintsRemaining'] as num).toInt(),
      isShowingHint: json['isShowingHint'] as bool,
      lastMoveTime: DateTime.parse(json['lastMoveTime'] as String),
      hintTileIndex: (json['hintTileIndex'] as num?)?.toInt(),
      movingTileIndex: (json['movingTileIndex'] as num?)?.toInt(),
      previousMoves: (json['previousMoves'] as List<dynamic>?)
              ?.map((e) =>
                  (e as List<dynamic>).map((e) => (e as num).toInt()).toList())
              .toList() ??
          const [],
      showingCorrectTile: json['showingCorrectTile'] as bool? ?? false,
      bestScore: (json['bestScore'] as num?)?.toInt() ?? 0,
      bestStreak: (json['bestStreak'] as num?)?.toInt() ?? 0,
      bestTime: json['bestTime'] == null
          ? Duration.zero
          : Duration(microseconds: (json['bestTime'] as num).toInt()),
      currentStreak: (json['currentStreak'] as num?)?.toInt() ?? 0,
      gamesPlayed: (json['gamesPlayed'] as num?)?.toInt() ?? 0,
      gamesWon: (json['gamesWon'] as num?)?.toInt() ?? 0,
      powerPoints: (json['powerPoints'] as num?)?.toInt() ?? 0,
      activePowerUps: (json['activePowerUps'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$PowerUpEnumMap, e))
              .toList() ??
          const [],
      isTimeFrozen: json['isTimeFrozen'] as bool? ?? false,
      revealedPositions: (json['revealedPositions'] as List<dynamic>?)
              ?.map((e) => (e as num).toInt())
              .toList() ??
          const [],
      lastMoveIndex: (json['lastMoveIndex'] as num?)?.toInt() ?? null,
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
      'correctPositions': instance.correctPositions,
      'hintsRemaining': instance.hintsRemaining,
      'isShowingHint': instance.isShowingHint,
      'lastMoveTime': instance.lastMoveTime.toIso8601String(),
      'hintTileIndex': instance.hintTileIndex,
      'movingTileIndex': instance.movingTileIndex,
      'previousMoves': instance.previousMoves,
      'showingCorrectTile': instance.showingCorrectTile,
      'bestScore': instance.bestScore,
      'bestStreak': instance.bestStreak,
      'bestTime': instance.bestTime.inMicroseconds,
      'currentStreak': instance.currentStreak,
      'gamesPlayed': instance.gamesPlayed,
      'gamesWon': instance.gamesWon,
      'powerPoints': instance.powerPoints,
      'activePowerUps':
          instance.activePowerUps.map((e) => _$PowerUpEnumMap[e]!).toList(),
      'isTimeFrozen': instance.isTimeFrozen,
      'revealedPositions': instance.revealedPositions,
      'lastMoveIndex': instance.lastMoveIndex,
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
  GameStatus.ready: 'ready',
  GameStatus.playing: 'playing',
  GameStatus.paused: 'paused',
  GameStatus.completed: 'completed',
};

const _$PowerUpEnumMap = {
  PowerUp.swap: 'swap',
  PowerUp.shuffle: 'shuffle',
  PowerUp.freeze: 'freeze',
  PowerUp.reveal: 'reveal',
  PowerUp.undo: 'undo',
};
