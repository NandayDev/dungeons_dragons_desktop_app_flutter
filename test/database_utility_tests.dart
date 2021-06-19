import 'package:dungeonsanddragons_helper/utilities/database_utility.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Test database utility's int array conversion", () {
    List<int> arr = [];

    String str = DatabaseUtility.transformIntoDatabaseString(arr);
    expect(str, "");

    arr.add(12);
    str = DatabaseUtility.transformIntoDatabaseString(arr);
    expect(str, "12");

    arr.add(1245);
    str = DatabaseUtility.transformIntoDatabaseString(arr);
    expect(str, "12,1245");

    str = "16,235,35";
    arr = DatabaseUtility.transformIntoArrayOfInt(str);
    expect(arr.length, 3);
    expect(arr[0], 16);
    expect(arr[1], 235);
    expect(arr[2], 35);

    str = "15364";
    arr = DatabaseUtility.transformIntoArrayOfInt(str);
    expect(arr.length, 1);
    expect(arr[0], 15364);

    str = "";
    arr = DatabaseUtility.transformIntoArrayOfInt(str);
    expect(arr.length, 0);

  });
}
