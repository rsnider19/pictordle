part of 'game_cubit.dart';

enum GameStatus { initial, loading, success, failure }

@immutable
class GameState extends Equatable {
  GameState({
    this.status = GameStatus.initial,
    this.keyboardKeys = const [],
  });

  final GameStatus status;
  final List<KeyboardKey> keyboardKeys;

  @override
  List<Object> get props => [
        status,
        keyboardKeys,
      ];

  GameState copyWith({
    GameStatus? status,
    List<KeyboardKey>? keyboardKeys,
  }) {
    return GameState(
      status: status ?? this.status,
      keyboardKeys: keyboardKeys ?? this.keyboardKeys,
    );
  }
}
