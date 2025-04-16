import 'package:flutter/material.dart';
import '../models/game_state.dart';

class PuzzleBoard extends StatelessWidget {
  final List<List<int>> puzzle;
  final Function(int, int) onTileTap;

  const PuzzleBoard({
    super.key,
    required this.puzzle,
    required this.onTileTap,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(
            puzzle.length,
            (row) => Row(
              mainAxisSize: MainAxisSize.min,
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
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(4.0),
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: value == 0 ? Colors.transparent : Colors.blue,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: value == 0
            ? null
            : Center(
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