import 'package:bloc/bloc.dart';
import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:game_repository/game_repository.dart';
import 'package:pictordle/game/models/models.dart';
import 'package:pictordle_utils/pictordle_utils.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({
    required GameRepository gameRepository,
  })  : _gameRepository = gameRepository,
        super(const GameState());

  final GameRepository _gameRepository;

  @visibleForTesting
  List<KeyboardKey> mapKeys(List<String> keys, KeyboardRow row) => keys
      .map(
        (k) => KeyboardKey(
          key: k,
          row: row,
          type: KeyType.letter,
        ),
      )
      .toList();

  @visibleForTesting
  List<KeyboardKey> getKeyboardKeys() {
    const keys = [
      ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
      ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
      ['Z', 'X', 'C', 'V', 'B', 'N', 'M'],
    ];

    return [
      ...mapKeys(keys[0], KeyboardRow.row1),
      ...mapKeys(keys[1], KeyboardRow.row2),
      const KeyboardKey(key: 'DEL', row: KeyboardRow.row3, type: KeyType.delete),
      ...mapKeys(keys[2], KeyboardRow.row3),
      const KeyboardKey(key: 'RET', row: KeyboardRow.row3, type: KeyType.enter),
    ];
  }

  Future<void> load() async {
    emit(
      state.copyWith(status: GameStatus.loading),
    );

    final wordOfTheDay = await _gameRepository.getWordOfTheDay();

    emit(
      state.copyWith(
        status: GameStatus.success,
        keyboardKeys: getKeyboardKeys(),
        currentGame: Game(wordOfTheDay: wordOfTheDay),
      ),
    );
  }

  Future<void> enterOnPressed(BuildContext context) async {
    final guess = state.guesses[state.currentIndex];

    if (guess.length < 5) {
      emit(
        state.copyWith(
          currentGame: state.currentGame!.updateGuess(
            rowIndex: state.currentIndex,
            newValue: '',
          ),
        ),
      );

      return;
    }

    if (_gameRepository.isValidWord(guess) == false) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Not in word list',
            textAlign: TextAlign.center,
          ),
          behavior: SnackBarBehavior.floating,
          width: 200,
          duration: 1500.milliseconds,
        ),
      );

      return;
    }

    var keyboardKeys = state.keyboardKeys.map((k) => k).toList();
    for (final letter in guess.split('')) {
      final key = keyboardKeys.singleWhere((k) => k.key == letter);

      keyboardKeys = keyboardKeys.replace(
        key,
        key.copyWith(
          state: state.wordOfTheDay.contains(letter) ? KeyState.correct : KeyState.incorrect,
        ),
      );
    }

    if (guess == state.wordOfTheDay) {
      await _completeGame(StateOfPlay.won);
      return;
    }

    // TODO(rob): update user game data in firestore

    emit(
      state.copyWith(
        keyboardKeys: keyboardKeys,
        currentGame: state.currentGame!.copyWith(
          currentIndex: state.currentIndex + 1,
        ),
      ),
    );

    if (state.currentGame!.currentIndex >= 6) {
      await _completeGame(StateOfPlay.lost);
    }
  }

  void deleteOnPressed() {
    final guess = state.guesses[state.currentGame!.currentIndex];

    if (guess.isEmpty) {
      return;
    }

    emit(
      state.copyWith(
        currentGame: state.currentGame!.updateGuess(
          rowIndex: state.currentGame!.currentIndex,
          newValue: guess.substring(0, guess.length - 1),
        ),
      ),
    );
  }

  void letterOnPressed(KeyboardKey keyboardKey) {
    final guess = state.guesses[state.currentIndex];

    if (guess.length == 5) {
      return;
    }

    emit(
      state.copyWith(
        currentGame: state.currentGame!.updateGuess(
          rowIndex: state.currentIndex,
          newValue: '$guess${keyboardKey.key}',
        ),
      ),
    );
  }

  Future<void> _completeGame(StateOfPlay gameStateOfPlay) async {
    emit(
      state.copyWith(
        currentGame: state.currentGame!.copyWith(
          stateOfPlay: gameStateOfPlay,
        ),
      ),
    );
  }
}
