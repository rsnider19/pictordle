import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

@immutable
class KeyboardKey extends Equatable {
  const KeyboardKey({
    required this.key,
    required this.rowNumber,
    required this.type,
    this.state = KeyState.unused,
  });

  final String key;
  final int rowNumber;
  final KeyType type;
  final KeyState state;

  KeyboardKey copyWith({
    String? key,
    int? rowNumber,
    KeyType? type,
    KeyState? state,
  }) {
    return KeyboardKey(
      key: key ?? this.key,
      rowNumber: rowNumber ?? this.rowNumber,
      type: type ?? this.type,
      state: state ?? this.state,
    );
  }

  @override
  List<Object> get props => [
        key,
        rowNumber,
        type,
        state,
      ];
}

enum KeyType { letter, enter, delete }

enum KeyState { unused, correct, incorrect }

extension KeyTypeExt on KeyType {
  bool get isLetter => this == KeyType.letter;

  bool get isEnter => this == KeyType.enter;

  bool get isDelete => this == KeyType.delete;
}

extension KeyStateExt on KeyState {
  bool get isUnused => this == KeyState.unused;

  bool get isCorrect => this == KeyState.correct;

  bool get isIncorrect => this == KeyState.incorrect;
}
