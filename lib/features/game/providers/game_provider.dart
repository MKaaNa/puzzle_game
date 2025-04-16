import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game_state.dart';
import '../services/puzzle_generator.dart';

final gameProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier();
});

class GameNotifier extends StateNotifier<GameState> {
  GameNotifier() : super(GameState.initial());

  void startNewGame(GameDifficulty difficulty) {
    final puzzle = PuzzleGenerator.generatePuzzle(difficulty);
    state = GameState(
      status: GameStatus.inProgress,
      puzzle: puzzle,
      moves: 0,
      score: 0,
      difficulty: difficulty,
      time: 0,
      correctPositions: List.filled(puzzle.length * puzzle[0].length, false),
    );
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

    final puzzle = List<List<int>>.from(state.puzzle);
    final emptyTile = _findEmptyTile(puzzle);
    
    if (_isValidMove(row, col, emptyTile)) {
      _swapTiles(puzzle, row, col, emptyTile.$1, emptyTile.$2);
      
      state = state.copyWith(
        puzzle: puzzle,
        moves: state.moves + 1,
      );

      if (_isPuzzleSolved(puzzle)) {
        state = state.copyWith(status: GameStatus.completed);
      }
    }
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
    for (var row in puzzle) {
      for (var value in row) {
        if (value != 0 && value != expectedValue) {
          return false;
        }
        expectedValue++;
      }
    }
    return true;
  }
} 