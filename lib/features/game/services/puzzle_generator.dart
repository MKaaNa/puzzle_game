import 'dart:math';
import 'package:puzzle_game/features/game/models/game_state.dart';

class PuzzleGenerator {
  static List<List<int>> generatePuzzle(GameDifficulty difficulty) {
    final size = _getSizeForDifficulty(difficulty);
    final totalTiles = size * size;
    final numbers = List.generate(totalTiles, (index) => index);
    numbers.shuffle(Random());
    
    // Ensure the puzzle is solvable
    while (!_isSolvable(numbers)) {
      numbers.shuffle(Random());
    }
    
    // Convert to 2D array
    final puzzle = <List<int>>[];
    for (var i = 0; i < size; i++) {
      puzzle.add(numbers.sublist(i * size, (i + 1) * size));
    }
    
    return puzzle;
  }
  
  static int _getSizeForDifficulty(GameDifficulty difficulty) {
    switch (difficulty) {
      case GameDifficulty.easy:
        return 3;
      case GameDifficulty.medium:
        return 4;
      case GameDifficulty.hard:
        return 5;
    }
  }
  
  static bool _isSolvable(List<int> numbers) {
    int inversions = 0;
    final size = sqrt(numbers.length).toInt();
    final emptyTileRow = numbers.indexOf(0) ~/ size;
    
    for (int i = 0; i < numbers.length - 1; i++) {
      for (int j = i + 1; j < numbers.length; j++) {
        if (numbers[i] != 0 && numbers[j] != 0 && numbers[i] > numbers[j]) {
          inversions++;
        }
      }
    }
    
    if (size % 2 == 1) {
      return inversions % 2 == 0;
    } else {
      return (inversions + emptyTileRow) % 2 == 1;
    }
  }
} 