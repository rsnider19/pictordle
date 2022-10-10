// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:auth_repository/auth_repository.dart';
import 'package:game_repository/game_repository.dart';
import 'package:image_repository/image_repository.dart';
import 'package:pictordle/app/app.dart';
import 'package:pictordle/bootstrap.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

void main() {
  bootstrap(
    (firebaseAuth, firebaseFirestore, firebaseStorage) async {
      final gameRepository = GameRepository(firebaseFirestore);
      final userRepository = UserRepository(firebaseFirestore);

      final authRepository = AuthRepository(firebaseAuth);
      await authRepository.authenticateAnonymously();

      final imageRepository = ImageRepository(firebaseStorage);
      final sharedPreferences = await SharedPreferences.getInstance();

      return App(
        gameRepository: gameRepository,
        userRepository: userRepository,
        authRepository: authRepository,
        imageRepository: imageRepository,
        sharedPreferences: sharedPreferences,
      );
    },
  );
}
