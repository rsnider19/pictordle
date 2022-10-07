import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pictordle/game/cubit/game_cubit.dart';
import 'package:pictordle/game/models/models.dart';

class KeyboardKeyWidget extends StatelessWidget {
  const KeyboardKeyWidget({
    super.key,
    required this.keyboardKey,
    required this.width,
  });

  final KeyboardKey keyboardKey;
  final double width;

  @override
  Widget build(BuildContext context) {
    final gameCubit = context.read<GameCubit>();

    var backgroundColor = Colors.grey.shade400;
    if (keyboardKey.state == KeyState.incorrect) {
      backgroundColor = Colors.grey.shade600;
    } else if (keyboardKey.state == KeyState.correct) {
      backgroundColor = Theme.of(context).primaryColor;
    }

    final textButtonStyle = TextButton.styleFrom(
      backgroundColor: backgroundColor,
      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );

    return SizedBox(
      height: 64,
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Builder(
          builder: (context) {
            if (keyboardKey.type == KeyType.enter) {
              return TextButton(
                onPressed: gameCubit.enterOnPressed,
                style: textButtonStyle,
                child: const Icon(
                  Icons.keyboard_return,
                  size: 16,
                  color: Colors.white,
                ),
              );
            }

            if (keyboardKey.type == KeyType.delete) {
              return TextButton(
                onPressed: gameCubit.deleteOnPressed,
                style: textButtonStyle,
                child: const Icon(
                  Icons.backspace_outlined,
                  size: 16,
                  color: Colors.white,
                ),
              );
            }

            return TextButton(
              onPressed: keyboardKey.state.isUnused ? () => gameCubit.letterOnPressed(keyboardKey) : null,
              style: textButtonStyle,
              child: Text(
                keyboardKey.key,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
