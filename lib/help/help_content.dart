import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:pictordle/help/help_example.dart';
import 'package:url_launcher/url_launcher.dart';

class HelpContent extends StatelessWidget {
  const HelpContent({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints.tightFor(
        width: 500,
        height: MediaQuery.of(context).size.height,
      ),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            ...const [
              Text('Guess the Pictordle in 6 tries.'),
              SizedBox(height: 16),
              Text('Each guess must be a valid 5 letter word. Hit the enter button to submit.'),
              SizedBox(height: 16),
              Text('After each guess, any correct letters will reveal part '
                  'of the picture and appear purple on the keyboard. This '
                  'does not mean that the letter is in the correct spot; '
                  'it just means that it is in the word.'),
              Divider(height: 32),
            ],
            Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/apple.png',
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
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
                  child: Image.asset(
                    'assets/apple.png',
                    fit: BoxFit.fitWidth,
                    alignment: Alignment.topCenter,
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
            const SizedBox(height: 8),
            Center(
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: 'Large Icons',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(Uri.parse('https://icons8.com/icon/YK0qQs1lrfdW/large-icons'));
                        },
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    const TextSpan(
                      text: ' by ',
                    ),
                    TextSpan(
                      text: 'Icons8',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          launchUrl(Uri.parse('https://icons8.com/'));
                        },
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
