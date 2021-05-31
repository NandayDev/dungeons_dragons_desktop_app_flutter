import 'package:flutter/foundation.dart';

class EnumUtility {

  ///
  /// Returns an enum element from an integer, based on position in the enum list
  ///
  static T? parseFromInt<T>(List<T> values, int value) {
    for(int i = 0; i < values.length; i++) {
      if (values[i] == value) {
        return values[i];
      }
    }
    return null;
  }

}