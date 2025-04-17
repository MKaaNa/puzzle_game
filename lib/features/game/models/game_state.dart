import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'package:uuid/uuid.dart';

part 'game_state.freezed.dart';
part 'game_state.g.dart';

enum GameStatus {
  initial,
  inProgress,
  paused,
  completed,
  gameOver
}

enum GameMode {
  classic,
  timeTrial,
  limitedMoves,
  zen
}

enum GameDifficulty {
  easy(3, 180, 100, 3, 100),
  medium(4, 300, 150, 2, 200),
  hard(5, 600, 200, 1, 300);

  const GameDifficulty(
    this.size,
    this.timeLimit,
    this.moveLimit,
    this.initialHints,
    this.baseScore,
  );

  final int size;
  final int timeLimit;
  final int moveLimit;
  final int initialHints;
  final int baseScore;
}

@freezed
class GameState with _$GameState {
  const factory GameState({
    required String id,
    required List<List<int>> puzzle,
    required int moves,
    required int timeElapsed,
    required int timeLimit,
    required int moveLimit,
    required int hintsRemaining,
    required bool isPaused,
    required bool isComplete,
    required bool hasWon,
    required GameStatus status,
    required GameMode mode,
    required GameDifficulty difficulty,
    required List<bool> correctPositions,
    required List<List<int>> previousMoves,
    @Default(0) int score,
    @Default(0) int bestScore,
    @Default(0) int bestTime,
    @Default(0) int gamesPlayed,
    @Default(0) int gamesWon,
    @Default(0) int currentStreak,
    @Default(0) int bestStreak,
  }) = _GameState;

  factory GameState.initial({
    required GameDifficulty difficulty,
    GameMode mode = GameMode.classic,
  }) {
    final puzzle = List.generate(
      difficulty.size,
      (i) => List.generate(difficulty.size, (j) => i * difficulty.size + j + 1),
    );
    return GameState(
      id: const Uuid().v4(),
      puzzle: puzzle,
      moves: 0,
      timeElapsed: 0,
      timeLimit: difficulty.timeLimit,
      moveLimit: difficulty.moveLimit,
      hintsRemaining: difficulty.initialHints,
      isPaused: false,
      isComplete: false,
      hasWon: false,
      status: GameStatus.initial,
      mode: mode,
      difficulty: difficulty,
      correctPositions: List.filled(difficulty.size * difficulty.size, true),
      previousMoves: [],
    );
  }

  factory GameState.fromJson(Map<String, dynamic> json) => _$GameStateFromJson(json);
}

extension GameStateX on GameState {
  bool get canMove => !isPaused && !isComplete && moves < moveLimit && timeElapsed < timeLimit;
  bool get canUndo => previousMoves.isNotEmpty && status == GameStatus.inProgress;
  bool get canUseHint => hintsRemaining > 0 && status == GameStatus.inProgress;
  bool get isTimeUp => timeElapsed >= timeLimit;
  bool get isMovesUp => moves >= moveLimit;
  bool get hasLost => isComplete && !hasWon;
  bool get isTimeTrialMode => mode == GameMode.timeTrial;
  bool get isLimitedMovesMode => mode == GameMode.limitedMoves;
  bool get isDailyChallengeMode => mode == GameMode.zen;

  List<int> get board {
    final List<int> result = [];
    for (final row in puzzle) {
      result.addAll(row);
    }
    return result;
  }

  int get moveCount => moves;

  String get formattedTime {
    final minutes = (timeElapsed ~/ 60).toString().padLeft(2, '0');
    final seconds = (timeElapsed % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String get formattedTimeLimit {
    if (timeLimit == 0) return '--:--';
    final minutes = (timeLimit ~/ 60).toString().padLeft(2, '0');
    final seconds = (timeLimit % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  int get remainingMoves => moveLimit - moves;
  int get remainingTime => timeLimit - timeElapsed;

  double get progress {
    final totalTiles = puzzle.length * puzzle[0].length;
    final correctTiles = correctPositions.where((pos) => pos).length;
    return correctTiles / totalTiles;
  }
}

extension GameDifficultyX on GameDifficulty {
  String get label {
    switch (this) {
      case GameDifficulty.easy:
        return 'Easy';
      case GameDifficulty.medium:
        return 'Medium';
      case GameDifficulty.hard:
        return 'Hard';
    }
  }

  int get gridSize {
    switch (this) {
      case GameDifficulty.easy:
        return 3;
      case GameDifficulty.medium:
        return 4;
      case GameDifficulty.hard:
        return 5;
    }
  }

  int get initialHints {
    switch (this) {
      case GameDifficulty.easy:
        return 5;
      case GameDifficulty.medium:
        return 3;
      case GameDifficulty.hard:
        return 2;
    }
  }

  int get timeLimit {
    switch (this) {
      case GameDifficulty.easy:
        return 300; // 5 minutes
      case GameDifficulty.medium:
        return 480; // 8 minutes
      case GameDifficulty.hard:
        return 600; // 10 minutes
    }
  }

  int get moveLimit {
    switch (this) {
      case GameDifficulty.easy:
        return 100;
      case GameDifficulty.medium:
        return 200;
      case GameDifficulty.hard:
        return 300;
    }
  }

  int get baseScore {
    switch (this) {
      case GameDifficulty.easy:
        return 1000;
      case GameDifficulty.medium:
        return 2000;
      case GameDifficulty.hard:
        return 3000;
    }
  }
} 