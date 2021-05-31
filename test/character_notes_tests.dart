import 'package:dungeonsanddragons_helper/models/character_note.dart';
import 'package:dungeonsanddragons_helper/utilities/enum_utility.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Testing NotePriority enum", () {
    NotePriority expectedPriority = NotePriority.LOW;
    int priorityIntValue = 0;
    NotePriority resultingPriority = EnumUtility.parseFromInt(NotePriority.values, priorityIntValue)!;
    expect(resultingPriority, expectedPriority);

    expectedPriority = NotePriority.DEFAULT;
    priorityIntValue = 1;
    resultingPriority = EnumUtility.parseFromInt(NotePriority.values, priorityIntValue)!;
    expect(resultingPriority, expectedPriority);

    expectedPriority = NotePriority.HIGH;
    priorityIntValue = 2;
    resultingPriority = EnumUtility.parseFromInt(NotePriority.values, priorityIntValue)!;
    expect(resultingPriority, expectedPriority);

    // Reminder to add future values //
    expect(NotePriority.values.length, 3);
  });
}