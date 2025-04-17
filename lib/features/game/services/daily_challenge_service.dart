import 'dart:convert';
import 'package:shared_preferences.dart';
import '../models/game_difficulty.dart';
import 'puzzle_generator.dart';

class DailyChallengeService {
  final SharedPreferences _prefs;
  static const String _dailyPuzzleKey = 'daily_puzzle';
  static const String _dailyScoreKey = 'daily_scores';
  static const String _lastPlayedDateKey = 'last_played_date';

  DailyChallengeService(this._prefs);

  Future<List<List<int>>> getDailyPuzzle() async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final lastPlayedDate = _prefs.getString(_lastPlayedDateKey);

    // Eğer bugün için zaten bir bulmaca oluşturulmuşsa, onu kullan
    if (lastPlayedDate == today) {
      final savedPuzzle = _prefs.getString(_dailyPuzzleKey);
      if (savedPuzzle != null) {
        final List<dynamic> decoded = json.decode(savedPuzzle);
        return decoded.map((row) => List<int>.from(row)).toList();
      }
    }

    // Yeni günlük bulmaca oluştur
    final puzzle = PuzzleGenerator.generatePuzzle(GameDifficulty.medium);
    
    // Bulmacayı kaydet
    await _prefs.setString(_dailyPuzzleKey, json.encode(puzzle));
    await _prefs.setString(_lastPlayedDateKey, today);
    
    return puzzle;
  }

  Future<void> saveDailyScore(int score) async {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final scores = getDailyScores();
    
    scores[today] = score;
    await _prefs.setString(_dailyScoreKey, json.encode(scores));
  }

  Map<String, int> getDailyScores() {
    final scoresJson = _prefs.getString(_dailyScoreKey);
    if (scoresJson == null) return {};
    
    final Map<String, dynamic> decoded = json.decode(scoresJson);
    return decoded.map((key, value) => MapEntry(key, value as int));
  }

  int? getTodayScore() {
    final today = DateTime.now().toIso8601String().split('T')[0];
    return getDailyScores()[today];
  }

  bool hasPlayedToday() {
    final today = DateTime.now().toIso8601String().split('T')[0];
    final lastPlayedDate = _prefs.getString(_lastPlayedDateKey);
    return lastPlayedDate == today;
  }

  int getCurrentStreak() {
    final scores = getDailyScores();
    if (scores.isEmpty) return 0;

    final today = DateTime.now();
    var currentDate = today;
    var streak = 0;

    while (true) {
      final dateStr = currentDate.toIso8601String().split('T')[0];
      if (!scores.containsKey(dateStr)) break;
      
      streak++;
      currentDate = currentDate.subtract(const Duration(days: 1));
    }

    return streak;
  }

  int getBestStreak() {
    final scores = getDailyScores();
    if (scores.isEmpty) return 0;

    final dates = scores.keys.map((dateStr) => DateTime.parse(dateStr)).toList()
      ..sort();

    var currentStreak = 1;
    var bestStreak = 1;
    
    for (var i = 1; i < dates.length; i++) {
      final difference = dates[i].difference(dates[i - 1]).inDays;
      
      if (difference == 1) {
        currentStreak++;
        if (currentStreak > bestStreak) {
          bestStreak = currentStreak;
        }
      } else {
        currentStreak = 1;
      }
    }

    return bestStreak;
  }
} 