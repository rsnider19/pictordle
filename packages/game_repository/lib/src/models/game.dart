import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'game.g.dart';

enum StateOfPlay { inProgress, won, lost }

@immutable
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Game extends Equatable {
  const Game({
    required this.wordOfTheDay,
    this.guesses = const ['', '', '', '', '', ''],
    this.stateOfPlay = StateOfPlay.inProgress,
    this.currentIndex = 0,
  });

  final String wordOfTheDay;
  final List<String> guesses;
  final StateOfPlay stateOfPlay;
  final int currentIndex;

  Game updateGuess({
    required int rowIndex,
    required String newValue,
  }) {
    return copyWith(
      guesses: [
        ...guesses.sublist(0, rowIndex),
        newValue,
        ...guesses.sublist(rowIndex + 1),
      ],
    );
  }

  Game copyWith({
    String? wordOfTheDay,
    List<String>? guesses,
    StateOfPlay? stateOfPlay,
    int? currentIndex,
  }) {
    return Game(
      wordOfTheDay: wordOfTheDay ?? this.wordOfTheDay,
      guesses: guesses ?? this.guesses,
      stateOfPlay: stateOfPlay ?? this.stateOfPlay,
      currentIndex: currentIndex ?? this.currentIndex,
    );
  }

  factory Game.fromJson(Map<String, dynamic> json) {
    return _$GameFromJson(json);
  }

  Map<String, dynamic> toJson() => _$GameToJson(this);

  @override
  List<Object> get props => [
        wordOfTheDay,
        guesses,
        stateOfPlay,
        currentIndex,
      ];
}
