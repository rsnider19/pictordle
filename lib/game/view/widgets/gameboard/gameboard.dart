import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';
import 'package:image_repository/image_repository.dart';
import 'package:pictordle/game/cubit/game_cubit.dart';
import 'package:pictordle/game/view/widgets/gameboard/gameboard_row_widget.dart';

class Gameboard extends StatefulWidget {
  const Gameboard({
    super.key,
    required this.pictordleWord,
  });

  final String pictordleWord;

  @override
  State<Gameboard> createState() => _GameboardState();
}

class _GameboardState extends State<Gameboard> {
  @override
  Widget build(BuildContext context) {
    final state = context.select((GameCubit cubit) => cubit.state);
    final imageRepository = context.read<ImageRepository>();

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 32,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: CachedNetworkImage(
              imageUrl: imageRepository.imageUrl,
              fit: BoxFit.fitWidth,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              ...List.generate(
                6,
                (index) => Flexible(
                  child: GameboardRowWidget(
                    guess: state.guesses[index],
                    isRowComplete: index < state.currentIndex,
                    isGameComplete: state.stateOfPlay != StateOfPlay.inProgress,
                    correctLetters: state.correctLetters,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
