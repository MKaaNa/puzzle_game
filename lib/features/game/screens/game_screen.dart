import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:puzzle_game/features/game/providers/game_provider.dart';
import 'package:puzzle_game/features/game/widgets/game_controls.dart';
import 'package:puzzle_game/features/game/widgets/game_stats.dart';
import 'package:puzzle_game/features/game/widgets/puzzle_grid.dart';
import 'package:puzzle_game/features/game/widgets/hint_mascot.dart';
import 'dart:math';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
        body: Container(
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
          child: SafeArea(
            child: Stack(
              children: [
                Column(
                  children: [
                    const GameStats(),
                    const SizedBox(height: 20),
                    Expanded(
                      child: LayoutBuilder(
                        builder: (context, constraints) {
                          final size = sqrt(gameState.tiles.length).toInt();
                          final tileSize = constraints.maxWidth / size;
                          
                          return Stack(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: AspectRatio(
                                  aspectRatio: 1,
                                  child: PuzzleGrid(
                                    puzzle: _convertTilesToGrid(gameState.tiles),
                                    onTileTap: (row, col) {
                                      final index = row * size + col;
                                      gameNotifier.moveTile(index);
                                    },
                                    correctPositions: _convertCorrectPositions(gameState.correctPositions),
                                  ),
                                ),
                              ),
                              if (gameState.isShowingHint && gameState.hintTileIndex != null)
                                Positioned.fill(
                                  child: HintMascot(
                                    targetPosition: _calculateTilePosition(
                                      gameState.hintTileIndex!,
                                      constraints.maxWidth - 32, // Padding'i çıkar
                                      constraints.maxHeight,
                                    ),
                                    onAnimationComplete: gameNotifier.onHintAnimationComplete,
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    const GameControls(),
                  ],
                ),
              ],
            ),
          ),
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