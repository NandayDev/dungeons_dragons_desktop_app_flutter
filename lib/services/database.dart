import 'dart:core';

import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DungeonsDatabase {
  static Future<Database> getDatabaseInstance() {
    sqfliteFfiInit();
    var databaseFactory = databaseFactoryFfi;
    var openDatabaseOptions =
        OpenDatabaseOptions(version: 1, onCreate: _createDatabase);
    return databaseFactory.openDatabase(_DB_PATH, options: openDatabaseOptions);
  }

  static Future _createDatabase(Database db, int version) {
    return db.transaction((txn) async => {
          // Characters table //
          await txn.execute("CREATE TABLE $CHARACTERS_TABLE (" +
              "$BASE_MODEL_ID INTEGER PRIMARY KEY AUTOINCREMENT," +
              "$BASE_MODEL_CREATION_DATE INTEGER NOT NULL," +
              "$CHARACTER_TYPE INTEGER NOT NULL," +
              "$CHARACTER_NAME TEXT NOT NULL," +
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
              "$CHARACTER_INSIGHT INTEGER NOT NULL);" +

              // Character notes table //
              "CREATE TABLE $CHARACTER_NOTES_TABLE (" +
              "$BASE_MODEL_ID INTEGER PRIMARY KEY AUTOINCREMENT," +
              "$BASE_MODEL_CREATION_DATE INTEGER NOT NULL," +
              "$CHARACTER_NOTES_CHARACTER_ID INTEGER NOT NULL," +
              "$CHARACTER_NOTES_CONTENT TEXT NOT NULL," +
              "$CHARACTER_NOTES_PRIORITY INTEGER NOT NULL);" +

              // Combat events table //
              "CREATE TABLE $COMBAT_EVENTS_TABLE (" +
              "$BASE_MODEL_ID INTEGER PRIMARY KEY AUTOINCREMENT," +
              "$BASE_MODEL_CREATION_DATE INTEGER NOT NULL," +
              "$COMBAT_EVENT_NAME TEXT NOT NULL," +
              "$COMBAT_EVENT_CHARACTERS TEXT NOT NULL," +
              "$COMBAT_EVENT_CURRENT_HPS TEXT NOT NULL," +
              "$COMBAT_EVENT_INITIATIVES_ROLLED TEXT NOT NULL," +
              "$COMBAT_EVENT_IS_ROUND_OVER TEXT NOT NULL," +
              "$COMBAT_EVENT_CURRENT_ROUND INTEGER NOT NULL);" +

              // Wiki documents //
              "CREATE TABLE $WIKI_DOCS_TABLE (" +
              "$BASE_MODEL_ID INTEGER PRIMARY KEY AUTOINCREMENT," +
              "$BASE_MODEL_CREATION_DATE INTEGER NOT NULL," +
              "$WIKI_DOC_PARENT_ID INTEGER DEFAULT NULL," +
              "$WIKI_DOC_TITLE TEXT NOT NULL," +
              "$WIKI_DOC_TEXT TEXT NOT NULL," +
              "FOREIGN KEY ($WIKI_DOC_PARENT_ID) REFERENCES $WIKI_DOCS_TABLE($BASE_MODEL_ID));" +

              // Wiki keywords //
              "CREATE TABLE $WIKI_KEYWORDS_TABLE (" +
              "$BASE_MODEL_ID INTEGER PRIMARY KEY AUTOINCREMENT," +
              "$BASE_MODEL_CREATION_DATE INTEGER NOT NULL," +
              "$WIKI_KEYWORD_NAME TEXT NOT NULL," +
              "$WIKI_KEYWORD_TYPE INTEGER NOT NULL);")
        });
  }

  static const String _DB_PATH = "db.dungeonsdragonsdb";

  static const String BASE_MODEL_ID = "id";
  static const String BASE_MODEL_CREATION_DATE = "creation_date";

  static const String CHARACTERS_TABLE = "players";
  static const String CHARACTER_TYPE = "type";
  static const String CHARACTER_NAME = "name";
  static const String CHARACTER_PLAYER_NAME = "player_name";
  static const String CHARACTER_STRENGTH = "strength";
  static const String CHARACTER_DEXTERITY = "dexterity";
  static const String CHARACTER_CONSTITUTION = "constitution";
  static const String CHARACTER_INTELLIGENCE = "intelligence";
  static const String CHARACTER_WISDOM = "wisdom";
  static const String CHARACTER_CHARISMA = "charisma";
  static const String CHARACTER_PRIMARY_CLASS = "primary_class";
  static const String CHARACTER_LEVEL = "level";
  static const String CHARACTER_INITIATIVE_BONUS = "initiative_bonus";
  static const String CHARACTER_ARMOR_CLASS = "armor_class";
  static const String CHARACTER_PASSIVE_WISDOM = "passive_wisdom";
  static const String CHARACTER_STEALTH = "stealth";
  static const String CHARACTER_INSIGHT = "insight";
  static const int CHARACTER_TYPE_PC = 0;
  static const int CHARACTER_TYPE_NPC = 1;
  static const int CHARACTER_TYPE_MONSTER = 2;

  static const String CHARACTER_NOTES_TABLE = "character_notes";
  static const String CHARACTER_NOTES_CHARACTER_ID = "character_id";
  static const String CHARACTER_NOTES_CONTENT = "content";
  static const String CHARACTER_NOTES_PRIORITY = "priority";

  static const String COMBAT_EVENTS_TABLE = "combat_events";
  static const String COMBAT_EVENT_NAME = "name";
  static const String COMBAT_EVENT_CHARACTERS = "characters";
  static const String COMBAT_EVENT_CURRENT_HPS = "current_hps";
  static const String COMBAT_EVENT_INITIATIVES_ROLLED = "initiatives_rolled";
  static const String COMBAT_EVENT_IS_ROUND_OVER = "is_round_over";
  static const String COMBAT_EVENT_CURRENT_ROUND = "current_round";

  static const String WIKI_DOCS_TABLE = "wiki_docs";
  static const String WIKI_DOC_PARENT_ID = "parent_id";
  static const String WIKI_DOC_TITLE = "title";
  static const String WIKI_DOC_TEXT = "text";

  static const String WIKI_KEYWORDS_TABLE = "wiki_keywords";
  static const String WIKI_KEYWORD_NAME = "name";
  static const String WIKI_KEYWORD_TYPE = "type";
}
