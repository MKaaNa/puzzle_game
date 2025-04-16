import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import '../widgets/puzzle_grid.dart';
import '../../features/game/models/game_state.dart';

class GameScreen extends ConsumerWidget {
  const GameScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sliding Puzzle'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              // TODO: Show leaderboard
            },
          ),
          IconButton(
            icon: Icon(
              gameState.isPaused ? Icons.play_arrow : Icons.pause,
            ),
            onPressed: () => ref.read(gameProvider.notifier).togglePause(),
          ),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildInfoCard(
                    icon: Icons.swap_horiz,
                    label: 'Moves',
                    value: gameState.moveCount.toString(),
                  ),
                  _buildInfoCard(
                    icon: Icons.timer,
                    label: 'Time',
                    value: gameState.formattedTime,
                  ),
                  _buildInfoCard(
                    icon: Icons.grid_4x4,
                    label: 'Difficulty',
                    value: gameState.difficulty.label,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _buildScoreCard(gameState),
              const SizedBox(height: 16),
              const Expanded(child: PuzzleGrid()),
              const SizedBox(height: 16),
              ElevatedButton.icon(
                onPressed: () {
                  ref.read(gameProvider.notifier).startNewGame(
                    mode: GameMode.classic,
                    difficulty: GameDifficulty.easy,
                  );
                },
                icon: const Icon(Icons.refresh),
                label: const Text('New Game'),
              ),
              const SizedBox(height: 24),
              const Text(
                'High Scores',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildHighScoreCard('Easy', gameState.highScores[GameDifficulty.easy] ?? 0),
                  _buildHighScoreCard('Medium', gameState.highScores[GameDifficulty.medium] ?? 0),
                  _buildHighScoreCard('Hard', gameState.highScores[GameDifficulty.hard] ?? 0),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String label,
    required String value,
  }) {
    return Column(
      children: [
        Icon(icon),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildScoreCard(GameState gameState) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.star, color: Colors.amber),
        const SizedBox(width: 8),
        Text(
          'Current Score: ${gameState.score}',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildHighScoreCard(String difficulty, int score) {
    return Column(
      children: [
        Text(
          difficulty,
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        Text(
          score.toString(),
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
} 