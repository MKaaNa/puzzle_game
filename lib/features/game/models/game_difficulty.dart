enum GameDifficulty {
  easy(
    size: 3,
    timeLimit: Duration(minutes: 5),
    moveLimit: 100,
    maxHints: 3,
    baseScore: 1000,
  ),
  medium(
    size: 4,
    timeLimit: Duration(minutes: 10),
    moveLimit: 200,
    maxHints: 2,
    baseScore: 2000,
  ),
  hard(
    size: 5,
    timeLimit: Duration(minutes: 15),
    moveLimit: 300,
    maxHints: 1,
    baseScore: 3000,
  );

  final int size;
  final Duration timeLimit;
  final int moveLimit;
  final int maxHints;
  final int baseScore;

  const GameDifficulty({
    required this.size,
    required this.timeLimit,
    required this.moveLimit,
    required this.maxHints,
    required this.baseScore,
  });
} 