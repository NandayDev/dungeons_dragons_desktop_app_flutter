import 'package:sqflite_sqlcipher/sqflite.dart';

class DungeonsDatabase {

  static Future<Database> getDatabaseInstance() {
    return openDatabase(
        _DB_PATH,
        password: "dmsarethebest",
        onCreate: createDatabase);
  }

  static Future createDatabase(Database db, int version) async {
    // Characters table creation //
    await db.execute("CREATE TABLE $CHARACTERS_TABLE (" +
        "$CHARACTER_ID INTEGER PRIMARY KEY AUTOINCREMENT," +
        "$CHARACTER_TYPE INTEGER NOT NULL," +
        "$CHARACTER_PLAYER_NAME TEXT NULL," +
        "$CHARACTER_STRENGTH INTEGER NOT NULL," +
        "$CHARACTER_DEXTERITY INTEGER NOT NULL," +
        "$CHARACTER_CONSTITUTION INTEGER NOT NULL," +
        "$CHARACTER_INTELLIGENCE INTEGER NOT NULL," +
        "$CHARACTER_WISDOM INTEGER NOT NULL," +
        "$CHARACTER_CHARISMA INTEGER NOT NULL," +
        "$CHARACTER_PRIMARY_CLASS TEXT NOT NULL," +
        "$CHARACTER_LEVEL INTEGER NOT NULL," +
        "$CHARACTER_INITIATIVE_BONUS INTEGER NOT NULL," +
        "$CHARACTER_ARMOR_CLASS INTEGER NOT NULL," +
        "$CHARACTER_PASSIVE_WISDOM INTEGER NOT NULL," +
        "$CHARACTER_STEALTH INTEGER NOT NULL," +
        "$CHARACTER_INSIGHT INTEGER NOT NULL)");
  }

  static const String _DB_PATH = "db.db";
  static const String CHARACTERS_TABLE = "players";
  static const String CHARACTER_ID = "id";
  static const String CHARACTER_TYPE = "type";
  static const String CHARACTER_PLAYER_NAME = "player_name";
  static const String CHARACTER_STRENGTH = "strength";
  static const String CHARACTER_DEXTERITY = "dexterity";
  static const String CHARACTER_CONSTITUTION = "constitution";
  static const String CHARACTER_INTELLIGENCE = "intelligence";
  static const String CHARACTER_WISDOM = "wisdom";
  static const String CHARACTER_CHARISMA = "charisma";

  static const String CHARACTER_PRIMARY_CLASS = "primaryClass";
  static const String CHARACTER_LEVEL = "level";

  static const String CHARACTER_INITIATIVE_BONUS  = "initiativeBonus";
  static const String CHARACTER_ARMOR_CLASS  = "armorClass";

  static const String CHARACTER_PASSIVE_WISDOM = "passiveWisdom";
  static const String CHARACTER_STEALTH = "stealth";
  static const String CHARACTER_INSIGHT = "insight";

  static const int CHARACTER_TYPE_PC = 0;
  static const int CHARACTER_TYPE_NPC = 1;
  static const int CHARACTER_TYPE_MONSTER = 2;
}