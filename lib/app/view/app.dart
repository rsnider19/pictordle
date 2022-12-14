// Copyright (c) 2022, Very Good Ventures
// https://verygood.ventures
//
// Use of this source code is governed by an MIT-style
// license that can be found in the LICENSE file or at
// https://opensource.org/licenses/MIT.

import 'package:auth_repository/auth_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:game_repository/game_repository.dart';
import 'package:image_repository/image_repository.dart';
import 'package:pictordle/game/cubit/game_cubit.dart';
import 'package:pictordle/game/view/view.dart';
import 'package:pictordle/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:user_repository/user_repository.dart';

class App extends StatelessWidget {
  const App({
    super.key,
    required GameRepository gameRepository,
    required UserRepository userRepository,
    required AuthRepository authRepository,
    required ImageRepository imageRepository,
    required SharedPreferences sharedPreferences,
  })  : _gameRepository = gameRepository,
        _userRepository = userRepository,
        _authRepository = authRepository,
        _imageRepository = imageRepository,
        _sharedPreferences = sharedPreferences;

  final GameRepository _gameRepository;
  final UserRepository _userRepository;
  final AuthRepository _authRepository;
  final ImageRepository _imageRepository;
  final SharedPreferences _sharedPreferences;

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider.value(value: _gameRepository),
        RepositoryProvider.value(value: _userRepository),
        RepositoryProvider.value(value: _authRepository),
        RepositoryProvider.value(value: _imageRepository),
        RepositoryProvider.value(value: _sharedPreferences),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => GameCubit(
              gameRepository: _gameRepository,
              userRepository: _userRepository,
              authRepository: _authRepository,
              imageRepository: _imageRepository,
            )..load(),
          ),
        ],
        child: MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.purple,
            visualDensity: VisualDensity.standard,
            materialTapTargetSize: MaterialTapTargetSize.padded,
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          initialRoute: GamePage.routeName,
          routes: {
            GamePage.routeName: (context) => const GamePage(),
          },
        ),
      ),
    );
  }
}
