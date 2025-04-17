import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'game_difficulty.dart';

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

@freezed
class GameState with _$GameState {
  const GameState._();

  const factory GameState({
    required List<int> tiles,
    required int emptyTileIndex,
    required bool isComplete,
    required int moveCount,
    required Duration elapsedTime,
    required bool isActive,
    required int score,
    required GameDifficulty difficulty,
    required GameMode mode,
    required GameStatus status,
    @Default(false) bool isShowingHint,
    int? hintTileIndex,
    @Default(0) int bestScore,
    @Default(Duration.zero) Duration bestTime,
    @Default(0) int gamesWon,
    @Default(0) int gamesPlayed,
    @Default(0) int currentStreak,
    @Default(0) int bestStreak,
    @Default(3) int hintsRemaining,
    @Default([]) List<List<bool>> correctPositions,
    @Default([]) List<List<int>> previousMoves,
  }) = _GameState;

  factory GameState.initial({required GameDifficulty difficulty}) {
    final size = difficulty.size;
    final tiles = List<int>.generate(size * size, (index) => index);
    tiles.shuffle();
    
    // Ensure puzzle is solvable
    if (!_isSolvable(tiles, size)) {
      // If not solvable, swap any two tiles (except the empty tile)
      int firstIndex = 0;
      int secondIndex = 1;
      while (tiles[firstIndex] == 0 || tiles[secondIndex] == 0) {
        firstIndex++;
        secondIndex++;
      }
      final temp = tiles[firstIndex];
      tiles[firstIndex] = tiles[secondIndex];
      tiles[secondIndex] = temp;
    }

    return GameState(
      tiles: tiles,
      emptyTileIndex: tiles.indexOf(0),
      isComplete: false,
      moveCount: 0,
      elapsedTime: Duration.zero,
      isActive: false,
      score: 0,
      difficulty: difficulty,
      mode: GameMode.classic,
      status: GameStatus.initial,
      hintsRemaining: difficulty.initialHints,
      correctPositions: List.generate(size, (_) => List.filled(size, false)),
      previousMoves: [],
    );
  }

  static bool _isSolvable(List<int> tiles, int size) {
    int inversions = 0;
    for (int i = 0; i < tiles.length - 1; i++) {
      if (tiles[i] == 0) continue;
      for (int j = i + 1; j < tiles.length; j++) {
        if (tiles[j] != 0 && tiles[i] > tiles[j]) {
          inversions++;
        }
      }
    }
    
    // For odd-sized grids, the puzzle is solvable if inversions is even
    if (size % 2 == 1) {
      return inversions % 2 == 0;
    }
    
    // For even-sized grids, the puzzle is solvable if:
    // - the blank is on an even row from bottom and inversions is odd
    // - the blank is on an odd row from bottom and inversions is even
    final blankRow = tiles.indexOf(0) ~/ size;
    final rowFromBottom = size - blankRow;
    return (rowFromBottom % 2 == 0) == (inversions % 2 == 1);
  }

  factory GameState.fromJson(Map<String, dynamic> json) => _$GameStateFromJson(json);

  String get formattedTime {
    final minutes = elapsedTime.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = elapsedTime.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  String get formattedTimeLimit {
    final minutes = difficulty.timeLimit.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = difficulty.timeLimit.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  bool get canUseHint => hintsRemaining > 0 && isActive && !isComplete;
  bool get isTimeUp => elapsedTime >= difficulty.timeLimit;
  bool get hasWon => isComplete && _isPuzzleSolved();
  
  bool _isPuzzleSolved() {
    for (int i = 0; i < tiles.length - 1; i++) {
      if (tiles[i] != i + 1) return false;
    }
    return tiles.last == 0;
  }
}

extension GameStateX on GameState {
  bool get canMove => isActive && !isComplete && moveCount < difficulty.moveLimit && elapsedTime < difficulty.timeLimit;
  bool get canUndo => previousMoves.isNotEmpty && status == GameStatus.inProgress;
  bool get isMovesUp => moveCount >= difficulty.moveLimit;
  bool get hasLost => isComplete && !hasWon;
  bool get isTimeTrialMode => mode == GameMode.timeTrial;
  bool get isLimitedMovesMode => mode == GameMode.limitedMoves;
  bool get isDailyChallengeMode => mode == GameMode.zen;

  List<int> get board => tiles;

  int get remainingMoves => difficulty.moveLimit - moveCount;
  int get remainingTimeInSeconds => (difficulty.timeLimit - elapsedTime).inSeconds;
  Duration get remainingTime => difficulty.timeLimit - elapsedTime;

  double get progress {
    final totalTiles = tiles.length;
    int correctTiles = 0;
    for (int i = 0; i < tiles.length - 1; i++) {
      if (tiles[i] == i + 1) correctTiles++;
    }
    if (tiles.last == 0) correctTiles++;
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