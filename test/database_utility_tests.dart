import 'package:dungeonsanddragons_helper/utilities/database_utility.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test("Test database utility's int array conversion", () {

    // First ints //

    List<int> arr = [];
    String str = DatabaseUtility.transformIntegersIntoDatabaseString(arr);
    expect(str, "");

    arr.add(12);
    str = DatabaseUtility.transformIntegersIntoDatabaseString(arr);
    expect(str, "12");

    arr.add(1245);
    str = DatabaseUtility.transformIntegersIntoDatabaseString(arr);
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

    // Now booleans //

    List<bool> boolArr = [];
    str = DatabaseUtility.transformBooleansIntoDatabaseString(boolArr);
    expect(str, "");

    boolArr.add(true);
    str = DatabaseUtility.transformBooleansIntoDatabaseString(boolArr);
    expect(str, "1");

    boolArr.add(false);
    str = DatabaseUtility.transformBooleansIntoDatabaseString(boolArr);
    expect(str, "1,0");

    str = "0,0,1";
    boolArr = DatabaseUtility.transformIntoArrayOfBool(str);
    expect(boolArr.length, 3);
    expect(boolArr[0], false);
    expect(boolArr[1], false);
    expect(boolArr[2], true);

    str = "0";
    boolArr = DatabaseUtility.transformIntoArrayOfBool(str);
    expect(boolArr.length, 1);
    expect(boolArr[0], false);

    str = "";
    boolArr = DatabaseUtility.transformIntoArrayOfBool(str);
    expect(boolArr.length, 0);
  });
}
