import 'package:equatable/equatable.dart';
import 'package:game_repository/game_repository.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';

part 'user.g.dart';

const _defaultGuessDistribution = {
  '1': 0,
  '2': 0,
  '3': 0,
  '4': 0,
  '5': 0,
  '6': 0,
  'fail': 0,
};

@immutable
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class User extends Equatable {
  User({
    required this.userId,
    required this.currentGame,
    this.gamesPlayed = 0,
    this.gamesWon = 0,
    this.currentStreak = 0,
    this.maxStreak = 0,
    this.guessDistribution = _defaultGuessDistribution,
    this.lastPlayed,
    this.lastCompleted,
  });

  final String userId;
  final Game currentGame;
  final int gamesPlayed;
  final int gamesWon;
  final int currentStreak;
  final int maxStreak;
  final Map<String, int> guessDistribution;
  final int? lastPlayed;
  final int? lastCompleted;

  DateTime? get lastPlayedDate => lastPlayed != null ? DateTime.fromMillisecondsSinceEpoch(lastPlayed!) : null;

  DateTime? get lastCompletedDate => lastCompleted != null ? DateTime.fromMillisecondsSinceEpoch(lastCompleted!) : null;

  User copyWith({
    String? userId,
    Game? currentGame,
    int? gamesPlayed,
    int? gamesWon,
    int? currentStreak,
    int? maxStreak,
    Map<String, int>? guessDistribution,
    int? lastPlayed,
    int? lastCompleted,
  }) {
    return User(
      userId: userId ?? this.userId,
      currentGame: currentGame ?? this.currentGame,
      gamesPlayed: gamesPlayed ?? this.gamesPlayed,
      gamesWon: gamesWon ?? this.gamesWon,
      currentStreak: currentStreak ?? this.currentStreak,
      maxStreak: maxStreak ?? this.maxStreak,
      guessDistribution: guessDistribution ?? this.guessDistribution,
      lastPlayed: lastPlayed ?? this.lastPlayed,
      lastCompleted: lastCompleted ?? this.lastCompleted,
    );
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return _$UserFromJson(json);
  }

  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  List<Object?> get props => [
        userId,
        currentGame,
        gamesPlayed,
        gamesWon,
        currentStreak,
        maxStreak,
        guessDistribution,
        lastPlayed,
        lastCompleted,
      ];
}
