import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game_state.dart';
import '../services/puzzle_generator.dart';
import 'package:uuid/uuid.dart';

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier();
});

class GameNotifier extends StateNotifier<GameState> {
  Timer? _timer;
  final Random _random = Random();

  GameNotifier() : super(GameState.initial(difficulty: GameDifficulty.easy));

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void startNewGame(GameDifficulty difficulty) {
    _timer?.cancel();
    final puzzle = PuzzleGenerator.generatePuzzle(difficulty);
    state = GameState(
      id: const Uuid().v4(),
      status: GameStatus.inProgress,
      mode: GameMode.classic,
      puzzle: puzzle,
      moves: 0,
      score: 0,
      timeElapsed: 0,
      difficulty: difficulty,
      correctPositions: List.filled(puzzle.length * puzzle[0].length, false),
      hintsRemaining: difficulty.initialHints,
      timeLimit: difficulty.timeLimit,
      moveLimit: difficulty.moveLimit,
      previousMoves: [],
      isPaused: false,
      isComplete: false,
      hasWon: false,
    );
    _startTimer();
    _updateCorrectPositions();
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (state.status == GameStatus.inProgress) {
        if (state.isTimeTrialMode && state.timeElapsed >= state.timeLimit) {
          _gameOver();
          return;
        }
        state = state.copyWith(timeElapsed: state.timeElapsed + 1);
      }
    });
  }

  void togglePause() {
    if (state.status == GameStatus.inProgress) {
      state = state.copyWith(status: GameStatus.paused);
    } else if (state.status == GameStatus.paused) {
      state = state.copyWith(status: GameStatus.inProgress);
    }
  }

  void moveTile(int row, int col) {
    if (state.status != GameStatus.inProgress) return;
    if (state.isLimitedMovesMode && state.moves >= state.moveLimit) {
      _gameOver();
      return;
    }

    final puzzle = List<List<int>>.from(state.puzzle);
    final emptyTile = _findEmptyTile(puzzle);
    
    if (_isValidMove(row, col, emptyTile)) {
      _swapTiles(puzzle, row, col, emptyTile.$1, emptyTile.$2);
      
      final previousMoves = List<List<int>>.from(state.previousMoves)
        ..add(state.puzzle.expand((row) => row).toList());

      state = state.copyWith(
        puzzle: puzzle,
        moves: state.moves + 1,
        previousMoves: previousMoves,
      );

      _updateCorrectPositions();

      if (_isPuzzleSolved(puzzle)) {
        _handleGameWin();
      }
    }
  }

  void useHint() {
    if (!state.canUseHint) return;

    final puzzle = state.puzzle;
    final emptyTile = _findEmptyTile(puzzle);
    final correctMove = _findCorrectMove(emptyTile);

    if (correctMove != null) {
      state = state.copyWith(
        hintsRemaining: state.hintsRemaining - 1,
        score: state.score - 50, // Penalty for using hint
      );
      moveTile(correctMove.$1, correctMove.$2);
    }
  }

  void undo() {
    if (!state.canUndo || state.previousMoves.isEmpty) return;

    final previousMoves = List<List<int>>.from(state.previousMoves);
    final lastMove = previousMoves.removeLast();
    final puzzle = List<List<int>>.generate(
      state.puzzle.length,
      (i) => lastMove.sublist(i * state.puzzle.length, (i + 1) * state.puzzle.length),
    );

    state = state.copyWith(
      puzzle: puzzle,
      moves: state.moves - 1,
      score: state.score - 5, // Small penalty for undoing
      previousMoves: previousMoves,
    );

    _updateCorrectPositions();
  }

  void _updateCorrectPositions() {
    final size = state.puzzle.length;
    final correctPositions = List<bool>.filled(size * size, false);
    var expectedValue = 1;

    for (var i = 0; i < size; i++) {
      for (var j = 0; j < size; j++) {
        if (i == size - 1 && j == size - 1) {
          correctPositions[i * size + j] = state.puzzle[i][j] == 0;
        } else {
          correctPositions[i * size + j] = state.puzzle[i][j] == expectedValue;
          expectedValue++;
        }
      }
    }

    state = state.copyWith(correctPositions: correctPositions);
  }

  void _handleGameWin() {
    final baseScore = state.difficulty.baseScore;
    final timeBonus = max(0, state.difficulty.timeLimit - state.timeElapsed) * 10;
    final moveBonus = max(0, state.difficulty.moveLimit - state.moves) * 20;
    final hintPenalty = (state.difficulty.initialHints - state.hintsRemaining) * 100;
    final finalScore = baseScore + timeBonus + moveBonus - hintPenalty;

    state = state.copyWith(
      status: GameStatus.completed,
      score: max(0, finalScore),
      bestScore: max(finalScore, state.bestScore),
      bestTime: state.bestTime == 0 ? state.timeElapsed : min(state.timeElapsed, state.bestTime),
      gamesWon: state.gamesWon + 1,
      gamesPlayed: state.gamesPlayed + 1,
      currentStreak: state.currentStreak + 1,
      bestStreak: max(state.currentStreak + 1, state.bestStreak),
      isComplete: true,
      hasWon: true,
    );
    _timer?.cancel();
  }

  void _gameOver() {
    state = state.copyWith(
      status: GameStatus.gameOver,
      gamesPlayed: state.gamesPlayed + 1,
      currentStreak: 0,
      isComplete: true,
      hasWon: false,
    );
    _timer?.cancel();
  }

  (int, int) _findEmptyTile(List<List<int>> puzzle) {
    for (var i = 0; i < puzzle.length; i++) {
      for (var j = 0; j < puzzle[i].length; j++) {
        if (puzzle[i][j] == 0) {
          return (i, j);
        }
      }
    }
    return (-1, -1);
  }

  bool _isValidMove(int row, int col, (int, int) emptyTile) {
    final (emptyRow, emptyCol) = emptyTile;
    return (row == emptyRow && (col == emptyCol - 1 || col == emptyCol + 1)) ||
           (col == emptyCol && (row == emptyRow - 1 || row == emptyRow + 1));
  }

  void _swapTiles(List<List<int>> puzzle, int row1, int col1, int row2, int col2) {
    final temp = puzzle[row1][col1];
    puzzle[row1][col1] = puzzle[row2][col2];
    puzzle[row2][col2] = temp;
  }

  bool _isPuzzleSolved(List<List<int>> puzzle) {
    int expectedValue = 1;
    final totalTiles = puzzle.length * puzzle[0].length;
    
    for (var i = 0; i < puzzle.length; i++) {
      for (var j = 0; j < puzzle[i].length; j++) {
        if (i == puzzle.length - 1 && j == puzzle[i].length - 1) {
          return puzzle[i][j] == 0;
        }
        if (puzzle[i][j] != expectedValue) {
          return false;
        }
        expectedValue++;
      }
    }
    return true;
  }

  (int, int)? _findCorrectMove((int, int,) emptyTile) {
    final (emptyRow, emptyCol) = emptyTile;
    final directions = [
      (-1, 0), // up
      (1, 0),  // down
      (0, -1), // left
      (0, 1),  // right
    ];

    for (final (dRow, dCol) in directions) {
      final newRow = emptyRow + dRow;
      final newCol = emptyCol + dCol;

      if (newRow >= 0 && newRow < state.puzzle.length &&
          newCol >= 0 && newCol < state.puzzle[0].length) {
        final value = state.puzzle[newRow][newCol];
        final correctRow = (value - 1) ~/ state.puzzle.length;
        final correctCol = (value - 1) % state.puzzle.length;

        if (correctRow == emptyRow && correctCol == emptyCol) {
          return (newRow, newCol);
        }
      }
    }
    return null;
  }

  int _calculateMoveScore() {
    final basePoints = 10;
    final timeMultiplier = max(0, 1 - (state.timeElapsed / state.difficulty.timeLimit));
    final streakBonus = state.currentStreak * 2;
    return (basePoints * (1 + timeMultiplier) + streakBonus).round();
  }
} 