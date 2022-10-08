import 'dart:math';

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';

class GameboardRowWidget extends StatelessWidget {
  const GameboardRowWidget({
    super.key,
    required this.guess,
    this.isRowComplete = false,
    this.fontSize,
    required this.correctLetters,
    required this.isGameComplete,
  });

  final String guess;
  final bool isRowComplete;
  final double? fontSize;
  final List<String> correctLetters;
  final bool isGameComplete;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final squareSize = min(constraints.maxHeight, constraints.maxWidth / 5);

        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            5,
            (index) {
              final letter = guess.split('').elementAtOrDefault(index, '').toUpperCase();
              final isCorrect = correctLetters.contains(letter);

              var backgroundColor = Colors.white;
              var fontColor = Colors.black;

              if (isRowComplete) {
                backgroundColor = isCorrect ? Colors.transparent : Colors.grey.shade600;
                fontColor = isCorrect ? Theme.of(context).primaryColor : Colors.black;
              }

              if (isGameComplete) {
                backgroundColor = Colors.transparent;
                fontColor = isCorrect ? Theme.of(context).primaryColor : Colors.black;
              }

              return ConstrainedBox(
                constraints: BoxConstraints.tight(
                  Size.square(squareSize),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.5),
                      color: backgroundColor,
                    ),
                    child: Center(
                      child: Stack(
                        children: [
                          Text(
                            letter,
                            style: TextStyle(
                              fontSize: fontSize ?? 32,
                              fontWeight: FontWeight.bold,
                              foreground: Paint()
                                ..style = PaintingStyle.stroke
                                ..strokeWidth = 2
                                ..color = Colors.white,
                            ),
                          ),
                          Text(
                            letter,
                            style: TextStyle(
                              fontSize: fontSize ?? 32,
                              fontWeight: FontWeight.bold,
                              color: fontColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
