import 'package:freezed_annotation/freezed_annotation.dart';

part 'lesson_model.freezed.dart';
part 'lesson_model.g.dart';

enum LessonType {
  tutorial,
  strategy,
  practice,
  challenge,
}

enum LessonDifficulty {
  beginner,
  intermediate,
  advanced,
}

@freezed
class Lesson with _$Lesson {
  const factory Lesson({
    required String id,
    required String title,
    required String description,
    required LessonType type,
    required LessonDifficulty difficulty,
    required List<String> steps,
    required List<String> tips,
    required bool isPremium,
    required int duration,
    required String? videoUrl,
    required List<String>? practicePuzzles,
    required Map<String, dynamic>? metadata,
  }) = _Lesson;

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);

  factory Lesson.basicTutorial() {
    return Lesson(
      id: 'basic_tutorial',
      title: 'Getting Started',
      description: 'Learn the basics of sliding puzzles',
      type: LessonType.tutorial,
      difficulty: LessonDifficulty.beginner,
      steps: [
        'Understand the goal: Arrange numbers in order',
        'Learn how to move tiles',
        'Practice basic moves',
        'Complete your first puzzle',
      ],
      tips: [
        'Start with the first row',
        'Work from top to bottom',
        'Keep the empty space in mind',
      ],
      isPremium: false,
      duration: 10,
      videoUrl: null,
      practicePuzzles: null,
      metadata: null,
    );
  }

  factory Lesson.advancedStrategy() {
    return Lesson(
      id: 'advanced_strategy',
      title: 'Advanced Strategies',
      description: 'Master advanced solving techniques',
      type: LessonType.strategy,
      difficulty: LessonDifficulty.advanced,
      steps: [
        'Learn pattern recognition',
        'Master corner techniques',
        'Understand parity',
        'Practice speed solving',
      ],
      tips: [
        'Look for patterns in the puzzle',
        'Plan multiple moves ahead',
        'Use the empty space strategically',
      ],
      isPremium: true,
      duration: 20,
      videoUrl: null,
      practicePuzzles: null,
      metadata: null,
    );
  }
}

extension LessonTypeExtension on LessonType {
  String get label {
    switch (this) {
      case LessonType.tutorial:
        return 'Tutorial';
      case LessonType.strategy:
        return 'Strategy';
      case LessonType.practice:
        return 'Practice';
      case LessonType.challenge:
        return 'Challenge';
    }
  }

  String get icon {
    switch (this) {
      case LessonType.tutorial:
        return '🎓';
      case LessonType.strategy:
        return '🧠';
      case LessonType.practice:
        return '🎯';
      case LessonType.challenge:
        return '🏆';
    }
  }
}

extension LessonDifficultyExtension on LessonDifficulty {
  String get label {
    switch (this) {
      case LessonDifficulty.beginner:
        return 'Beginner';
      case LessonDifficulty.intermediate:
        return 'Intermediate';
      case LessonDifficulty.advanced:
        return 'Advanced';
    }
  }

  String get color {
    switch (this) {
      case LessonDifficulty.beginner:
        return 'green';
      case LessonDifficulty.intermediate:
        return 'blue';
      case LessonDifficulty.advanced:
        return 'red';
    }
  }
} 