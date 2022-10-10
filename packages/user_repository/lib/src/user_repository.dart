// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartx/dartx.dart';
import 'package:game_repository/game_repository.dart';
import 'package:meta/meta.dart';
import 'package:time/time.dart';
import 'package:user_repository/src/models/user.dart';

/// {@template user_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class UserRepository {
  /// {@macro user_repository}
  const UserRepository(
    FirebaseFirestore firebaseFirestore,
  ) : _firebaseFirestore = firebaseFirestore;

  final FirebaseFirestore _firebaseFirestore;

  CollectionReference get _users => _firebaseFirestore.collection('users');

  Future<User> getUser({
    required String userId,
    required String wordOfTheDay,
  }) async {
    var user = User(
      userId: userId,
      lastPlayed: DateTime.now().millisecondsSinceEpoch,
      currentGame: Game(
        wordOfTheDay: wordOfTheDay,
      ),
    );

    final doc = await _users.doc(userId).get();
    if (doc.exists) {
      user = User.fromJson(doc.data()! as Map<String, dynamic>);
    }

    if (user.lastPlayedDate?.isBefore(DateTime.now().date) ?? false) {
      user = await resetGame(
        user: user,
        wordOfTheDay: wordOfTheDay,
      );
    }

    return user;
  }

  @visibleForTesting
  Future<User> resetGame({
    required User user,
    required String wordOfTheDay,
  }) async {
    return updateUser(
      user.copyWith(
        currentGame: Game(
          wordOfTheDay: wordOfTheDay,
        ),
        lastPlayed: DateTime.now().millisecondsSinceEpoch,
      ),
    );
  }

  Future<User> updateUser(User user) async {
    _users.doc(user.userId).set(user.toJson());
    return user;
  }

  Future<User> completeGame(User user) {
    final stateOfPlay = user.currentGame.stateOfPlay;

    assert(
      stateOfPlay == StateOfPlay.won || stateOfPlay == StateOfPlay.lost,
      "stateOfPlay must be 'won' or 'lost'",
    );

    final isWon = stateOfPlay == StateOfPlay.won;
    final incCurrentStreak = isWon && (user.lastCompletedDate?.wasYesterday ?? true);
    final guessDistribution = user.guessDistribution.toMap();
    final guessCount = user.currentGame.guesses.count((g) => g.isNotEmpty);
    final guessDistKey = isWon ? guessCount.toString() : 'fail';
    guessDistribution[guessDistKey] = guessDistribution[guessDistKey]! + 1;

    return updateUser(
      user.copyWith(
        lastPlayed: DateTime.now().millisecondsSinceEpoch,
        lastCompleted: isWon ? DateTime.now().millisecondsSinceEpoch : null,
        gamesPlayed: user.gamesPlayed + 1,
        gamesWon: user.gamesWon + (isWon ? 1 : 0),
        currentStreak: incCurrentStreak ? user.currentStreak + 1 : 1,
        maxStreak: user.maxStreak + (incCurrentStreak ? 1 : 0),
        guessDistribution: guessDistribution,
      ),
    );
  }
}
