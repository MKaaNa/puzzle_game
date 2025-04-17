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
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStat(
            'Skor',
            gameState.score.toString(),
            Icons.stars,
            Colors.amber,
          ),
          _buildStat(
            'Süre',
            gameState.formattedTime,
            Icons.timer,
            Colors.blue,
          ),
          _buildStat(
            'Hamle',
            gameState.moves.toString(),
            Icons.swap_horiz,
            Colors.green,
          ),
        ],
      ),
    );
  }

  Widget _buildStat(String label, String value, IconData icon, Color color) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.grey[600],
            fontSize: 12,
          ),
        ),
      ],
    );
  }
} 