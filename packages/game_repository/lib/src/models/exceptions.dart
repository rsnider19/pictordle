/// {@template game_exception}
/// Base exception for game repository failures.
/// {@endtemplate}
abstract class GameException implements Exception {
  /// {@macro game_exception}
  const GameException(this.error, this.stackTrace);

  /// The error that was caught.
  final Object error;

  /// The Stacktrace associated with the [error].
  final StackTrace stackTrace;
}

/// {@template fetch_word_of_the_day_exception}
/// Exception thrown when failure occurs while fetching the word of the day.
/// {@endtemplate}
class FetchWordOfTheDayException extends GameException {
  /// {@macro fetch_word_of_the_day_exception}
  const FetchWordOfTheDayException(
    super.error,
    super.stackTrace,
  );
}
