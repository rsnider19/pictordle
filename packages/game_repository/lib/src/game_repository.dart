// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game_repository/src/all_words.dart';
import 'package:intl/intl.dart';

import 'models/models.dart';

/// {@template game_repository}
/// A Very Good Project created by Very Good CLI.
/// {@endtemplate}
class GameRepository {
  /// {@macro game_repository}
  GameRepository(
    FirebaseFirestore firebaseFirestore,
  ) : _firebaseFirestore = firebaseFirestore;

  FirebaseFirestore _firebaseFirestore;

  bool isValidWord(String guess) => allWords.contains(guess.toLowerCase());

  Future<String> getWordOfTheDay() async {
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
    final documentSnapshot = await _firebaseFirestore.collection('pictordles').doc(today).get();

    if (documentSnapshot.exists) {
      return documentSnapshot.data()!['word'].toString().toUpperCase();
    } else {
      throw FetchWordOfTheDayException(
        'Pictordle for $today not available.',
        StackTrace.current,
      );
    }
  }
}
