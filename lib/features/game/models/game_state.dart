import 'package:freezed_annotation/freezed_annotation.dart';

part 'game_state.freezed.dart';
part 'game_state.g.dart';

enum GameStatus {
  initial,
  inProgress,
  paused,
  completed
}

enum GameMode {
  classic,
  timeTrial,
  limitedMoves,
  dailyChallenge,
}

enum GameDifficulty {
  easy,
  medium,
  hard
}

@freezed
class GameState with _$GameState {
  const factory GameState({
    @Default(GameStatus.initial) GameStatus status,
    @Default([]) List<List<int>> puzzle,
    @Default(0) int moves,
    @Default(0) int score,
    @Default(0) int time,
    @Default([]) List<bool> correctPositions,
    @Default(GameDifficulty.medium) GameDifficulty difficulty,
    @Default(GameMode.classic) GameMode mode,
    @Default(false) bool canUndo,
    @Default(false) bool isGameOver,
  }) = _GameState;

  factory GameState.initial() => const GameState(
        status: GameStatus.initial,
        mode: GameMode.classic,
        difficulty: GameDifficulty.medium,
        puzzle: [],
        moves: 0,
        score: 0,
        time: 0,
        correctPositions: [],
        canUndo: false,
        isGameOver: false,
      );

  factory GameState.fromJson(Map<String, dynamic> json) =>
      _$GameStateFromJson(json);
}

extension GameStateX on GameState {
  List<int> get board {
    final List<int> result = [];
    for (final row in puzzle) {
      result.addAll(row);
    }
    return result;
  }

  int get moveCount => moves;

  String get formattedTime {
    final minutes = (time ~/ 60).toString().padLeft(2, '0');
    final seconds = (time % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
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
} 