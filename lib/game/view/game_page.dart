import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';
import 'package:pictordle/game/cubit/game_cubit.dart';
import 'package:pictordle/game/view/widgets/widgets.dart';
import 'package:pictordle/help/help_page.dart';
import 'package:pictordle/loader/loader.dart';
import 'package:pictordle/results/results_dialog.dart';

class GamePage extends StatelessWidget {
  const GamePage({
    super.key,
  });

  static const String routeName = '/game';

  static Route<GamePage> route() {
    return MaterialPageRoute(
      builder: (context) => const GamePage(),
      settings: const RouteSettings(
        name: routeName,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GameCubit, GameState>(
      listenWhen: (previous, current) {
        return previous.status == GameStatus.loading && current.status == GameStatus.success;
      },
      listener: (context, state) {
        final gameCubit = context.read<GameCubit>();
        if (state.stateOfPlay.isComplete) {
          gameCubit.showResults(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Pictordle'),
          centerTitle: true,
          actions: [
            BlocBuilder<GameCubit, GameState>(
              builder: (context, state) {
                if ((state.user?.gamesPlayed ?? 0) > 0) {
                  return IconButton(
                    onPressed: () => ResultsDialog.open(context, state.user!),
                    icon: const Icon(Icons.bar_chart),
                  );
                }

                return const SizedBox();
              },
            ),
            IconButton(
              onPressed: () => Navigator.of(context).push(HelpPage.route()),
              icon: const Icon(Icons.help_outline),
            ),
          ],
        ),
        body: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 500,
            ),
            child: BlocBuilder<GameCubit, GameState>(
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
          ),
        ),
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
