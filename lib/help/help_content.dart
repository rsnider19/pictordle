import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_repository/image_repository.dart';
import 'package:pictordle/help/help_example.dart';

class HelpContent extends StatelessWidget {
  const HelpContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final imageRepository = context.read<ImageRepository>();

    return Scrollbar(
      thumbVisibility: true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ...const [
                Text('Guess the Pictordle in 6 tries.'),
                SizedBox(height: 16),
                Text('Each guess must be a valid 5 letter word. Hit the enter button to submit.'),
                SizedBox(height: 16),
                Text('After each guess, any correct letters will reveal part '
                    'of the picture and appear orange on the keyboard. This '
                    'does not mean that the letter is in the correct spot; '
                    'it just means that it is in the word.'),
                Divider(height: 32),
              ],
              Stack(
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: imageRepository.imageUrl,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  const HelpExample(
                    guess: 'CHAIR',
                    correctLetters: ['A'],
                  ),
                ],
              ),
              ...const [
                Text('The letter A is in the word, but it is not necessarily '
                    'in the correct spot'),
                SizedBox(height: 16),
                HelpExample(
                  guess: 'WITCH',
                  correctLetters: [],
                ),
                Text('None of the letters are in the word'),
                Divider(height: 32),
                Text(
                  'EXAMPLE',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
              ],
              Stack(
                children: [
                  Positioned.fill(
                    child: CachedNetworkImage(
                      imageUrl: imageRepository.imageUrl,
                      fit: BoxFit.fitWidth,
                    ),
                  ),
                  Column(
                    children: const [
                      HelpExample(
                        guess: 'CHAIR',
                        correctLetters: ['A'],
                      ),
                      HelpExample(
                        guess: 'MALTY',
                        correctLetters: ['A', 'L'],
                      ),
                      HelpExample(
                        guess: 'APPLE',
                        correctLetters: ['A', 'P', 'L', 'E'],
                      ),
                      HelpExample(
                        guess: '',
                        correctLetters: [],
                        isGameComplete: true,
                      ),
                      HelpExample(
                        guess: '',
                        correctLetters: [],
                        isGameComplete: true,
                      ),
                      HelpExample(
                        guess: '',
                        correctLetters: [],
                        isGameComplete: true,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'A new Pictordle will be available each day!',
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
