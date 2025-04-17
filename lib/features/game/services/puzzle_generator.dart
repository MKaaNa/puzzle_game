import 'dart:math';
import '../models/game_difficulty.dart';

class PuzzleGenerator {
  static List<List<int>> generatePuzzle(GameDifficulty difficulty) {
    final size = difficulty.size;
    final tiles = List.generate(size * size, (index) => (index + 1) % (size * size));
    
    // Bulmacayı karıştır
    do {
      _shufflePuzzle(tiles);
    } while (!_isSolvable(tiles, size));
    
    // 1D listeyi 2D matrise dönüştür
    return _convertTo2D(tiles, size);
  }

  static void _shufflePuzzle(List<int> tiles) {
    final random = Random();
    for (var i = tiles.length - 1; i > 0; i--) {
      final j = random.nextInt(i + 1);
      final temp = tiles[i];
      tiles[i] = tiles[j];
      tiles[j] = temp;
    }
  }

  static bool _isSolvable(List<int> tiles, int size) {
    int inversions = 0;
    for (int i = 0; i < tiles.length - 1; i++) {
      if (tiles[i] == 0) continue;
      for (int j = i + 1; j < tiles.length; j++) {
        if (tiles[j] != 0 && tiles[i] > tiles[j]) {
          inversions++;
        }
      }
    }
    
    // Tek boyutlu ızgaralar için, çözülebilir olması için inversiyon sayısı çift olmalı
    if (size % 2 == 1) {
      return inversions % 2 == 0;
    }
    
    // Çift boyutlu ızgaralar için:
    // - boş kare alttan çift sıradaysa ve inversiyon sayısı tekse çözülebilir
    // - boş kare alttan tek sıradaysa ve inversiyon sayısı çiftse çözülebilir
    final blankRow = tiles.indexOf(0) ~/ size;
    final rowFromBottom = size - blankRow;
    return (rowFromBottom % 2 == 0) == (inversions % 2 == 1);
  }

  static List<List<int>> _convertTo2D(List<int> tiles, int size) {
    final result = List.generate(size, (_) => List<int>.filled(size, 0));
    for (int i = 0; i < tiles.length; i++) {
      final row = i ~/ size;
      final col = i % size;
      result[row][col] = tiles[i];
    }
    return result;
  }

  static bool isPuzzleSolved(List<List<int>> puzzle) {
    final size = puzzle.length;
    int expectedValue = 1;
    
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        // Son kare boş olmalı (0)
        if (i == size - 1 && j == size - 1) {
          if (puzzle[i][j] != 0) return false;
        }
        // Diğer kareler sıralı olmalı
        else if (puzzle[i][j] != expectedValue) {
          return false;
        }
        expectedValue++;
      }
    }
    
    return true;
  }

  static List<List<int>> getGoalState(int size) {
    final result = List.generate(size, (_) => List<int>.filled(size, 0));
    int value = 1;
    
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        if (i == size - 1 && j == size - 1) {
          result[i][j] = 0;
        } else {
          result[i][j] = value++;
        }
      }
    }
    
    return result;
  }

  static int getManhattanDistance(List<List<int>> puzzle) {
    final size = puzzle.length;
    int distance = 0;
    
    for (int i = 0; i < size; i++) {
      for (int j = 0; j < size; j++) {
        final value = puzzle[i][j];
        if (value != 0) {
          final targetRow = (value - 1) ~/ size;
          final targetCol = (value - 1) % size;
          distance += (i - targetRow).abs() + (j - targetCol).abs();
        }
      }
    }
    
    return distance;
  }
} 