// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:auth_repository/auth_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:game_repository/game_repository.dart';
import 'package:mocktail/mocktail.dart';
import 'package:pictordle/app/app.dart';
import 'package:pictordle/counter/counter.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class MockGameRepository extends Mock implements GameRepository {}

void main() {
  group('App', () {
    late AuthRepository authRepository;
    late GameRepository gameRepository;

    setUp(() {
      authRepository = MockAuthRepository();
      gameRepository = MockGameRepository();
    });

    testWidgets('renders CounterPage', (tester) async {
      await tester.pumpWidget(
        App(
          authRepository: authRepository,
          gameRepository: gameRepository,
        ),
      );
      expect(find.byType(CounterPage), findsOneWidget);
    });
  });
}
