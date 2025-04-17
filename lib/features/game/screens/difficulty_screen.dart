import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/game_state.dart';
import '../models/game_difficulty.dart';
import '../providers/game_provider.dart';
import 'game_screen.dart';

class DifficultyScreen extends ConsumerWidget {
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Zorluk Seçimi'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Zorluk Seviyesi Seçin',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 32),
            ...GameDifficulty.values.map((difficulty) {
              final details = _getDifficultyDetails(difficulty);
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 8),
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(gameProvider.notifier).startNewGame(difficulty);
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const GameScreen()),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: details.color,
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            details.label,
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            details.description,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        details.icon,
                        color: Colors.white,
                        size: 32,
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      ),
    );
  }

  DifficultyDetails _getDifficultyDetails(GameDifficulty difficulty) {
    switch (difficulty) {
      case GameDifficulty.easy:
        return DifficultyDetails(
          label: 'Kolay',
          description: '3x3 Izgara, 5 İpucu',
          color: Colors.green,
          icon: Icons.sentiment_satisfied,
        );
      case GameDifficulty.medium:
        return DifficultyDetails(
          label: 'Orta',
          description: '4x4 Izgara, 3 İpucu',
          color: Colors.orange,
          icon: Icons.sentiment_neutral,
        );
      case GameDifficulty.hard:
        return DifficultyDetails(
          label: 'Zor',
          description: '5x5 Izgara, 2 İpucu',
          color: Colors.red,
          icon: Icons.sentiment_very_dissatisfied,
        );
    }
  }
}

class DifficultyDetails {
  final String label;
  final String description;
  final Color color;
  final IconData icon;

  const DifficultyDetails({
    required this.label,
    required this.description,
    required this.color,
    required this.icon,
  });
} 