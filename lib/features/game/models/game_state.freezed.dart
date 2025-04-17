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
  List<int> get tiles => throw _privateConstructorUsedError;
  int get emptyTileIndex => throw _privateConstructorUsedError;
  bool get isComplete => throw _privateConstructorUsedError;
  int get moveCount => throw _privateConstructorUsedError;
  Duration get elapsedTime => throw _privateConstructorUsedError;
  bool get isActive => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  GameDifficulty get difficulty => throw _privateConstructorUsedError;
  GameMode get mode => throw _privateConstructorUsedError;
  GameStatus get status => throw _privateConstructorUsedError;
  bool get isShowingHint => throw _privateConstructorUsedError;
  int? get hintTileIndex => throw _privateConstructorUsedError;
  int get bestScore => throw _privateConstructorUsedError;
  Duration get bestTime => throw _privateConstructorUsedError;
  int get gamesWon => throw _privateConstructorUsedError;
  int get gamesPlayed => throw _privateConstructorUsedError;
  int get currentStreak => throw _privateConstructorUsedError;
  int get bestStreak => throw _privateConstructorUsedError;
  int get hintsRemaining => throw _privateConstructorUsedError;
  List<List<bool>> get correctPositions => throw _privateConstructorUsedError;
  List<List<int>> get previousMoves => throw _privateConstructorUsedError;

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
      {List<int> tiles,
      int emptyTileIndex,
      bool isComplete,
      int moveCount,
      Duration elapsedTime,
      bool isActive,
      int score,
      GameDifficulty difficulty,
      GameMode mode,
      GameStatus status,
      bool isShowingHint,
      int? hintTileIndex,
      int bestScore,
      Duration bestTime,
      int gamesWon,
      int gamesPlayed,
      int currentStreak,
      int bestStreak,
      int hintsRemaining,
      List<List<bool>> correctPositions,
      List<List<int>> previousMoves});
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
    Object? tiles = null,
    Object? emptyTileIndex = null,
    Object? isComplete = null,
    Object? moveCount = null,
    Object? elapsedTime = null,
    Object? isActive = null,
    Object? score = null,
    Object? difficulty = null,
    Object? mode = null,
    Object? status = null,
    Object? isShowingHint = null,
    Object? hintTileIndex = freezed,
    Object? bestScore = null,
    Object? bestTime = null,
    Object? gamesWon = null,
    Object? gamesPlayed = null,
    Object? currentStreak = null,
    Object? bestStreak = null,
    Object? hintsRemaining = null,
    Object? correctPositions = null,
    Object? previousMoves = null,
  }) {
    return _then(_value.copyWith(
      tiles: null == tiles
          ? _value.tiles
          : tiles // ignore: cast_nullable_to_non_nullable
              as List<int>,
      emptyTileIndex: null == emptyTileIndex
          ? _value.emptyTileIndex
          : emptyTileIndex // ignore: cast_nullable_to_non_nullable
              as int,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      moveCount: null == moveCount
          ? _value.moveCount
          : moveCount // ignore: cast_nullable_to_non_nullable
              as int,
      elapsedTime: null == elapsedTime
          ? _value.elapsedTime
          : elapsedTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as GameDifficulty,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as GameMode,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      isShowingHint: null == isShowingHint
          ? _value.isShowingHint
          : isShowingHint // ignore: cast_nullable_to_non_nullable
              as bool,
      hintTileIndex: freezed == hintTileIndex
          ? _value.hintTileIndex
          : hintTileIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      bestScore: null == bestScore
          ? _value.bestScore
          : bestScore // ignore: cast_nullable_to_non_nullable
              as int,
      bestTime: null == bestTime
          ? _value.bestTime
          : bestTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      gamesWon: null == gamesWon
          ? _value.gamesWon
          : gamesWon // ignore: cast_nullable_to_non_nullable
              as int,
      gamesPlayed: null == gamesPlayed
          ? _value.gamesPlayed
          : gamesPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      bestStreak: null == bestStreak
          ? _value.bestStreak
          : bestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      hintsRemaining: null == hintsRemaining
          ? _value.hintsRemaining
          : hintsRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      correctPositions: null == correctPositions
          ? _value.correctPositions
          : correctPositions // ignore: cast_nullable_to_non_nullable
              as List<List<bool>>,
      previousMoves: null == previousMoves
          ? _value.previousMoves
          : previousMoves // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
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
      {List<int> tiles,
      int emptyTileIndex,
      bool isComplete,
      int moveCount,
      Duration elapsedTime,
      bool isActive,
      int score,
      GameDifficulty difficulty,
      GameMode mode,
      GameStatus status,
      bool isShowingHint,
      int? hintTileIndex,
      int bestScore,
      Duration bestTime,
      int gamesWon,
      int gamesPlayed,
      int currentStreak,
      int bestStreak,
      int hintsRemaining,
      List<List<bool>> correctPositions,
      List<List<int>> previousMoves});
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
    Object? tiles = null,
    Object? emptyTileIndex = null,
    Object? isComplete = null,
    Object? moveCount = null,
    Object? elapsedTime = null,
    Object? isActive = null,
    Object? score = null,
    Object? difficulty = null,
    Object? mode = null,
    Object? status = null,
    Object? isShowingHint = null,
    Object? hintTileIndex = freezed,
    Object? bestScore = null,
    Object? bestTime = null,
    Object? gamesWon = null,
    Object? gamesPlayed = null,
    Object? currentStreak = null,
    Object? bestStreak = null,
    Object? hintsRemaining = null,
    Object? correctPositions = null,
    Object? previousMoves = null,
  }) {
    return _then(_$GameStateImpl(
      tiles: null == tiles
          ? _value._tiles
          : tiles // ignore: cast_nullable_to_non_nullable
              as List<int>,
      emptyTileIndex: null == emptyTileIndex
          ? _value.emptyTileIndex
          : emptyTileIndex // ignore: cast_nullable_to_non_nullable
              as int,
      isComplete: null == isComplete
          ? _value.isComplete
          : isComplete // ignore: cast_nullable_to_non_nullable
              as bool,
      moveCount: null == moveCount
          ? _value.moveCount
          : moveCount // ignore: cast_nullable_to_non_nullable
              as int,
      elapsedTime: null == elapsedTime
          ? _value.elapsedTime
          : elapsedTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      isActive: null == isActive
          ? _value.isActive
          : isActive // ignore: cast_nullable_to_non_nullable
              as bool,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as GameDifficulty,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as GameMode,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      isShowingHint: null == isShowingHint
          ? _value.isShowingHint
          : isShowingHint // ignore: cast_nullable_to_non_nullable
              as bool,
      hintTileIndex: freezed == hintTileIndex
          ? _value.hintTileIndex
          : hintTileIndex // ignore: cast_nullable_to_non_nullable
              as int?,
      bestScore: null == bestScore
          ? _value.bestScore
          : bestScore // ignore: cast_nullable_to_non_nullable
              as int,
      bestTime: null == bestTime
          ? _value.bestTime
          : bestTime // ignore: cast_nullable_to_non_nullable
              as Duration,
      gamesWon: null == gamesWon
          ? _value.gamesWon
          : gamesWon // ignore: cast_nullable_to_non_nullable
              as int,
      gamesPlayed: null == gamesPlayed
          ? _value.gamesPlayed
          : gamesPlayed // ignore: cast_nullable_to_non_nullable
              as int,
      currentStreak: null == currentStreak
          ? _value.currentStreak
          : currentStreak // ignore: cast_nullable_to_non_nullable
              as int,
      bestStreak: null == bestStreak
          ? _value.bestStreak
          : bestStreak // ignore: cast_nullable_to_non_nullable
              as int,
      hintsRemaining: null == hintsRemaining
          ? _value.hintsRemaining
          : hintsRemaining // ignore: cast_nullable_to_non_nullable
              as int,
      correctPositions: null == correctPositions
          ? _value._correctPositions
          : correctPositions // ignore: cast_nullable_to_non_nullable
              as List<List<bool>>,
      previousMoves: null == previousMoves
          ? _value._previousMoves
          : previousMoves // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameStateImpl extends _GameState with DiagnosticableTreeMixin {
  const _$GameStateImpl(
      {required final List<int> tiles,
      required this.emptyTileIndex,
      required this.isComplete,
      required this.moveCount,
      required this.elapsedTime,
      required this.isActive,
      required this.score,
      required this.difficulty,
      required this.mode,
      required this.status,
      this.isShowingHint = false,
      this.hintTileIndex,
      this.bestScore = 0,
      this.bestTime = Duration.zero,
      this.gamesWon = 0,
      this.gamesPlayed = 0,
      this.currentStreak = 0,
      this.bestStreak = 0,
      this.hintsRemaining = 3,
      final List<List<bool>> correctPositions = const [],
      final List<List<int>> previousMoves = const []})
      : _tiles = tiles,
        _correctPositions = correctPositions,
        _previousMoves = previousMoves,
        super._();

  factory _$GameStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameStateImplFromJson(json);

  final List<int> _tiles;
  @override
  List<int> get tiles {
    if (_tiles is EqualUnmodifiableListView) return _tiles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tiles);
  }

  @override
  final int emptyTileIndex;
  @override
  final bool isComplete;
  @override
  final int moveCount;
  @override
  final Duration elapsedTime;
  @override
  final bool isActive;
  @override
  final int score;
  @override
  final GameDifficulty difficulty;
  @override
  final GameMode mode;
  @override
  final GameStatus status;
  @override
  @JsonKey()
  final bool isShowingHint;
  @override
  final int? hintTileIndex;
  @override
  @JsonKey()
  final int bestScore;
  @override
  @JsonKey()
  final Duration bestTime;
  @override
  @JsonKey()
  final int gamesWon;
  @override
  @JsonKey()
  final int gamesPlayed;
  @override
  @JsonKey()
  final int currentStreak;
  @override
  @JsonKey()
  final int bestStreak;
  @override
  @JsonKey()
  final int hintsRemaining;
  final List<List<bool>> _correctPositions;
  @override
  @JsonKey()
  List<List<bool>> get correctPositions {
    if (_correctPositions is EqualUnmodifiableListView)
      return _correctPositions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_correctPositions);
  }

  final List<List<int>> _previousMoves;
  @override
  @JsonKey()
  List<List<int>> get previousMoves {
    if (_previousMoves is EqualUnmodifiableListView) return _previousMoves;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_previousMoves);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'GameState(tiles: $tiles, emptyTileIndex: $emptyTileIndex, isComplete: $isComplete, moveCount: $moveCount, elapsedTime: $elapsedTime, isActive: $isActive, score: $score, difficulty: $difficulty, mode: $mode, status: $status, isShowingHint: $isShowingHint, hintTileIndex: $hintTileIndex, bestScore: $bestScore, bestTime: $bestTime, gamesWon: $gamesWon, gamesPlayed: $gamesPlayed, currentStreak: $currentStreak, bestStreak: $bestStreak, hintsRemaining: $hintsRemaining, correctPositions: $correctPositions, previousMoves: $previousMoves)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'GameState'))
      ..add(DiagnosticsProperty('tiles', tiles))
      ..add(DiagnosticsProperty('emptyTileIndex', emptyTileIndex))
      ..add(DiagnosticsProperty('isComplete', isComplete))
      ..add(DiagnosticsProperty('moveCount', moveCount))
      ..add(DiagnosticsProperty('elapsedTime', elapsedTime))
      ..add(DiagnosticsProperty('isActive', isActive))
      ..add(DiagnosticsProperty('score', score))
      ..add(DiagnosticsProperty('difficulty', difficulty))
      ..add(DiagnosticsProperty('mode', mode))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('isShowingHint', isShowingHint))
      ..add(DiagnosticsProperty('hintTileIndex', hintTileIndex))
      ..add(DiagnosticsProperty('bestScore', bestScore))
      ..add(DiagnosticsProperty('bestTime', bestTime))
      ..add(DiagnosticsProperty('gamesWon', gamesWon))
      ..add(DiagnosticsProperty('gamesPlayed', gamesPlayed))
      ..add(DiagnosticsProperty('currentStreak', currentStreak))
      ..add(DiagnosticsProperty('bestStreak', bestStreak))
      ..add(DiagnosticsProperty('hintsRemaining', hintsRemaining))
      ..add(DiagnosticsProperty('correctPositions', correctPositions))
      ..add(DiagnosticsProperty('previousMoves', previousMoves));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
            const DeepCollectionEquality().equals(other._tiles, _tiles) &&
            (identical(other.emptyTileIndex, emptyTileIndex) ||
                other.emptyTileIndex == emptyTileIndex) &&
            (identical(other.isComplete, isComplete) ||
                other.isComplete == isComplete) &&
            (identical(other.moveCount, moveCount) ||
                other.moveCount == moveCount) &&
            (identical(other.elapsedTime, elapsedTime) ||
                other.elapsedTime == elapsedTime) &&
            (identical(other.isActive, isActive) ||
                other.isActive == isActive) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.isShowingHint, isShowingHint) ||
                other.isShowingHint == isShowingHint) &&
            (identical(other.hintTileIndex, hintTileIndex) ||
                other.hintTileIndex == hintTileIndex) &&
            (identical(other.bestScore, bestScore) ||
                other.bestScore == bestScore) &&
            (identical(other.bestTime, bestTime) ||
                other.bestTime == bestTime) &&
            (identical(other.gamesWon, gamesWon) ||
                other.gamesWon == gamesWon) &&
            (identical(other.gamesPlayed, gamesPlayed) ||
                other.gamesPlayed == gamesPlayed) &&
            (identical(other.currentStreak, currentStreak) ||
                other.currentStreak == currentStreak) &&
            (identical(other.bestStreak, bestStreak) ||
                other.bestStreak == bestStreak) &&
            (identical(other.hintsRemaining, hintsRemaining) ||
                other.hintsRemaining == hintsRemaining) &&
            const DeepCollectionEquality()
                .equals(other._correctPositions, _correctPositions) &&
            const DeepCollectionEquality()
                .equals(other._previousMoves, _previousMoves));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        const DeepCollectionEquality().hash(_tiles),
        emptyTileIndex,
        isComplete,
        moveCount,
        elapsedTime,
        isActive,
        score,
        difficulty,
        mode,
        status,
        isShowingHint,
        hintTileIndex,
        bestScore,
        bestTime,
        gamesWon,
        gamesPlayed,
        currentStreak,
        bestStreak,
        hintsRemaining,
        const DeepCollectionEquality().hash(_correctPositions),
        const DeepCollectionEquality().hash(_previousMoves)
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

abstract class _GameState extends GameState {
  const factory _GameState(
      {required final List<int> tiles,
      required final int emptyTileIndex,
      required final bool isComplete,
      required final int moveCount,
      required final Duration elapsedTime,
      required final bool isActive,
      required final int score,
      required final GameDifficulty difficulty,
      required final GameMode mode,
      required final GameStatus status,
      final bool isShowingHint,
      final int? hintTileIndex,
      final int bestScore,
      final Duration bestTime,
      final int gamesWon,
      final int gamesPlayed,
      final int currentStreak,
      final int bestStreak,
      final int hintsRemaining,
      final List<List<bool>> correctPositions,
      final List<List<int>> previousMoves}) = _$GameStateImpl;
  const _GameState._() : super._();

  factory _GameState.fromJson(Map<String, dynamic> json) =
      _$GameStateImpl.fromJson;

  @override
  List<int> get tiles;
  @override
  int get emptyTileIndex;
  @override
  bool get isComplete;
  @override
  int get moveCount;
  @override
  Duration get elapsedTime;
  @override
  bool get isActive;
  @override
  int get score;
  @override
  GameDifficulty get difficulty;
  @override
  GameMode get mode;
  @override
  GameStatus get status;
  @override
  bool get isShowingHint;
  @override
  int? get hintTileIndex;
  @override
  int get bestScore;
  @override
  Duration get bestTime;
  @override
  int get gamesWon;
  @override
  int get gamesPlayed;
  @override
  int get currentStreak;
  @override
  int get bestStreak;
  @override
  int get hintsRemaining;
  @override
  List<List<bool>> get correctPositions;
  @override
  List<List<int>> get previousMoves;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
