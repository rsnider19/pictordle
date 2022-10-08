import 'package:bloc/bloc.dart';
import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:pictordle/game/models/models.dart';
import 'package:pictordle_utils/pictordle_utils.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit() : super(GameState());

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

    await Future.delayed(1.seconds, () => null);

    emit(
      state.copyWith(
        status: GameStatus.success,
        wordOfTheDay: 'CIGAR',
        keyboardKeys: getKeyboardKeys(),
      ),
    );
  }

  Future<void> enterOnPressed() async {
    final guess = state.guesses[state.activeRowIndex];

    if (guess.length < 5) {
      emit(
        state.updateGuess(
          rowIndex: state.activeRowIndex,
          newValue: '',
        ),
      );

      return;
    }

    // TODO(rob): check if it is a valid word

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
      await _completeGame(GameStateOfPlay.won);
      return;
    }

    // TODO(rob): update user game data in firestore

    emit(
      state.copyWith(
        activeRowIndex: state.activeRowIndex + 1,
        keyboardKeys: keyboardKeys,
      ),
    );

    if (state.activeRowIndex >= 6) {
      await _completeGame(GameStateOfPlay.lost);
    }
  }

  void deleteOnPressed() {
    final guess = state.guesses[state.activeRowIndex];

    if (guess.isEmpty) {
      return;
    }

    emit(
      state.updateGuess(
        rowIndex: state.activeRowIndex,
        newValue: guess.substring(0, guess.length - 1),
      ),
    );
  }

  void letterOnPressed(KeyboardKey keyboardKey) {
    final guess = state.guesses[state.activeRowIndex];

    if (guess.length == 5) {
      return;
    }

    emit(
      state.updateGuess(
        rowIndex: state.activeRowIndex,
        newValue: '$guess${keyboardKey.key}',
      ),
    );
  }

  Future<void> _completeGame(GameStateOfPlay gameStateOfPlay) async {
    emit(state.copyWith(gameStateOfPlay: gameStateOfPlay));
  }
}
