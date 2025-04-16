import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../game/models/game_state.dart';
import '../../game/screens/game_screen.dart';
import '../../game/providers/game_provider.dart';
import '../../common/widgets/logo_widget.dart';

class MainMenuScreen extends ConsumerWidget {
  const MainMenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sliding Puzzle'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Sliding Puzzle',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 40),
            _buildDifficultyButton(
              context,
              'Easy',
              GameDifficulty.easy,
              ref,
            ),
            const SizedBox(height: 16),
            _buildDifficultyButton(
              context,
              'Medium',
              GameDifficulty.medium,
              ref,
            ),
            const SizedBox(height: 16),
            _buildDifficultyButton(
              context,
              'Hard',
              GameDifficulty.hard,
              ref,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDifficultyButton(
    BuildContext context,
    String text,
    GameDifficulty difficulty,
    WidgetRef ref,
  ) {
    return ElevatedButton(
      onPressed: () {
        ref.read(gameProvider.notifier).startNewGame(difficulty);
        Navigator.pushNamed(context, '/game');
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
      ),
      child: Text(
        text,
        style: const TextStyle(fontSize: 18),
      ),
    );
  }
} 