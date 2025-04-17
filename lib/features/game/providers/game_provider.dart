import 'dart:async';
import 'dart:math';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game_state.dart';
import '../models/game_difficulty.dart';
import 'package:uuid/uuid.dart';

final gameProvider = StateNotifierProvider<GameProvider, GameState>((ref) {
  return GameProvider(GameDifficulty.medium);
});

class GameProvider extends StateNotifier<GameState> {
  Timer? _timer;
  final GameDifficulty difficulty;

  GameProvider(this.difficulty) : super(GameState.initial(difficulty: difficulty));

  void startNewGame(GameDifficulty difficulty) {
    state = GameState.initial(difficulty: difficulty);
  }

  void startGame() {
    if (state.status == GameStatus.initial) {
      state = state.copyWith(
        status: GameStatus.inProgress,
        isActive: true,
      );
      _startTimer();
    }
  }

  void pauseGame() {
    if (state.status == GameStatus.inProgress) {
      state = state.copyWith(
        status: GameStatus.paused,
        isActive: false,
      );
      _stopTimer();
    }
  }

  void resumeGame() {
    if (state.status == GameStatus.paused) {
      state = state.copyWith(
        status: GameStatus.inProgress,
        isActive: true,
      );
      _startTimer();
    }
  }

  void moveTile(int tileIndex) {
    if (!state.isActive || state.isComplete) return;
    if (!_isValidMove(tileIndex)) return;

    final newTiles = List<int>.from(state.tiles);
    final emptyIndex = state.emptyTileIndex;

    // Swap tiles
    newTiles[emptyIndex] = newTiles[tileIndex];
    newTiles[tileIndex] = 0;

    state = state.copyWith(
      tiles: newTiles,
      emptyTileIndex: tileIndex,
      moveCount: state.moveCount + 1,
    );

    if (_isPuzzleSolved()) {
      _handleGameWin();
    }
  }

  bool _isValidMove(int tileIndex) {
    final emptyIndex = state.emptyTileIndex;
    final size = sqrt(state.tiles.length).toInt();

    // Check if the tile is adjacent to the empty tile
    return (tileIndex == emptyIndex - 1 && tileIndex % size != size - 1) ||
        (tileIndex == emptyIndex + 1 && tileIndex % size != 0) ||
        tileIndex == emptyIndex - size ||
        tileIndex == emptyIndex + size;
  }

  bool _isPuzzleSolved() {
    for (int i = 0; i < state.tiles.length - 1; i++) {
      if (state.tiles[i] != i + 1) return false;
    }
    return state.tiles.last == 0;
  }

  void _handleGameWin() {
    _stopTimer();
    state = state.copyWith(
      status: GameStatus.completed,
      isComplete: true,
      isActive: false,
      score: _calculateScore(),
    );
  }

  int _calculateScore() {
    final timeScore = (state.elapsedTime.inSeconds * 10).toInt();
    final moveScore = state.moveCount * 5;
    return 1000 - timeScore - moveScore;
  }

  void _startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      state = state.copyWith(
        elapsedTime: state.elapsedTime + const Duration(seconds: 1),
      );
    });
  }

  void _stopTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void togglePause() {
    if (state.status == GameStatus.inProgress) {
      pauseGame();
    } else if (state.status == GameStatus.paused) {
      resumeGame();
    }
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }

  void showHint() {
    if (state.isShowingHint || !state.isActive || state.hintsRemaining <= 0) return;

    final correctMove = _findCorrectMove();
    if (correctMove != null) {
      state = state.copyWith(
        isShowingHint: true,
        hintTileIndex: correctMove,
        hintsRemaining: state.hintsRemaining - 1,
      );

      // Hide hint after animation
      Future.delayed(const Duration(milliseconds: 2000), () {
        if (mounted) {
          state = state.copyWith(
            isShowingHint: false,
            hintTileIndex: null,
          );
        }
      });
    }
  }

  void onHintAnimationComplete() {
    if (state.hintTileIndex != null) {
      final tileIndex = state.tiles.indexOf(state.hintTileIndex!);
      if (tileIndex != -1) {
        moveTile(tileIndex);
      }
    }
  }

  int? _findCorrectMove() {
    final tiles = state.tiles;
    final emptyIndex = state.emptyTileIndex;
    final size = sqrt(tiles.length).toInt();

    // Get possible moves
    final possibleMoves = <int>[];
    
    // Check left
    if (emptyIndex % size > 0) {
      possibleMoves.add(emptyIndex - 1);
    }
    // Check right
    if (emptyIndex % size < size - 1) {
      possibleMoves.add(emptyIndex + 1);
    }
    // Check up
    if (emptyIndex >= size) {
      possibleMoves.add(emptyIndex - size);
    }
    // Check down
    if (emptyIndex < tiles.length - size) {
      possibleMoves.add(emptyIndex + size);
    }

    // Find the move that brings a tile closer to its correct position
    int? bestMove;
    int bestScore = -1;

    for (final moveIndex in possibleMoves) {
      final tile = tiles[moveIndex];
      final currentDistance = _calculateManhattanDistance(moveIndex, tile - 1, size);
      final newDistance = _calculateManhattanDistance(emptyIndex, tile - 1, size);

      if (newDistance < currentDistance) {
        final score = currentDistance - newDistance;
        if (score > bestScore) {
          bestScore = score;
          bestMove = tile;
        }
      }
    }

    return bestMove;
  }

  int _calculateManhattanDistance(int currentIndex, int targetIndex, int size) {
    final currentRow = currentIndex ~/ size;
    final currentCol = currentIndex % size;
    final targetRow = targetIndex ~/ size;
    final targetCol = targetIndex % size;
    
    return (currentRow - targetRow).abs() + (currentCol - targetCol).abs();
  }
} 