import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:game_repository/game_repository.dart';
import 'package:pictordle/game/cubit/game_cubit.dart';
import 'package:pictordle/game/models/keyboard_key.dart';
import 'package:pictordle/game/view/widgets/keyboard/keyboard_key_widget.dart';

class Keyboard extends StatelessWidget {
  const Keyboard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final keyboardKeys = context.select(
      (GameCubit cubit) => cubit.state.keyboardKeys,
    );

    final gameStateOfPlay = context.select(
      (GameCubit cubit) => cubit.state.stateOfPlay,
    );

    return IgnorePointer(
      ignoring: gameStateOfPlay != StateOfPlay.inProgress,
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
        child: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: KeyboardRow.values.map(
                  (row) {
                    final rowKeys = keyboardKeys.where((k) => k.row == row);

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        rowKeys.length,
                        (index) {
                          final key = rowKeys.elementAt(index);
                          final width = constraints.maxWidth / 10 * (key.type.isLetter ? 1 : 1.5);

                          return KeyboardKeyWidget(
                            keyboardKey: key,
                            width: width,
                          );
                        },
                      ),
                    );
                  },
                ).toList(),
              );
            },
          ),
        ),
      ),
    );
  }
}
