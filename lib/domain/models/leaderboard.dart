import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../features/game/models/game_state.dart';
import 'player_score.dart';

class Leaderboard {
  static const int maxScores = 10;
  final Map<GameDifficulty, List<PlayerScore>> scores;

  Leaderboard({
    required this.scores,
  });

  factory Leaderboard.empty() {
    return Leaderboard(
      scores: {
        GameDifficulty.easy: [],
        GameDifficulty.medium: [],
        GameDifficulty.hard: [],
        GameDifficulty.expert: [],
      },
    );
  }

  // Calculate score based on moves, time and difficulty
  static int calculateScore(int moves, int timeInSeconds, GameDifficulty difficulty) {
    // Base score depends on difficulty
    final baseScore = switch (difficulty) {
      GameDifficulty.easy => 1000,
      GameDifficulty.medium => 2000,
      GameDifficulty.hard => 3000,
      GameDifficulty.expert => 4000,
    };
    
    // Penalty for moves and time
    final movesPenalty = moves * 10;
    final timePenalty = timeInSeconds * 2;
    
    // Calculate final score (higher is better)
    final score = baseScore - movesPenalty - timePenalty;
    
    // Make sure score doesn't go below zero
    return score > 0 ? score : 0;
  }

  // Add a new score to the leaderboard
  void addScore(PlayerScore score, GameDifficulty difficulty) {
    if (!scores.containsKey(difficulty)) {
      scores[difficulty] = [];
    }
    
    scores[difficulty]!.add(score);
    
    // Sort scores (higher is better) and keep only the top N
    scores[difficulty]!.sort((a, b) => b.score.compareTo(a.score));
    
    if (scores[difficulty]!.length > maxScores) {
      scores[difficulty] = scores[difficulty]!.sublist(0, maxScores);
    }
  }

  // Check if a score would be on the leaderboard
  bool isLeaderboardScore(int score, GameDifficulty difficulty) {
    if (!scores.containsKey(difficulty) || scores[difficulty]!.isEmpty) {
      return true;
    }
    
    if (scores[difficulty]!.length < maxScores) {
      return true;
    }
    
    // Check if this score is better than the lowest score
    final lowestScore = scores[difficulty]!.last.score;
    return score > lowestScore;
  }

  // Save leaderboard to SharedPreferences
  Future<void> save() async {
    final prefs = await SharedPreferences.getInstance();
    
    for (final difficulty in GameDifficulty.values) {
      final key = 'leaderboard_${difficulty.name}';
      final jsonList = scores[difficulty]?.map((score) => score.toJson()).toList() ?? [];
      final jsonString = jsonEncode(jsonList);
      await prefs.setString(key, jsonString);
    }
  }

  // Load leaderboard from SharedPreferences
  static Future<Leaderboard> load() async {
    final prefs = await SharedPreferences.getInstance();
    final leaderboard = Leaderboard.empty();
    
    for (final difficulty in GameDifficulty.values) {
      final key = 'leaderboard_${difficulty.name}';
      final jsonString = prefs.getString(key);
      
      if (jsonString != null) {
        try {
          final jsonList = jsonDecode(jsonString) as List;
          final scoresList = jsonList
              .map((json) => PlayerScore.fromJson(json as Map<String, dynamic>))
              .toList();
          leaderboard.scores[difficulty] = scoresList;
        } catch (e) {
          print('Error loading leaderboard: $e');
        }
      }
    }
    
    return leaderboard;
  }
}

