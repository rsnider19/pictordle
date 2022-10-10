// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      userId: json['user_id'] as String,
      currentGame: Game.fromJson(json['current_game'] as Map<String, dynamic>),
      gamesPlayed: json['games_played'] as int? ?? 0,
      gamesWon: json['games_won'] as int? ?? 0,
      currentStreak: json['current_streak'] as int? ?? 0,
      maxStreak: json['max_streak'] as int? ?? 0,
      guessDistribution:
          (json['guess_distribution'] as Map<String, dynamic>?)?.map(
                (k, e) => MapEntry(k, e as int),
              ) ??
              _defaultGuessDistribution,
      lastPlayed: json['last_played'] as int?,
      lastCompleted: json['last_completed'] as int?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'user_id': instance.userId,
      'current_game': instance.currentGame.toJson(),
      'games_played': instance.gamesPlayed,
      'games_won': instance.gamesWon,
      'current_streak': instance.currentStreak,
      'max_streak': instance.maxStreak,
      'guess_distribution': instance.guessDistribution,
      'last_played': instance.lastPlayed,
      'last_completed': instance.lastCompleted,
    };
