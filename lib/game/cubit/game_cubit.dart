import 'dart:async';

import 'package:auth_repository/auth_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dartx/dartx.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:game_repository/game_repository.dart';
import 'package:image_repository/image_repository.dart';
import 'package:pictordle/game/models/models.dart';
import 'package:user_repository/user_repository.dart';

part 'game_state.dart';

class GameCubit extends Cubit<GameState> {
  GameCubit({
    required GameRepository gameRepository,
    required UserRepository userRepository,
    required AuthRepository authRepository,
    required ImageRepository imageRepository,
  })  : _gameRepository = gameRepository,
        _userRepository = userRepository,
        _authRepository = authRepository,
        _imageRepository = imageRepository,
        super(const GameState());

  final GameRepository _gameRepository;
  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final ImageRepository _imageRepository;

  @visibleForTesting
  List<KeyboardKey> getKeyboardKeys({
    required String wordOfTheDay,
    required List<String> guesses,
  }) {
    const keyboardRows = [
      ['Q', 'W', 'E', 'R', 'T', 'Y', 'U', 'I', 'O', 'P'],
      ['A', 'S', 'D', 'F', 'G', 'H', 'J', 'K', 'L'],
      ['DEL', 'Z', 'X', 'C', 'V', 'B', 'N', 'M', 'RET'],
    ];

    return keyboardRows
        .mapIndexed((rowNumber, keys) {
          return keys.map(
            (k) => KeyboardKey(
              key: k,
              rowNumber: rowNumber,
              type: k == 'DEL'
                  ? KeyType.delete
                  : k == 'RET'
                      ? KeyType.enter
                      : KeyType.letter,
              state: guesses.any((guess) => guess.contains(k) && wordOfTheDay.contains(k))
                  ? KeyState.correct
                  : guesses.any((guess) => guess.contains(k))
                      ? KeyState.incorrect
                      : KeyState.unused,
            ),
          );
        })
        .expand((key) => key)
        .toList();
  }

  Future<void> load() async {
    emit(
      state.copyWith(status: GameStatus.loading),
    );

    final wordOfTheDay = await _gameRepository.getWordOfTheDay();
    final user = await _userRepository.getUser(
      userId: _authRepository.getUserId(),
      wordOfTheDay: wordOfTheDay,
    );

    await _imageRepository.loadImage(wordOfTheDay);

    emit(
      state.copyWith(
        status: GameStatus.success,
        keyboardKeys: getKeyboardKeys(
          wordOfTheDay: wordOfTheDay,
          guesses: user.currentGame.guesses,
        ),
        currentGame: user.currentGame,
        user: user,
      ),
    );
  }

  Future<void> enterOnPressed(BuildContext context) async {
    final guess = state.guesses[state.currentIndex];

    // guess isn't long enough, clear it out
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

    // guess is not a valid word, notify the user
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

    // guess is the word of the day, complete the game
    if (guess == state.wordOfTheDay) {
      await _completeGame(StateOfPlay.won);
      return;
    }

    // increment row
    final currentGame = state.currentGame!.copyWith(
      currentIndex: state.currentIndex + 1,
    );

    // update user's remote data
    unawaited(
      _userRepository.updateUser(
        state.user!.copyWith(
          currentGame: currentGame,
        ),
      ),
    );

    emit(
      state.copyWith(
        currentGame: currentGame,
        keyboardKeys: getKeyboardKeys(
          wordOfTheDay: state.wordOfTheDay,
          guesses: state.guesses,
        ),
      ),
    );

    // this was user's last guess, so they lose
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
        keyboardKeys: getKeyboardKeys(
          wordOfTheDay: state.wordOfTheDay,
          guesses: state.guesses,
        ),
        currentGame: state.currentGame!.copyWith(
          stateOfPlay: gameStateOfPlay,
        ),
      ),
    );

    await _userRepository.completeGame(
      state.user!.copyWith(
        currentGame: state.currentGame,
      ),
    );

    // showResults();
  }
}
