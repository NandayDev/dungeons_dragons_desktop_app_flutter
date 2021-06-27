class DatabaseUtility {

  static const String _SEPARATOR = ",";

  static List<int> transformIntoArrayOfInt(String dbString) {
    if (dbString.isEmpty) {
      return [];
    }
    return dbString
        .split(_SEPARATOR)
        .map((e) => int.parse(e))
        .toList();
  }

  static List<bool> transformIntoArrayOfBool(String dbString) {
    return transformIntoArrayOfInt(dbString).map((e) => e == 1).toList();
  }

  static String transformIntegersIntoDatabaseString(List<int> listOfIntegers) {
    return listOfIntegers.join(_SEPARATOR);
  }

  static String transformBooleansIntoDatabaseString(List<bool> listOfBooleans) {
    return listOfBooleans.map((e) => e ? 1 : 0).join(_SEPARATOR);
  }
}