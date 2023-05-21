import 'dart:math';

extension DoubleExtension on double {
  /// Rounds the double to a specific decimal place
  double roundedPrecision(int places) {
    double mod = pow(10.0, places) as double;
    return ((this * mod).round().toDouble() / mod);
  }

  /// good for string output because it can remove trailing zeros
  /// and sometimes periods. Or optionally display the exact number of trailing
  /// zeros
  /// Format: input number: 1234567, Output: 1,234,567
  String roundedPrecisionToString(
    int places, {
    bool trailingZeros = false,
  }) {
    double mod = pow(10.0, places) as double;
    double round = ((this * mod).round().toDouble() / mod);
    String doubleToString =
        trailingZeros ? round.toStringAsFixed(places) : round.toString();
    if (!trailingZeros) {
      RegExp trailingZeros = RegExp(r'^[0-9]+.0+$');
      if (trailingZeros.hasMatch(doubleToString)) {
        doubleToString = doubleToString.split('.')[0];
      }
    }

    RegExp reg = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    mathFunc(Match match) => '${match[1]},';

    return doubleToString.replaceAllMapped(reg, mathFunc);
  }
}
