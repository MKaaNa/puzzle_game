import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import '../widgets/game_controls.dart';
import '../widgets/game_stats.dart';
import '../widgets/puzzle_grid.dart';
import '../widgets/hint_mascot.dart';
import '../models/game_state.dart';
import 'dart:math';
import '../widgets/game_mascot.dart';
import '../widgets/tutorial_overlay.dart';

class GameScreen extends ConsumerStatefulWidget {
  const GameScreen({super.key});

  @override
  ConsumerState<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends ConsumerState<GameScreen> {
  bool _showTutorial = true;

  @override
  void initState() {
    super.initState();
    // Oyunu başlat
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(gameProvider.notifier).startGame();
    });
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameProvider);
    final gameNotifier = ref.read(gameProvider.notifier);

    return WillPopScope(
      onWillPop: () async {
        final shouldPop = await _showExitDialog(context);
        return shouldPop ?? false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Puzzle Master'),
          centerTitle: true,
          actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () => _showRestartDialog(context, ref),
            ),
          ],
        ),
        body: Stack(
          children: [
            // Arka plan
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF6A1B9A), // Deep Purple
                    const Color(0xFF9C27B0), // Medium Purple
                    const Color(0xFFAB47BC), // Light Purple
                  ],
                  stops: const [0.0, 0.6, 1.0],
                ),
              ),
            ),
            
            // Ana içerik
            SafeArea(
              child: Column(
                children: [
                  // Oyun istatistikleri
                  GameStats(gameState: gameState),
                  
                  // Oyun ızgarası
                  Expanded(
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        final size = sqrt(gameState.tiles.length).toInt();
                        
                        return Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: AspectRatio(
                                aspectRatio: 1,
                                child: PuzzleGrid(
                                  puzzle: _convertTilesToGrid(gameState.tiles),
                                  onTileTap: (row, col) {
                                    if (!gameState.isActive) {
                                      gameNotifier.startGame();
                                      return;
                                    }
                                    final index = row * size + col;
                                    gameNotifier.moveTile(index);
                                  },
                                  correctPositions: _convertCorrectPositions(gameState.correctPositions),
                                  movingTileIndex: gameState.movingTileIndex,
                                ),
                              ),
                            ),
                            
                            // Maskot overlay (sadece gerekli durumlarda)
                            if (gameState.isShowingHint || gameState.isComplete || 
                                gameState.isIdle || gameState.showingCorrectTile)
                              Positioned.fill(
                                child: GameMascot(),
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                  
                  // Oyun kontrolleri
                  GameControls(gameState: gameState),
                ],
              ),
            ),
            // Eğitim overlay'i
            if (_showTutorial)
              TutorialOverlay(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _showTutorial = !_showTutorial;
            });
          },
          child: Icon(_showTutorial ? Icons.visibility_off : Icons.help_outline),
        ),
      ),
    );
  }

  List<List<int>> _convertTilesToGrid(List<int> tiles) {
    final size = sqrt(tiles.length).toInt();
    final grid = List<List<int>>.generate(size, (_) => List<int>.filled(size, 0));
    for (int i = 0; i < tiles.length; i++) {
      final row = i ~/ size;
      final col = i % size;
      grid[row][col] = tiles[i];
    }
    return grid;
  }

  List<bool> _convertCorrectPositions(List<List<bool>> positions) {
    final result = <bool>[];
    for (final row in positions) {
      result.addAll(row);
    }
    return result;
  }

  Offset _calculateTilePosition(int tileIndex, double width, double height) {
    final size = sqrt(width).toInt();
    final tileSize = width / size;
    final row = tileIndex ~/ size;
    final col = tileIndex % size;
    
    return Offset(
      col * tileSize + tileSize / 2,
      row * tileSize + tileSize / 2,
    );
  }

  Future<bool?> _showExitDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Çıkış'),
        content: const Text('Oyunu terk etmek istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hayır'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Evet'),
          ),
        ],
      ),
    );
  }

  Future<void> _showRestartDialog(BuildContext context, WidgetRef ref) async {
    final shouldRestart = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Yeniden Başlat'),
        content: const Text('Oyunu yeniden başlatmak istediğinizden emin misiniz?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Hayır'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Evet'),
          ),
        ],
      ),
    );

    if (shouldRestart == true) {
      ref.read(gameProvider.notifier).startNewGame(ref.read(gameProvider).difficulty);
    }
  }
} 