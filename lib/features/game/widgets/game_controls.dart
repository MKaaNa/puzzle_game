import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import '../models/game_state.dart';

class GameControls extends ConsumerWidget {
  const GameControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Hint Button
        Tooltip(
          message: 'İpucu Kullan (${gameState.hintsRemaining} kaldı)',
          child: ElevatedButton.icon(
            onPressed: gameState.canUseHint
                ? () => ref.read(gameProvider.notifier).useHint()
                : null,
            icon: const Icon(Icons.lightbulb_outline),
            label: Text('İpucu (${gameState.hintsRemaining})'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              foregroundColor: Colors.black87,
              disabledBackgroundColor: Colors.amber.withOpacity(0.3),
            ),
          ),
        ),

        // Undo Button
        Tooltip(
          message: 'Son Hamleyi Geri Al',
          child: ElevatedButton.icon(
            onPressed: gameState.canUndo
                ? () => ref.read(gameProvider.notifier).undo()
                : null,
            icon: const Icon(Icons.undo),
            label: const Text('Geri Al'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              disabledBackgroundColor: Colors.blue.withOpacity(0.3),
            ),
          ),
        ),
      ],
    );
  }
} 