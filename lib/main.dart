// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:auth_repository/auth_repository.dart';
import 'package:game_repository/game_repository.dart';
import 'package:pictordle/app/app.dart';
import 'package:pictordle/bootstrap.dart';

void main() {
  bootstrap(
    (firebaseAuth, firebaseFirestore) async {
      final authRepository = AuthRepository(firebaseAuth);
      await authRepository.authenticateAnonymously();

      final gameRepository = GameRepository(firebaseFirestore);

      return App(
        authRepository: authRepository,
        gameRepository: gameRepository,
      );
    },
  );
}
