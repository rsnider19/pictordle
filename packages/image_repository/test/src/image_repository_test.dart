// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_repository/image_repository.dart';
import 'package:mocktail/mocktail.dart';
// ignore_for_file: prefer_const_constructors
import 'package:test/test.dart';

class _MockFirebaseStorage extends Mock implements FirebaseStorage {}

void main() {
  late final FirebaseStorage firebaseStorage;

  setUpAll(() {
    firebaseStorage = _MockFirebaseStorage();
  });

  group('ImageRepository', () {
    test('can be instantiated', () {
      expect(
        ImageRepository(firebaseStorage),
        isNotNull,
      );
    });
  });
}
