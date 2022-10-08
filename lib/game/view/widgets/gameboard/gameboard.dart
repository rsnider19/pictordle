import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
  late final Future<String> downloadUrl;

  @override
  void initState() {
    super.initState();

    final ref = 'pictordles/${widget.pictordleWord.toLowerCase()}.png';
    downloadUrl = FirebaseStorage.instance.ref().child(ref).getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    final state = context.select((GameCubit cubit) => cubit.state);

    return Padding(
      padding: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 32,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: FutureBuilder<String>(
              future: downloadUrl,
              builder: (_, snapshot) {
                if (snapshot.hasData) {
                  return Image.network(
                    snapshot.data!,
                    fit: BoxFit.fitWidth,
                  );
                }

                return const SizedBox();
              },
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
                    isRowComplete: index < state.activeRowIndex,
                    isGameComplete: state.gameStateOfPlay != GameStateOfPlay.inProgress,
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
