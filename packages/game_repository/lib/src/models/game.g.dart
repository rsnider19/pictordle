// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'game.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      wordOfTheDay: json['word_of_the_day'] as String,
      guesses: (json['guesses'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const ['', '', '', '', '', ''],
      stateOfPlay:
          $enumDecodeNullable(_$StateOfPlayEnumMap, json['state_of_play']) ??
              StateOfPlay.inProgress,
      currentIndex: json['current_index'] as int? ?? 0,
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'word_of_the_day': instance.wordOfTheDay,
      'guesses': instance.guesses,
      'state_of_play': _$StateOfPlayEnumMap[instance.stateOfPlay]!,
      'current_index': instance.currentIndex,
    };

const _$StateOfPlayEnumMap = {
  StateOfPlay.inProgress: 'inProgress',
  StateOfPlay.won: 'won',
  StateOfPlay.lost: 'lost',
};
