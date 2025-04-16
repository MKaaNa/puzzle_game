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
  GameStatus get status => throw _privateConstructorUsedError;
  List<List<int>> get puzzle => throw _privateConstructorUsedError;
  int get moves => throw _privateConstructorUsedError;
  int get score => throw _privateConstructorUsedError;
  int get time => throw _privateConstructorUsedError;
  List<bool> get correctPositions => throw _privateConstructorUsedError;
  GameDifficulty get difficulty => throw _privateConstructorUsedError;
  GameMode get mode => throw _privateConstructorUsedError;
  bool get canUndo => throw _privateConstructorUsedError;
  bool get isGameOver => throw _privateConstructorUsedError;

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
      {GameStatus status,
      List<List<int>> puzzle,
      int moves,
      int score,
      int time,
      List<bool> correctPositions,
      GameDifficulty difficulty,
      GameMode mode,
      bool canUndo,
      bool isGameOver});
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
    Object? status = null,
    Object? puzzle = null,
    Object? moves = null,
    Object? score = null,
    Object? time = null,
    Object? correctPositions = null,
    Object? difficulty = null,
    Object? mode = null,
    Object? canUndo = null,
    Object? isGameOver = null,
  }) {
    return _then(_value.copyWith(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      puzzle: null == puzzle
          ? _value.puzzle
          : puzzle // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
      moves: null == moves
          ? _value.moves
          : moves // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      correctPositions: null == correctPositions
          ? _value.correctPositions
          : correctPositions // ignore: cast_nullable_to_non_nullable
              as List<bool>,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as GameDifficulty,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as GameMode,
      canUndo: null == canUndo
          ? _value.canUndo
          : canUndo // ignore: cast_nullable_to_non_nullable
              as bool,
      isGameOver: null == isGameOver
          ? _value.isGameOver
          : isGameOver // ignore: cast_nullable_to_non_nullable
              as bool,
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
      {GameStatus status,
      List<List<int>> puzzle,
      int moves,
      int score,
      int time,
      List<bool> correctPositions,
      GameDifficulty difficulty,
      GameMode mode,
      bool canUndo,
      bool isGameOver});
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
    Object? status = null,
    Object? puzzle = null,
    Object? moves = null,
    Object? score = null,
    Object? time = null,
    Object? correctPositions = null,
    Object? difficulty = null,
    Object? mode = null,
    Object? canUndo = null,
    Object? isGameOver = null,
  }) {
    return _then(_$GameStateImpl(
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as GameStatus,
      puzzle: null == puzzle
          ? _value._puzzle
          : puzzle // ignore: cast_nullable_to_non_nullable
              as List<List<int>>,
      moves: null == moves
          ? _value.moves
          : moves // ignore: cast_nullable_to_non_nullable
              as int,
      score: null == score
          ? _value.score
          : score // ignore: cast_nullable_to_non_nullable
              as int,
      time: null == time
          ? _value.time
          : time // ignore: cast_nullable_to_non_nullable
              as int,
      correctPositions: null == correctPositions
          ? _value._correctPositions
          : correctPositions // ignore: cast_nullable_to_non_nullable
              as List<bool>,
      difficulty: null == difficulty
          ? _value.difficulty
          : difficulty // ignore: cast_nullable_to_non_nullable
              as GameDifficulty,
      mode: null == mode
          ? _value.mode
          : mode // ignore: cast_nullable_to_non_nullable
              as GameMode,
      canUndo: null == canUndo
          ? _value.canUndo
          : canUndo // ignore: cast_nullable_to_non_nullable
              as bool,
      isGameOver: null == isGameOver
          ? _value.isGameOver
          : isGameOver // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$GameStateImpl implements _GameState {
  const _$GameStateImpl(
      {this.status = GameStatus.initial,
      final List<List<int>> puzzle = const [],
      this.moves = 0,
      this.score = 0,
      this.time = 0,
      final List<bool> correctPositions = const [],
      this.difficulty = GameDifficulty.medium,
      this.mode = GameMode.classic,
      this.canUndo = false,
      this.isGameOver = false})
      : _puzzle = puzzle,
        _correctPositions = correctPositions;

  factory _$GameStateImpl.fromJson(Map<String, dynamic> json) =>
      _$$GameStateImplFromJson(json);

  @override
  @JsonKey()
  final GameStatus status;
  final List<List<int>> _puzzle;
  @override
  @JsonKey()
  List<List<int>> get puzzle {
    if (_puzzle is EqualUnmodifiableListView) return _puzzle;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_puzzle);
  }

  @override
  @JsonKey()
  final int moves;
  @override
  @JsonKey()
  final int score;
  @override
  @JsonKey()
  final int time;
  final List<bool> _correctPositions;
  @override
  @JsonKey()
  List<bool> get correctPositions {
    if (_correctPositions is EqualUnmodifiableListView)
      return _correctPositions;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_correctPositions);
  }

  @override
  @JsonKey()
  final GameDifficulty difficulty;
  @override
  @JsonKey()
  final GameMode mode;
  @override
  @JsonKey()
  final bool canUndo;
  @override
  @JsonKey()
  final bool isGameOver;

  @override
  String toString() {
    return 'GameState(status: $status, puzzle: $puzzle, moves: $moves, score: $score, time: $time, correctPositions: $correctPositions, difficulty: $difficulty, mode: $mode, canUndo: $canUndo, isGameOver: $isGameOver)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$GameStateImpl &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other._puzzle, _puzzle) &&
            (identical(other.moves, moves) || other.moves == moves) &&
            (identical(other.score, score) || other.score == score) &&
            (identical(other.time, time) || other.time == time) &&
            const DeepCollectionEquality()
                .equals(other._correctPositions, _correctPositions) &&
            (identical(other.difficulty, difficulty) ||
                other.difficulty == difficulty) &&
            (identical(other.mode, mode) || other.mode == mode) &&
            (identical(other.canUndo, canUndo) || other.canUndo == canUndo) &&
            (identical(other.isGameOver, isGameOver) ||
                other.isGameOver == isGameOver));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      status,
      const DeepCollectionEquality().hash(_puzzle),
      moves,
      score,
      time,
      const DeepCollectionEquality().hash(_correctPositions),
      difficulty,
      mode,
      canUndo,
      isGameOver);

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
      {final GameStatus status,
      final List<List<int>> puzzle,
      final int moves,
      final int score,
      final int time,
      final List<bool> correctPositions,
      final GameDifficulty difficulty,
      final GameMode mode,
      final bool canUndo,
      final bool isGameOver}) = _$GameStateImpl;

  factory _GameState.fromJson(Map<String, dynamic> json) =
      _$GameStateImpl.fromJson;

  @override
  GameStatus get status;
  @override
  List<List<int>> get puzzle;
  @override
  int get moves;
  @override
  int get score;
  @override
  int get time;
  @override
  List<bool> get correctPositions;
  @override
  GameDifficulty get difficulty;
  @override
  GameMode get mode;
  @override
  bool get canUndo;
  @override
  bool get isGameOver;

  /// Create a copy of GameState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$GameStateImplCopyWith<_$GameStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
