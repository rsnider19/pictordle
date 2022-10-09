// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:game_repository/game_repository.dart';
import 'package:mocktail/mocktail.dart';
// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';

class _MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late final FirebaseFirestore firebaseFirestore;

  setUp(() {
    firebaseFirestore = _MockFirebaseFirestore();
  });

  group('GameRepository', () {
    test('can be instantiated', () {
      expect(
        GameRepository(firebaseFirestore),
        isNotNull,
      );
    });
  });
}
