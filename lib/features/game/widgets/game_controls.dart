import 'package:flutter/material.dart';
import '../models/game_state.dart';

class GameControls extends StatelessWidget {
  final GameState gameState;
  final VoidCallback onNewGame;
  final VoidCallback onUndo;

  const GameControls({
    super.key,
    required this.gameState,
    required this.onNewGame,
    required this.onUndo,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ElevatedButton(
            onPressed: onNewGame,
            child: const Text('New Game'),
          ),
          ElevatedButton(
            onPressed: gameState.canUndo ? onUndo : null,
            child: const Text('Undo'),
          ),
        ],
      ),
    );
  }
} 