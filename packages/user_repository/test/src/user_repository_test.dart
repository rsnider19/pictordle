// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

// ignore_for_file: prefer_const_constructors
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mocktail/mocktail.dart';
import 'package:test/test.dart';
import 'package:user_repository/user_repository.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

void main() {
  late final FirebaseFirestore firebaseFirestore;

  setUp(() {
    firebaseFirestore = MockFirebaseFirestore();
  });

  group('UserRepository', () {
    test('can be instantiated', () {
      expect(
        UserRepository(firebaseFirestore),
        isNotNull,
      );
    });
  });
}
