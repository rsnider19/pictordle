import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';
import 'package:pictordle/game/cubit/game_cubit.dart';
import 'package:share_plus/share_plus.dart';
import 'package:user_repository/user_repository.dart';

class ResultsDialog extends StatelessWidget {
  const ResultsDialog({
    super.key,
    required this.user,
  });

  final User user;

  static const String routeName = '/game';

  static Future<void> open(BuildContext context, User user) {
    return showDialog(
      context: context,
      builder: (context) {
        return ResultsDialog(
          user: user,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      titlePadding: EdgeInsets.zero,
      contentPadding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 48),
          Column(
            children: [
              Text(
                "Today's Pictordle was",
                style: Theme.of(context).textTheme.caption,
              ),
              Text(
                user.currentGame.wordOfTheDay,
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
          IconButton(
            icon: const Icon(Icons.close, color: Colors.black),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Divider(),
          const SizedBox(height: 8),
          const Text(
            'STATISTICS',
            style: TextStyle(fontWeight: FontWeight.bold),
            textScaleFactor: 0.85,
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: Column(
                  children: [
                    Text(
                      user.gamesPlayed.toString(),
                      textScaleFactor: 1.5,
                    ),
                    const Text(
                      'Games\nPlayed',
                      textScaleFactor: 0.75,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      (100 * user.gamesWon / user.gamesPlayed).floor().toString(),
                      textScaleFactor: 1.5,
                    ),
                    const Text(
                      'Win\nPercent',
                      textScaleFactor: 0.75,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      user.currentStreak.toString(),
                      textScaleFactor: 1.5,
                    ),
                    const Text(
                      'Current\nStreak',
                      textScaleFactor: 0.75,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      user.maxStreak.toString(),
                      textScaleFactor: 1.5,
                    ),
                    const Text(
                      'Max\nStreak',
                      textScaleFactor: 0.75,
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      actions: [
        if (user.currentGame.stateOfPlay == StateOfPlay.won)
          ButtonBar(
            children: [
              ElevatedButton(
                onPressed: () {
                  final state = context.read<GameCubit>().state;
                  Share.share(
                    "I finished today's #Pictordle in ${state.currentIndex + 1} guesses!\n"
                    '${state.currentGame!.toEmojis()}\n'
                    'pictordle.com',
                  );
                },
                style: ElevatedButton.styleFrom(elevation: 0),
                child: Row(
                  children: [
                    Icon(Icons.adaptive.share),
                    const SizedBox(width: 8),
                    const Text('Share'),
                  ],
                ),
              ),
            ],
          ),
      ],
    );
  }
}
