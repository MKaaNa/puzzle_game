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

  GameProvider(GameDifficulty difficulty) : super(GameState.initial(
    difficulty: difficulty,
    mode: GameMode.classic,
  ));

  void startNewGame(GameDifficulty difficulty) {
    final size = difficulty.size;
    final tiles = List.generate(size * size, (index) => (index + 1) % (size * size));
    
    // Shuffle tiles until we get a solvable puzzle
    do {
      tiles.shuffle();
    } while (!_isSolvablePuzzle(tiles));
    
    state = GameState.initial(
      difficulty: difficulty,
      mode: GameMode.classic,
    ).copyWith(
      tiles: tiles,
      emptyTileIndex: tiles.indexOf(0),
      status: GameStatus.playing,
      isActive: true,
    );
    
    _startTimer();
  }

  bool _isSolvablePuzzle(List<int> tiles) {
    final size = sqrt(tiles.length).toInt();
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

  void startGame() {
    if (state.status == GameStatus.initial) {
      state = state.copyWith(
        status: GameStatus.playing,
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

    // Update correct positions
    final size = sqrt(state.tiles.length).toInt();
    final newCorrectPositions = List<List<bool>>.from(
      state.correctPositions.map((row) => List<bool>.from(row)),
    );

    // Check if any tile is in correct position
    bool anyTileCorrect = false;
    for (int i = 0; i < newTiles.length; i++) {
      final row = i ~/ size;
      final col = i % size;
      final expectedValue = i == newTiles.length - 1 ? 0 : i + 1;
      newCorrectPositions[row][col] = newTiles[i] == expectedValue;
      if (newTiles[i] == expectedValue && i == tileIndex) {
        anyTileCorrect = true;
      }
    }

    // Calculate power points
    final powerPointsEarned = _calculatePowerPoints(anyTileCorrect);

    state = state.copyWith(
      tiles: newTiles,
      emptyTileIndex: tileIndex,
      moveCount: state.moveCount + 1,
      correctPositions: newCorrectPositions,
      showingCorrectTile: anyTileCorrect,
      lastMoveTime: DateTime.now(),
      lastMoveIndex: tileIndex,
      powerPoints: state.powerPoints + powerPointsEarned,
    );

    // Show correct tile animation
    if (anyTileCorrect) {
      Future.delayed(const Duration(milliseconds: 500), () {
        if (!mounted) return;
        state = state.copyWith(showingCorrectTile: false);
      });
    }

    if (_isPuzzleSolved()) {
      _handleGameWin();
    }
  }

  bool _isValidMove(int tileIndex) {
    final emptyIndex = state.emptyTileIndex;
    final size = sqrt(state.tiles.length).toInt();

    final row = tileIndex ~/ size;
    final col = tileIndex % size;
    final emptyRow = emptyIndex ~/ size;
    final emptyCol = emptyIndex % size;

    return (row == emptyRow && (col == emptyCol - 1 || col == emptyCol + 1)) ||
           (col == emptyCol && (row == emptyRow - 1 || row == emptyRow + 1));
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
    final baseScore = state.difficulty.baseScore;
    final timeBonus = max(0, state.difficulty.timeLimit.inSeconds - state.elapsedTime.inSeconds) * 10;
    final moveBonus = max(0, state.difficulty.moveLimit - state.moveCount) * 5;
    final hintPenalty = (state.difficulty.maxHints - state.hintsRemaining) * 100;
    
    return max(0, baseScore + timeBonus + moveBonus - hintPenalty);
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
    if (state.status == GameStatus.playing) {
      state = state.copyWith(
        status: GameStatus.paused,
        isActive: false,
      );
      _stopTimer();
    } else if (state.status == GameStatus.paused) {
      state = state.copyWith(
        status: GameStatus.playing,
        isActive: true,
      );
      _startTimer();
    }
  }

  void showHint() {
    if (state.hintsRemaining <= 0 || !state.isActive || state.isComplete) return;

    final bestMove = _findBestMove();
    if (bestMove != null) {
      state = state.copyWith(
        isShowingHint: true,
        hintTileIndex: bestMove,
        hintsRemaining: state.hintsRemaining - 1,
      );

      // 2 saniye sonra ipucunu kaldır
      Future.delayed(const Duration(seconds: 2), () {
        if (!mounted) return;
        state = state.copyWith(
          isShowingHint: false,
          hintTileIndex: null,
        );
      });
    }
  }

  int? _findBestMove() {
    final size = sqrt(state.tiles.length).toInt();
    final emptyIndex = state.emptyTileIndex;
    final possibleMoves = <int>[];

    // Boş karenin etrafındaki kareleri kontrol et
    if (emptyIndex % size > 0) possibleMoves.add(emptyIndex - 1); // Sol
    if (emptyIndex % size < size - 1) possibleMoves.add(emptyIndex + 1); // Sağ
    if (emptyIndex >= size) possibleMoves.add(emptyIndex - size); // Yukarı
    if (emptyIndex < state.tiles.length - size) possibleMoves.add(emptyIndex + size); // Aşağı

    // En iyi hamleyi bul
    int? bestMove;
    int maxImprovement = -1;

    for (final move in possibleMoves) {
      final tile = state.tiles[move];
      final targetIndex = tile - 1;
      if (targetIndex < 0) continue; // Boş kare için atla

      final currentDistance = _getManhattanDistance(move, targetIndex);
      final newDistance = _getManhattanDistance(emptyIndex, targetIndex);
      final improvement = currentDistance - newDistance;

      if (improvement > maxImprovement) {
        maxImprovement = improvement;
        bestMove = move;
      }
    }

    return bestMove;
  }

  int _getManhattanDistance(int pos1, int pos2) {
    final size = sqrt(state.tiles.length).toInt();
    final row1 = pos1 ~/ size;
    final col1 = pos1 % size;
    final row2 = pos2 ~/ size;
    final col2 = pos2 % size;
    return (row1 - row2).abs() + (col1 - col2).abs();
  }

  void onHintAnimationComplete() {
    // This method is intentionally empty as we handle the move in showHint
  }

  int _calculatePowerPoints(bool isCorrectMove) {
    int points = 0;
    
    // Doğru hamle için bonus puan
    if (isCorrectMove) {
      points += 5;
    }
    
    // Streak bonusu
    if (state.currentStreak > 0) {
      points += state.currentStreak;
    }
    
    // Zorluk seviyesi bonusu
    points += state.difficulty.index + 1;
    
    return points;
  }

  void usePowerUp(PowerUp powerUp) {
    if (!state.isActive || state.isComplete) return;
    
    // Güç puanı kontrolü
    final powerCost = _getPowerUpCost(powerUp);
    if (state.powerPoints < powerCost) return;
    
    switch (powerUp) {
      case PowerUp.swap:
        _useSwapPower();
        break;
      case PowerUp.shuffle:
        _useShufflePower();
        break;
      case PowerUp.freeze:
        _useFreezePower();
        break;
      case PowerUp.reveal:
        _useRevealPower();
        break;
      case PowerUp.undo:
        _useUndoPower();
        break;
    }
    
    // Güç puanını düş
    state = state.copyWith(
      powerPoints: state.powerPoints - powerCost,
      activePowerUps: [...state.activePowerUps, powerUp],
    );
  }

  int _getPowerUpCost(PowerUp powerUp) {
    switch (powerUp) {
      case PowerUp.swap:
        return 10;
      case PowerUp.shuffle:
        return 15;
      case PowerUp.freeze:
        return 20;
      case PowerUp.reveal:
        return 25;
      case PowerUp.undo:
        return 5;
    }
  }

  void _useSwapPower() {
    if (state.lastMoveIndex == null) return;
    
    final newTiles = List<int>.from(state.tiles);
    final emptyIndex = state.emptyTileIndex;
    final lastIndex = state.lastMoveIndex!;
    
    // İki parçayı yer değiştir
    newTiles[emptyIndex] = newTiles[lastIndex];
    newTiles[lastIndex] = 0;
    
    state = state.copyWith(
      tiles: newTiles,
      emptyTileIndex: lastIndex,
    );
  }

  void _useShufflePower() {
    final newTiles = List<int>.from(state.tiles);
    final emptyIndex = state.emptyTileIndex;
    
    // Boş kareyi hariç tutarak karıştır
    newTiles.removeAt(emptyIndex);
    newTiles.shuffle();
    newTiles.insert(emptyIndex, 0);
    
    state = state.copyWith(
      tiles: newTiles,
    );
  }

  void _useFreezePower() {
    if (state.isTimeFrozen) return;
    
    state = state.copyWith(isTimeFrozen: true);
    
    // 5 saniye sonra zamanı çöz
    Future.delayed(const Duration(seconds: 5), () {
      if (!mounted) return;
      state = state.copyWith(isTimeFrozen: false);
    });
  }

  void _useRevealPower() {
    final size = sqrt(state.tiles.length).toInt();
    final revealedPositions = <int>[];
    
    // Doğru pozisyonda olmayan parçaları bul
    for (int i = 0; i < state.tiles.length; i++) {
      final expectedValue = i == state.tiles.length - 1 ? 0 : i + 1;
      if (state.tiles[i] != expectedValue) {
        revealedPositions.add(i);
      }
    }
    
    state = state.copyWith(revealedPositions: revealedPositions);
    
    // 3 saniye sonra ipuçlarını kaldır
    Future.delayed(const Duration(seconds: 3), () {
      if (!mounted) return;
      state = state.copyWith(revealedPositions: []);
    });
  }

  void _useUndoPower() {
    if (state.lastMoveIndex == null) return;
    
    final newTiles = List<int>.from(state.tiles);
    final emptyIndex = state.emptyTileIndex;
    final lastIndex = state.lastMoveIndex!;
    
    // Son hamleyi geri al
    newTiles[emptyIndex] = newTiles[lastIndex];
    newTiles[lastIndex] = 0;
    
    state = state.copyWith(
      tiles: newTiles,
      emptyTileIndex: lastIndex,
      moveCount: state.moveCount - 1,
    );
  }

  @override
  void dispose() {
    _stopTimer();
    super.dispose();
  }
} 