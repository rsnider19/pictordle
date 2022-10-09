part of 'game_cubit.dart';

enum GameStatus { initial, loading, success, failure }

@immutable
class GameState extends Equatable {
  const GameState({
    this.status = GameStatus.initial,
    this.currentGame,
    this.keyboardKeys = const [],
  });

  final GameStatus status;
  final Game? currentGame;
  final List<KeyboardKey> keyboardKeys;

  List<String> get correctLetters => keyboardKeys.where((key) => key.state.isCorrect).map((key) => key.key).toList();

  List<String> get incorrectLetters => keyboardKeys.where((key) => key.state.isIncorrect).map((key) => key.key).toList();

  String get wordOfTheDay => currentGame!.wordOfTheDay;

  List<String> get guesses => currentGame!.guesses;

  StateOfPlay get stateOfPlay => currentGame!.stateOfPlay;

  int get currentIndex => currentGame!.currentIndex;

  GameState copyWith({
    GameStatus? status,
    Game? currentGame,
    List<KeyboardKey>? keyboardKeys,
  }) {
    return GameState(
      status: status ?? this.status,
      currentGame: currentGame,
      keyboardKeys: keyboardKeys ?? this.keyboardKeys,
    );
  }

  @override
  List<Object?> get props => [
        status,
        currentGame,
        keyboardKeys,
      ];
}
