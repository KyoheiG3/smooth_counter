import 'package:intl/intl.dart';

/// A formatter for numbers.
class Formatter {
  late final _formatter = NumberFormat();

  /// Formats a number.
  /// number: the number to format.
  /// isSeparated: whether the number should be separated by commas.
  /// Returns the formatted number.
  /// See [NumberFormat.format].
  String format(num number, {bool isSeparated = true}) {
    return isSeparated ? _formatter.format(number) : number.toString();
  }

  /// Parses a number.
  /// text: the text to parse.
  /// Returns the parsed number.
  /// Throws a [FormatException] if the text is not a valid number.
  /// See [NumberFormat.parse].
  num parse(String text) => _formatter.parse(text);
}
