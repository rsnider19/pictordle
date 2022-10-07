import 'dart:math';

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
        keyboardKeys: getKeyboardKeys(),
      ),
    );
  }

  void enterOnPressed() {}

  void deleteOnPressed() {}

  void letterOnPressed(KeyboardKey key) {
    emit(
      state.copyWith(
        keyboardKeys: state.keyboardKeys.replace(
          key,
          key.copyWith(
            state: Random().nextInt(2) == 1 ? KeyState.incorrect : KeyState.correct,
          ),
        ),
      ),
    );
  }
}
