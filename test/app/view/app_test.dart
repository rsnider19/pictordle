// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:auth_repository/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_repository/game_repository.dart';
import 'package:image_repository/image_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pictordle/app/app.dart';
import 'package:pictordle/game/view/game_page.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

class _MockGameRepository extends Mock implements GameRepository {}

class _MockUserRepository extends Mock implements UserRepository {}

class _MockAuthRepository extends Mock implements AuthRepository {}

class _MockImageRepository extends Mock implements ImageRepository {}

class _MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('App', () {
    late GameRepository gameRepository;
    late UserRepository userRepository;
    late AuthRepository authRepository;
    late ImageRepository imageRepository;
    late SharedPreferences sharedPreferences;

    setUp(() {
      gameRepository = _MockGameRepository();
      userRepository = _MockUserRepository();
      authRepository = _MockAuthRepository();
      imageRepository = _MockImageRepository();
      sharedPreferences = _MockSharedPreferences();
    });

    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(
        App(
          gameRepository: gameRepository,
          userRepository: userRepository,
          authRepository: authRepository,
          imageRepository: imageRepository,
          sharedPreferences: sharedPreferences,
        ),
      );
      expect(find.byType(GamePage), findsOneWidget);
    });
  });
}
