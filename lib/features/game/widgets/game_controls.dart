import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import '../models/game_state.dart';
import '../models/game_difficulty.dart';

class GameControls extends ConsumerWidget {
  final GameState gameState;

  const GameControls({
    super.key,
    required this.gameState,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameNotifier = ref.read(gameProvider.notifier);

    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // Power Points Display
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.bolt, color: Colors.blue),
                const SizedBox(width: 8),
                Text(
                  '${gameState.powerPoints}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Power Buttons
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildPowerButton(
                  context,
                  gameNotifier,
                  PowerUp.swap,
                  'Swap',
                  5,
                  Icons.swap_horiz,
                ),
                _buildPowerButton(
                  context,
                  gameNotifier,
                  PowerUp.shuffle,
                  'Shuffle',
                  10,
                  Icons.shuffle,
                ),
                _buildPowerButton(
                  context,
                  gameNotifier,
                  PowerUp.freeze,
                  'Freeze',
                  15,
                  Icons.timer_off,
                ),
                _buildPowerButton(
                  context,
                  gameNotifier,
                  PowerUp.reveal,
                  'Reveal',
                  20,
                  Icons.visibility,
                ),
                _buildPowerButton(
                  context,
                  gameNotifier,
                  PowerUp.undo,
                  'Undo',
                  25,
                  Icons.undo,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // Main Controls
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildControlButton(
                context,
                'New Game',
                Icons.refresh,
                () => gameNotifier.startNewGame(gameState.difficulty),
              ),
              _buildControlButton(
                context,
                'Hint',
                Icons.lightbulb,
                () => _handleHint(context, gameNotifier),
                isEnabled: gameState.canUseHint,
              ),
              _buildControlButton(
                context,
                gameState.status == GameStatus.paused ? 'Resume' : 'Pause',
                gameState.status == GameStatus.paused ? Icons.play_arrow : Icons.pause,
                () => gameNotifier.togglePause(),
                isEnabled: gameState.status == GameStatus.playing || gameState.status == GameStatus.paused,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPowerButton(
    BuildContext context,
    GameProvider gameNotifier,
    PowerUp powerUp,
    String label,
    int cost,
    IconData icon,
  ) {
    final canUse = gameState.powerPoints >= cost;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: canUse ? Colors.blue : Colors.grey,
              borderRadius: BorderRadius.circular(15),
            ),
            child: IconButton(
              icon: Icon(icon, color: Colors.white),
              onPressed: canUse
                  ? () => gameNotifier.usePowerUp(powerUp)
                  : null,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$label\n$cost',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: canUse ? Colors.blue : Colors.grey,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton(
    BuildContext context,
    String label,
    IconData icon,
    VoidCallback onPressed, {
    bool isEnabled = true,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isEnabled
                  ? [Colors.blue, Colors.lightBlue]
                  : [Colors.grey, Colors.grey],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: IconButton(
            icon: Icon(icon, color: Colors.white),
            onPressed: isEnabled ? onPressed : null,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: isEnabled ? Colors.blue : Colors.grey,
          ),
        ),
      ],
    );
  }

  void _handleHint(BuildContext context, GameProvider gameNotifier) {
    if (gameState.canUseHint) {
      gameNotifier.showHint();
    }
  }
} 