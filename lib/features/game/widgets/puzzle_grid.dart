import 'package:flutter/material.dart';

class PuzzleGrid extends StatelessWidget {
  final List<List<int>> puzzle;
  final Function(int, int) onTileTap;

  const PuzzleGrid({
    super.key,
    required this.puzzle,
    required this.onTileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: List.generate(
          puzzle.length,
          (row) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              puzzle[row].length,
              (col) => _PuzzleTile(
                value: puzzle[row][col],
                onTap: () => onTileTap(row, col),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _PuzzleTile extends StatelessWidget {
  final int value;
  final VoidCallback onTap;

  const _PuzzleTile({
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (value == 0) {
      return const SizedBox(
        width: 60,
        height: 60,
      );
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 60,
        height: 60,
        margin: const EdgeInsets.all(4.0),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.primary,
          borderRadius: BorderRadius.circular(8.0),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 2,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Center(
          child: Text(
            value.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
} 