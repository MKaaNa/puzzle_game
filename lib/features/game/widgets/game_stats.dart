import 'package:flutter/material.dart';
import '../models/game_state.dart';

class GameStats extends StatelessWidget {
  final GameState gameState;

  const GameStats({
    super.key,
    required this.gameState,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Moves: ${gameState.moves}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Score: ${gameState.score}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'Time: ${gameState.formattedTime}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
} 