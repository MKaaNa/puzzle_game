import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puzzle_game/features/game/models/game_state.dart';
import 'package:puzzle_game/features/game/services/puzzle_generator.dart';
import 'package:puzzle_game/features/game/services/daily_challenge_service.dart';
import 'package:puzzle_game/features/game/services/achievement_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final gameNotifierProvider = StateNotifierProvider<GameNotifier, GameState>((ref) {
  return GameNotifier();
});

class GameNotifier extends StateNotifier<GameState> {
  late final DailyChallengeService _dailyChallengeService;
  late final AchievementService _achievementService;
  
  GameNotifier() : super(GameState.initial()) {
    _initializeServices();
  }
  
  Future<void> _initializeServices() async {
    final prefs = await SharedPreferences.getInstance();
    _dailyChallengeService = DailyChallengeService(prefs);
    _achievementService = AchievementService(prefs);
  }
  
  Future<void> startNewGame({
    required GameMode mode,
    required GameDifficulty difficulty,
  }) async {
    List<List<int>> puzzle;
    
    if (mode == GameMode.dailyChallenge) {
      puzzle = await _dailyChallengeService.getDailyPuzzle();
    } else {
      puzzle = PuzzleGenerator.generatePuzzle(difficulty);
    }
    
    state = state.copyWith(
      mode: mode,
      difficulty: difficulty,
      grid: puzzle,
      status: GameStatus.playing,
      moves: 0,
      time: 0,
      score: 0,
      hintCount: difficulty.initialHints,
    );
  }
  
  void moveTile(int row, int col) {
    if (state.status != GameStatus.playing) return;
    
    final emptyPos = _findEmptyPosition();
    if (!_isValidMove(row, col, emptyPos)) return;
    
    // Taşı gerçekleştir
    final newGrid = List<List<int>>.from(state.grid.map((row) => List<int>.from(row)));
    newGrid[emptyPos.$1][emptyPos.$2] = newGrid[row][col];
    newGrid[row][col] = 0;
    
    state = state.copyWith(
      grid: newGrid,
      moves: state.moves + 1,
    );
    
    _checkGameCompletion();
  }
  
  void _checkGameCompletion() {
    if (_isPuzzleSolved()) {
      final score = _calculateScore();
      state = state.copyWith(
        status: GameStatus.completed,
        score: score,
      );
      
      // Başarıları kontrol et
      _achievementService.checkAndUnlockAchievements(
        moves: state.moves,
        time: state.time,
        hintsUsed: state.hintCount - state.hintCount,
        isDailyChallenge: state.mode == GameMode.dailyChallenge,
      );
      
      // Günlük meydan okuma skorunu kaydet
      if (state.mode == GameMode.dailyChallenge) {
        _dailyChallengeService.saveDailyScore(score);
      }
    }
  }
  
  bool _isPuzzleSolved() {
    final size = state.grid.length;
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        final expectedValue = i * size + j + 1;
        if (i == size - 1 && j == size - 1) {
          if (state.grid[i][j] != 0) return false;
        } else if (state.grid[i][j] != expectedValue) {
          return false;
        }
      }
    }
    return true;
  }
  
  int _calculateScore() {
    final baseScore = 1000;
    final movePenalty = state.moves * 10;
    final timePenalty = state.time ~/ 10;
    final hintPenalty = (state.hintCount - state.hintCount) * 50;
    
    return (baseScore - movePenalty - timePenalty - hintPenalty).clamp(0, 1000);
  }
  
  (int, int) _findEmptyPosition() {
    for (int i = 0; i < state.grid.length; i++) {
      for (int j = 0; j < state.grid[i].length; j++) {
        if (state.grid[i][j] == 0) {
          return (i, j);
        }
      }
    }
    throw Exception('Boş kare bulunamadı');
  }
  
  bool _isValidMove(int row, int col, (int, int) emptyPos) {
    return (row == emptyPos.$1 && (col == emptyPos.$2 - 1 || col == emptyPos.$2 + 1)) ||
           (col == emptyPos.$2 && (row == emptyPos.$1 - 1 || row == emptyPos.$1 + 1));
  }
  
  void useHint() {
    if (state.hintCount > 0) {
      state = state.copyWith(hintCount: state.hintCount - 1);
    }
  }
  
  void updateTime(int seconds) {
    if (state.status == GameStatus.playing) {
      state = state.copyWith(time: seconds);
    }
  }
} 