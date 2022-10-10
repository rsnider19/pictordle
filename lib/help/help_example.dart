import 'package:flutter/material.dart';
import 'package:pictordle/game/view/widgets/gameboard/gameboard_row_widget.dart';

class HelpExample extends StatelessWidget {
  const HelpExample({
    super.key,
    required this.guess,
    required this.correctLetters,
    this.isGameComplete = false,
  });

  final String guess;
  final List<String> correctLetters;
  final bool isGameComplete;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          width: constraints.maxWidth / 2,
          child: GameboardRowWidget(
            correctLetters: correctLetters,
            guess: guess,
            isGameComplete: isGameComplete,
            isRowComplete: true,
            fontSize: 24,
          ),
        );
      }
    );
  }
}
