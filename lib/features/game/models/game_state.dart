import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
import 'game_difficulty.dart';

part 'game_state.freezed.dart';
part 'game_state.g.dart';

enum GameStatus {
  initial,
  ready,
  playing,
  paused,
  completed
}

enum GameMode {
  classic,
  timeTrial,
  limitedMoves,
  zen
}

enum PowerUp {
  swap,      // İki parçayı yer değiştirme
  shuffle,   // Rastgele parçaları karıştırma
  freeze,    // Zamanı durdurma
  reveal,    // Doğru pozisyonları gösterme
  undo       // Son hamleyi geri alma
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
    required List<List<bool>> correctPositions,
    required int hintsRemaining,
    required bool isShowingHint,
    required DateTime lastMoveTime,
    int? hintTileIndex,
    int? movingTileIndex,
    @Default([]) List<List<int>> previousMoves,
    @Default(false) bool showingCorrectTile,
    @Default(0) int bestScore,
    @Default(0) int bestStreak,
    @Default(Duration.zero) Duration bestTime,
    @Default(0) int currentStreak,
    @Default(0) int gamesPlayed,
    @Default(0) int gamesWon,
    @Default(0) int powerPoints,
    @Default([]) List<PowerUp> activePowerUps,
    @Default(false) bool isTimeFrozen,
    @Default([]) List<int> revealedPositions,
    @Default(null) int? lastMoveIndex,
  }) = _GameState;

  factory GameState.initial({
    required GameDifficulty difficulty,
    required GameMode mode,
  }) {
    final size = difficulty.size;
    final tiles = List.generate(size * size, (index) => (index + 1) % (size * size));
    final correctPositions = List.generate(
      size,
      (row) => List.generate(
        size,
        (col) => false,
      ),
    );

    return GameState(
      tiles: tiles,
      emptyTileIndex: size * size - 1,
      isComplete: false,
      moveCount: 0,
      elapsedTime: Duration.zero,
      isActive: false,
      score: 0,
      difficulty: difficulty,
      mode: mode,
      status: GameStatus.initial,
      correctPositions: correctPositions,
      hintsRemaining: difficulty.maxHints,
      isShowingHint: false,
      lastMoveTime: DateTime.now(),
      showingCorrectTile: false,
      powerPoints: 0,
      activePowerUps: [],
      isTimeFrozen: false,
      revealedPositions: [],
      lastMoveIndex: null,
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
    final minutes = elapsedTime.inMinutes;
    final seconds = elapsedTime.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${seconds.toString().padLeft(2, '0')}';
  }

  String get formattedTimeLimit {
    final minutes = difficulty.timeLimit.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = difficulty.timeLimit.inSeconds.remainder(60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  /// Returns true if the game is in a state where a hint can be used.
  bool get canUseHint => hintsRemaining > 0 && isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canUndo => isActive && previousMoves.isNotEmpty && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canRedo => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canRestart => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canPause => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canResume => !isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowSolution => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowCorrectTile => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowHint => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowPreviousMoves => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowNextMoves => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowMoves => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowScore => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowTime => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowMoveCount => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowDifficulty => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowMode => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowStatus => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowHintsRemaining => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowIsShowingHint => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowLastMoveTime => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowHintTileIndex => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowMovingTileIndex => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowPreviousMovesList => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowShowingCorrectTile => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowBestScore => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowBestStreak => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowBestTime => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowCurrentStreak => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowGamesPlayed => isActive && !isComplete;

  /// Returns true if the game is in a state where a hint can be used.
  bool get canShowGamesWon => isActive && !isComplete;

  bool get isTimeUp => elapsedTime >= difficulty.timeLimit;
  bool get hasWon => isComplete && _isPuzzleSolved();
  
  bool _isPuzzleSolved() {
    for (int i = 0; i < tiles.length - 1; i++) {
      if (tiles[i] != i + 1) return false;
    }
    return tiles.last == 0;
  }

  bool get isWon {
    for (int i = 0; i < tiles.length - 1; i++) {
      if (tiles[i] != i + 1) return false;
    }
    return tiles.last == 0;
  }

  bool get isIdle => DateTime.now().difference(lastMoveTime).inSeconds > 30;
}

extension GameStateX on GameState {
  bool get canMove => isActive && !isComplete && moveCount < difficulty.moveLimit && elapsedTime < difficulty.timeLimit;
  bool get canUndo => previousMoves.isNotEmpty && status == GameStatus.playing;
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
    if (isComplete) return 1.0;
    final totalTime = difficulty.timeLimit.inSeconds;
    final elapsed = elapsedTime.inSeconds;
    return elapsed / totalTime;
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