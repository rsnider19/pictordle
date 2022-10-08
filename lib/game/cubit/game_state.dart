part of 'game_cubit.dart';

enum GameStatus { initial, loading, success, failure }

enum GameStateOfPlay { inProgress, won, lost }

@immutable
class GameState extends Equatable {
  const GameState({
    this.status = GameStatus.initial,
    this.keyboardKeys = const [],
    this.wordOfTheDay = '',
    this.gameStateOfPlay = GameStateOfPlay.inProgress,
    this.guesses = const ['', '', '', '', '', ''],
    this.activeRowIndex = 0,
  });

  final GameStatus status;
  final List<KeyboardKey> keyboardKeys;
  final String wordOfTheDay;
  final GameStateOfPlay gameStateOfPlay;
  final List<String> guesses;
  final int activeRowIndex;

  List<String> get correctLetters => keyboardKeys
      .where(
        (key) => key.state.isCorrect,
      )
      .map((key) => key.key)
      .toList();

  List<String> get incorrectLetters => keyboardKeys
      .where(
        (key) => key.state.isIncorrect,
      )
      .map((key) => key.key)
      .toList();

  GameState updateGuess({
    required int rowIndex,
    required String newValue,
  }) {
    return copyWith(
      guesses: [
        ...guesses.sublist(0, rowIndex),
        newValue,
        ...guesses.sublist(rowIndex + 1),
      ],
    );
  }

  @override
  List<Object> get props => [
        status,
        keyboardKeys,
        wordOfTheDay,
        gameStateOfPlay,
        guesses,
        activeRowIndex,
      ];

  GameState copyWith({
    GameStatus? status,
    List<KeyboardKey>? keyboardKeys,
    String? wordOfTheDay,
    GameStateOfPlay? gameStateOfPlay,
    List<String>? guesses,
    int? activeRowIndex,
  }) {
    return GameState(
      status: status ?? this.status,
      keyboardKeys: keyboardKeys ?? this.keyboardKeys,
      wordOfTheDay: wordOfTheDay ?? this.wordOfTheDay,
      gameStateOfPlay: gameStateOfPlay ?? this.gameStateOfPlay,
      guesses: guesses ?? this.guesses,
      activeRowIndex: activeRowIndex ?? this.activeRowIndex,
    );
  }
}
