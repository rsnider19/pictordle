import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictordle/game/cubit/game_cubit.dart';
import 'package:pictordle/game/view/widgets/widgets.dart';
import 'package:pictordle/loader/loader.dart';

class GamePage extends StatelessWidget {
  const GamePage({
    super.key,
  });

  static Route<GamePage> route() {
    return MaterialPageRoute(
      builder: (context) => const GamePage(),
      settings: const RouteSettings(
        name: '/game',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pictordle'),
        centerTitle: true,
      ),
      body: BlocBuilder<GameCubit, GameState>(
        buildWhen: (previous, current) => previous.status != current.status,
        builder: (context, state) {
          switch (state.status) {
            case GameStatus.initial:
              return const SizedBox.shrink();
            case GameStatus.loading:
              return const Loader();
            case GameStatus.success:
              return const GameView();
            case GameStatus.failure:
              return const Center(child: Text('Oops! Something went wrong.'));
          }
        },
      ),
    );
  }
}

class GameView extends StatelessWidget {
  const GameView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: const [
          Expanded(
            child: Gameboard(pictordleWord: 'CIGAR'),
          ),
          Keyboard(),
        ],
      ),
    );
  }
}