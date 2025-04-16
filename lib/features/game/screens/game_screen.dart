import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import '../models/game_state.dart';
import '../widgets/puzzle_board.dart';
import '../widgets/game_controls.dart';
import '../widgets/game_stats.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Puzzle Game'),
        actions: [
          IconButton(
            icon: Icon(gameState.status == GameStatus.paused ? Icons.play_arrow : Icons.pause),
            onPressed: () => ref.read(gameProvider.notifier).togglePause(),
          ),
        ],
      ),
      body: Column(
        children: [
          GameStats(
            gameState: gameState,
          ),
          Expanded(
            child: PuzzleBoard(
              puzzle: gameState.puzzle,
              onTileTap: (row, col) => ref.read(gameProvider.notifier).moveTile(row, col),
            ),
          ),
          GameControls(
            gameState: gameState,
            onNewGame: () => ref.read(gameProvider.notifier).startNewGame(gameState.difficulty),
            onUndo: () {},
          ),
        ],
      ),
    );
  }
} 