// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'game_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

GameState _$GameStateFromJson(Map<String, dynamic> json) {
  return _GameState.fromJson(json);
}

/// @nodoc
mixin _$GameState {
  String get id => throw _privateConstructorUsedError;
  List<List<int>> get puzzle => throw _privateConstructorUsedError;
  int get moves => throw _privateConstructorUsedError;
  int get timeElapsed => throw _privateConstructorUsedError;
  int get timeLimit => throw _privateConstructorUsedError;
  int get moveLimit => throw _privateConstructorUsedError;
  int get hintsRemaining => throw _privateConstructorUsedError;
  bool get isPaused => throw _privateConstructorUsedError;
  bool get isComplete => throw _privateConstructorUsedError;
  bool get hasWon => throw _privateConstructorUsedError;
  GameStatus get status => throw _privateConstructorUsedError;
  GameMode get mode => throw _privateConstructorUsedError;
  GameDifficulty get difficulty => throw _privateConstructorUsedError;
  List<bool> get correctPositions => throw _privateConstructorUsedError;
  List<List<int>> get previousMoves => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get bestScore => throw _privateConstructorUsedError;
  int get bestTime => throw _privateConstructorUsedError;
  int get gamesPlayed => throw _privateConstructorUsedError;
  int get gamesWon => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get bestStreak => throw _privateConstructorUsedError;

  /// Serializes this GameState to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $GameStateCopyWith<GameState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GameStateCopyWith<$Res> {
  factory $GameStateCopyWith(GameState value, $Res Function(GameState) then) =
      _$GameStateCopyWithImpl<$Res, GameState>;
  @useResult
  $Res call(
      {String id,
      List<List<int>> puzzle,
      int moves,
      int timeElapsed,
      int timeLimit,
      int moveLimit,
      int hintsRemaining,
      bool isPaused,
      bool isComplete,
      bool hasWon,
      GameStatus status,
      GameMode mode,
      GameDifficulty difficulty,
      List<bool> correctPositions,
      List<List<int>> previousMoves,
      int score,
      int bestScore,
      int bestTime,
      int gamesPlayed,
      int gamesWon,
      int currentStreak,
      int bestStreak});
}

/// @nodoc
class _$GameStateCopyWithImpl<$Res, $Val extends GameState>
    implements $GameStateCopyWith<$Res> {
  _$GameStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? puzzle = null,
    Object? moves = null,
    Object? timeElapsed = null,
    Object? timeLimit = null,
    Object? moveLimit = null,
    Object? hintsRemaining = null,
    Object? isPaused = null,
    Object? isComplete = null,
    Object? hasWon = null,
    Object? status = null,
    Object? mode = null,
    Object? difficulty = null,
    Object? correctPositions = null,
    Object? previousMoves = null,
    Object? score = null,
    Object? bestScore = null,
    Object? bestTime = null,
    Object? gamesPlayed = null,
    Object? gamesWon = null,
    Object? currentStreak = null,
    Object? bestStreak = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      puzzle: null == puzzle
          ? _value.puzzle
          : puzzle // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
      moves: null == moves
          ? _value.moves
          : moves // ignore: cast_nullable_to_non_nullable
              as int,
      timeElapsed: null == timeElapsed
          ? _value.timeElapsed
          : timeElapsed // ignore: cast_nullable_to_non_nullable
              as int,
      timeLimit: null == timeLimit
          ? _value.timeLimit
          : timeLimit // ignore: cast_nullable_to_non_nullable
              as int,
      moveLimit: null == moveLimit
          ? _value.moveLimit
          : moveLimit // ignore: cast_nullable_to_non_nullable
              as int,
      hintsRemaining: null == hintsRemaining
          ? _value.hintsRemaining
          : hintsRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      isPaused: null == isPaused
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      hasWon: null == hasWon
          ? _value.hasWon
          : hasWon // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as GameMode,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as GameDifficulty,
      correctPositions: null == correctPositions
          ? _value.correctPositions
          : correctPositions // ignore: cast_nullable_to_non_nullable
              as List<bool>,
      previousMoves: null == previousMoves
          ? _value.previousMoves
          : previousMoves // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      bestScore: null == bestScore
          ? _value.bestScore
          : bestScore // ignore: cast_nullable_to_non_nullable
              as int,
      bestTime: null == bestTime
          ? _value.bestTime
          : bestTime // ignore: cast_nullable_to_non_nullable
              as int,
      gamesPlayed: null == gamesPlayed
          ? _value.gamesPlayed
          : gamesPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      gamesWon: null == gamesWon
          ? _value.gamesWon
          : gamesWon // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      bestStreak: null == bestStreak
          ? _value.bestStreak
          : bestStreak // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$GameStateImplCopyWith<$Res>
    implements $GameStateCopyWith<$Res> {
  factory _$$GameStateImplCopyWith(
          _$GameStateImpl value, $Res Function(_$GameStateImpl) then) =
      __$$GameStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      List<List<int>> puzzle,
      int moves,
      int timeElapsed,
      int timeLimit,
      int moveLimit,
      int hintsRemaining,
      bool isPaused,
      bool isComplete,
      bool hasWon,
      GameStatus status,
      GameMode mode,
      GameDifficulty difficulty,
      List<bool> correctPositions,
      List<List<int>> previousMoves,
      int score,
      int bestScore,
      int bestTime,
      int gamesPlayed,
      int gamesWon,
      int currentStreak,
      int bestStreak});
}

/// @nodoc
class __$$GameStateImplCopyWithImpl<$Res>
    extends _$GameStateCopyWithImpl<$Res, _$GameStateImpl>
    implements _$$GameStateImplCopyWith<$Res> {
  __$$GameStateImplCopyWithImpl(
      _$GameStateImpl _value, $Res Function(_$GameStateImpl) _then)
      : super(_value, _then);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? puzzle = null,
    Object? moves = null,
    Object? timeElapsed = null,
    Object? timeLimit = null,
    Object? moveLimit = null,
    Object? hintsRemaining = null,
    Object? isPaused = null,
    Object? isComplete = null,
    Object? hasWon = null,
    Object? status = null,
    Object? mode = null,
    Object? difficulty = null,
    Object? correctPositions = null,
    Object? previousMoves = null,
    Object? score = null,
    Object? bestScore = null,
    Object? bestTime = null,
    Object? gamesPlayed = null,
    Object? gamesWon = null,
    Object? currentStreak = null,
    Object? bestStreak = null,
  }) {
    return _then(_$GameStateImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      puzzle: null == puzzle
          ? _value._puzzle
          : puzzle // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
      moves: null == moves
          ? _value.moves
          : moves // ignore: cast_nullable_to_non_nullable
              as int,
      timeElapsed: null == timeElapsed
          ? _value.timeElapsed
          : timeElapsed // ignore: cast_nullable_to_non_nullable
              as int,
      timeLimit: null == timeLimit
          ? _value.timeLimit
          : timeLimit // ignore: cast_nullable_to_non_nullable
              as int,
      moveLimit: null == moveLimit
          ? _value.moveLimit
          : moveLimit // ignore: cast_nullable_to_non_nullable
              as int,
      hintsRemaining: null == hintsRemaining
          ? _value.hintsRemaining
          : hintsRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      isPaused: null == isPaused
          ? _value.isPaused
          : isPaused // ignore: cast_nullable_to_non_nullable
              as bool,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      hasWon: null == hasWon
          ? _value.hasWon
          : hasWon // ignore: cast_nullable_to_non_nullable
              as bool,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as GameMode,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as GameDifficulty,
      correctPositions: null == correctPositions
          ? _value._correctPositions
          : correctPositions // ignore: cast_nullable_to_non_nullable
              as List<bool>,
      previousMoves: null == previousMoves
          ? _value._previousMoves
          : previousMoves // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      bestScore: null == bestScore
          ? _value.bestScore
          : bestScore // ignore: cast_nullable_to_non_nullable
              as int,
      bestTime: null == bestTime
          ? _value.bestTime
          : bestTime // ignore: cast_nullable_to_non_nullable
              as int,
      gamesPlayed: null == gamesPlayed
          ? _value.gamesPlayed
          : gamesPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      gamesWon: null == gamesWon
          ? _value.gamesWon
          : gamesWon // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      bestStreak: null == bestStreak
          ? _value.bestStreak
          : bestStreak // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameStateImpl with DiagnosticableTreeMixin implements _GameState {
  const _$GameStateImpl(
      {required this.id,
      required final List<List<int>> puzzle,
      required this.moves,
      required this.timeElapsed,
      required this.timeLimit,
      required this.moveLimit,
      required this.hintsRemaining,
      required this.isPaused,
      required this.isComplete,
      required this.hasWon,
      required this.status,
      required this.mode,
      required this.difficulty,
      required final List<bool> correctPositions,
      required final List<List<int>> previousMoves,
      this.score = 0,
      this.bestScore = 0,
      this.bestTime = 0,
      this.gamesPlayed = 0,
      this.gamesWon = 0,
      this.currentStreak = 0,
      this.bestStreak = 0})
      : _puzzle = puzzle,
        _correctPositions = correctPositions,
        _previousMoves = previousMoves;

  factory _$GameStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameStateImplFromJson(json);

  @override
  final String id;
  final List<List<int>> _puzzle;
  @override
  List<List<int>> get puzzle {
    if (_puzzle is EqualUnmodifiableListView) return _puzzle;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_puzzle);
  }

  @override
  final int moves;
  @override
  final int timeElapsed;
  @override
  final int timeLimit;
  @override
  final int moveLimit;
  @override
  final int hintsRemaining;
  @override
  final bool isPaused;
  @override
  final bool isComplete;
  @override
  final bool hasWon;
  @override
  final GameStatus status;
  @override
  final GameMode mode;
  @override
  final GameDifficulty difficulty;
  final List<bool> _correctPositions;
  @override
  List<bool> get correctPositions {
    if (_correctPositions is EqualUnmodifiableListView)
      return _correctPositions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_correctPositions);
  }

  final List<List<int>> _previousMoves;
  @override
  List<List<int>> get previousMoves {
    if (_previousMoves is EqualUnmodifiableListView) return _previousMoves;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_previousMoves);
  }

  @override
  @JsonKey()
  final int score;
  @override
  @JsonKey()
  final int bestScore;
  @override
  @JsonKey()
  final int bestTime;
  @override
  @JsonKey()
  final int gamesPlayed;
  @override
  @JsonKey()
  final int gamesWon;
  @override
  @JsonKey()
  final int currentStreak;
  @override
  @JsonKey()
  final int bestStreak;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GameState(id: $id, puzzle: $puzzle, moves: $moves, timeElapsed: $timeElapsed, timeLimit: $timeLimit, moveLimit: $moveLimit, hintsRemaining: $hintsRemaining, isPaused: $isPaused, isComplete: $isComplete, hasWon: $hasWon, status: $status, mode: $mode, difficulty: $difficulty, correctPositions: $correctPositions, previousMoves: $previousMoves, score: $score, bestScore: $bestScore, bestTime: $bestTime, gamesPlayed: $gamesPlayed, gamesWon: $gamesWon, currentStreak: $currentStreak, bestStreak: $bestStreak)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GameState'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('puzzle', puzzle))
      ..add(DiagnosticsProperty('moves', moves))
      ..add(DiagnosticsProperty('timeElapsed', timeElapsed))
      ..add(DiagnosticsProperty('timeLimit', timeLimit))
      ..add(DiagnosticsProperty('moveLimit', moveLimit))
      ..add(DiagnosticsProperty('hintsRemaining', hintsRemaining))
      ..add(DiagnosticsProperty('isPaused', isPaused))
      ..add(DiagnosticsProperty('isComplete', isComplete))
      ..add(DiagnosticsProperty('hasWon', hasWon))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('mode', mode))
      ..add(DiagnosticsProperty('difficulty', difficulty))
      ..add(DiagnosticsProperty('correctPositions', correctPositions))
      ..add(DiagnosticsProperty('previousMoves', previousMoves))
      ..add(DiagnosticsProperty('score', score))
      ..add(DiagnosticsProperty('bestScore', bestScore))
      ..add(DiagnosticsProperty('bestTime', bestTime))
      ..add(DiagnosticsProperty('gamesPlayed', gamesPlayed))
      ..add(DiagnosticsProperty('gamesWon', gamesWon))
      ..add(DiagnosticsProperty('currentStreak', currentStreak))
      ..add(DiagnosticsProperty('bestStreak', bestStreak));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
            (identical(other.id, id) || other.id == id) &&
            const DeepCollectionEquality().equals(other._puzzle, _puzzle) &&
            (identical(other.moves, moves) || other.moves == moves) &&
            (identical(other.timeElapsed, timeElapsed) ||
                other.timeElapsed == timeElapsed) &&
            (identical(other.timeLimit, timeLimit) ||
                other.timeLimit == timeLimit) &&
            (identical(other.moveLimit, moveLimit) ||
                other.moveLimit == moveLimit) &&
            (identical(other.hintsRemaining, hintsRemaining) ||
                other.hintsRemaining == hintsRemaining) &&
            (identical(other.isPaused, isPaused) ||
                other.isPaused == isPaused) &&
            (identical(other.isComplete, isComplete) ||
                other.isComplete == isComplete) &&
            (identical(other.hasWon, hasWon) || other.hasWon == hasWon) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            const DeepCollectionEquality()
                .equals(other._correctPositions, _correctPositions) &&
            const DeepCollectionEquality()
                .equals(other._previousMoves, _previousMoves) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.bestScore, bestScore) ||
                other.bestScore == bestScore) &&
            (identical(other.bestTime, bestTime) ||
                other.bestTime == bestTime) &&
            (identical(other.gamesPlayed, gamesPlayed) ||
                other.gamesPlayed == gamesPlayed) &&
            (identical(other.gamesWon, gamesWon) ||
                other.gamesWon == gamesWon) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.bestStreak, bestStreak) ||
                other.bestStreak == bestStreak));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        const DeepCollectionEquality().hash(_puzzle),
        moves,
        timeElapsed,
        timeLimit,
        moveLimit,
        hintsRemaining,
        isPaused,
        isComplete,
        hasWon,
        status,
        mode,
        difficulty,
        const DeepCollectionEquality().hash(_correctPositions),
        const DeepCollectionEquality().hash(_previousMoves),
        score,
        bestScore,
        bestTime,
        gamesPlayed,
        gamesWon,
        currentStreak,
        bestStreak
      ]);

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      __$$GameStateImplCopyWithImpl<_$GameStateImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$GameStateImplToJson(
      this,
    );
  }
}

abstract class _GameState implements GameState {
  const factory _GameState(
      {required final String id,
      required final List<List<int>> puzzle,
      required final int moves,
      required final int timeElapsed,
      required final int timeLimit,
      required final int moveLimit,
      required final int hintsRemaining,
      required final bool isPaused,
      required final bool isComplete,
      required final bool hasWon,
      required final GameStatus status,
      required final GameMode mode,
      required final GameDifficulty difficulty,
      required final List<bool> correctPositions,
      required final List<List<int>> previousMoves,
      final int score,
      final int bestScore,
      final int bestTime,
      final int gamesPlayed,
      final int gamesWon,
      final int currentStreak,
      final int bestStreak}) = _$GameStateImpl;

  factory _GameState.fromJson(Map<String, dynamic> json) =
      _$GameStateImpl.fromJson;

  @override
  String get id;
  @override
  List<List<int>> get puzzle;
  @override
  int get moves;
  @override
  int get timeElapsed;
  @override
  int get timeLimit;
  @override
  int get moveLimit;
  @override
  int get hintsRemaining;
  @override
  bool get isPaused;
  @override
  bool get isComplete;
  @override
  bool get hasWon;
  @override
  GameStatus get status;
  @override
  GameMode get mode;
  @override
  GameDifficulty get difficulty;
  @override
  List<bool> get correctPositions;
  @override
  List<List<int>> get previousMoves;
  @override
  int get score;
  @override
  int get bestScore;
  @override
  int get bestTime;
  @override
  int get gamesPlayed;
  @override
  int get gamesWon;
  @override
  int get currentStreak;
  @override
  int get bestStreak;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
