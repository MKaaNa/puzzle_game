import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/game_provider.dart';
import '../models/game_state.dart';

class GameGrid extends ConsumerWidget {
  const GameGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameProvider);
    final gameNotifier = ref.read(gameProvider.notifier);
    final size = gameState.difficulty.size;

    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Colors.white.withOpacity(0.2),
            width: 2,
          ),
        ),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: size,
            mainAxisSpacing: 4,
            crossAxisSpacing: 4,
          ),
          itemCount: size * size,
          itemBuilder: (context, index) {
            final number = gameState.tiles[index];
            final isEmptyTile = number == 0;
            final isRevealed = gameState.revealedPositions.contains(index);
            final isHintTile = gameState.hintTileIndex == index;
            final isMovingTile = gameState.movingTileIndex == index;

            return AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              decoration: BoxDecoration(
                color: isEmptyTile
                    ? Colors.transparent
                    : Colors.white.withOpacity(0.15),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: _getTileBorderColor(
                    isEmptyTile: isEmptyTile,
                    isRevealed: isRevealed,
                    isHintTile: isHintTile,
                    isMovingTile: isMovingTile,
                  ),
                  width: 2,
                ),
                boxShadow: [
                  if (!isEmptyTile)
                    BoxShadow(
                      color: _getTileShadowColor(
                        isRevealed: isRevealed,
                        isHintTile: isHintTile,
                        isMovingTile: isMovingTile,
                      ),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                ],
              ),
              child: isEmptyTile
                  ? const SizedBox()
                  : Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () => gameNotifier.moveTile(index),
                        borderRadius: BorderRadius.circular(8),
                        child: Center(
                          child: Text(
                            number.toString(),
                            style: TextStyle(
                              color: _getTileTextColor(
                                isRevealed: isRevealed,
                                isHintTile: isHintTile,
                                isMovingTile: isMovingTile,
                              ),
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }

  Color _getTileBorderColor({
    required bool isEmptyTile,
    required bool isRevealed,
    required bool isHintTile,
    required bool isMovingTile,
  }) {
    if (isEmptyTile) return Colors.transparent;
    if (isMovingTile) return Colors.blue;
    if (isHintTile) return Colors.purple;
    if (isRevealed) return Colors.green;
    return Colors.white.withOpacity(0.3);
  }

  Color _getTileShadowColor({
    required bool isRevealed,
    required bool isHintTile,
    required bool isMovingTile,
  }) {
    if (isMovingTile) return Colors.blue.withOpacity(0.3);
    if (isHintTile) return Colors.purple.withOpacity(0.3);
    if (isRevealed) return Colors.green.withOpacity(0.3);
    return Colors.black.withOpacity(0.1);
  }

  Color _getTileTextColor({
    required bool isRevealed,
    required bool isHintTile,
    required bool isMovingTile,
  }) {
    if (isMovingTile) return Colors.blue;
    if (isHintTile) return Colors.purple;
    if (isRevealed) return Colors.green;
    return Colors.white;
  }
} 