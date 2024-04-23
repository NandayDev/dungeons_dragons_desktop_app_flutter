import 'dart:io';

import 'package:dungeonsanddragons_helper/models/character.dart';
import 'package:flutter/material.dart' as material;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqlcipher_flutter_libs/sqlcipher_flutter_libs.dart';
import 'package:sqlite3/open.dart';
import 'package:sqlite3/sqlite3.dart';

import '../models/db/db_character.dart';
import '../models/db/db_character_note.dart';
import 'logger.dart';
import 'migration_container.dart';

abstract class LocalStorage {
  Future<bool> initialize(String password);

  Iterable<DbCharacterNote> getCharacterNotes(Character character);

  Iterable<DbCharacter> getAllPlayerCharacters();

  DbCharacter? getCharacterById(int characterId);

  int getPlayerCharactersCount();

  void saveCharacter(Character character);
}

class DungeonsDatabase implements LocalStorage {
  DungeonsDatabase(this._logger);

  final Logger _logger;
  late Database _db;

  @override
  Future<bool> initialize(String password) async {
    material.WidgetsFlutterBinding.ensureInitialized();
    final docsDir = await _getDatabaseDirectory();
    // Future<Store> openStore() {...} is defined in the generated objectbox.g.dart
    _db = sqlite3.open(p.join(docsDir.path, _DB_FILE_NAME));
    if (_db.select('PRAGMA cipher_version;').isEmpty) {
      // Make sure that we're actually using SQLCipher, since the pragma used to encrypt
      // databases just fails silently with regular sqlite3 (meaning that we'd accidentally
      // use plaintext databases).

      _logger.error('SQLCipher library is not available, please check your dependencies!');
      return false;
    }
    // Set the encryption key for the database
    PreparedStatement preparedStatement = _db.prepare("PRAGMA key = '$password';");
    try {
      preparedStatement.execute();
      preparedStatement.dispose();
      int currentMigration = getCurrentMigration(_db);
      return MigrationContainer(_db, currentMigration).migrateDatabase();
    } catch (e) {
      _logger.error("initialize: $e");
      return false;
    }
  }

  @override
  Iterable<DbCharacterNote> getCharacterNotes(Character character) {
    return _db
        .select("SELECT * FROM ${DungeonsDatabase.CHARACTER_NOTES_TABLE} WHERE ${DungeonsDatabase.CHARACTER_NOTES_CHARACTER_ID} = ${character.id}")
        .map((e) =>
            DbCharacterNote(e[ID], e[CREATION_DATE], e[CHARACTER_NOTES_CHARACTER_ID], e[CHARACTER_NOTES_CONTENT], e[CHARACTER_NOTES_PRIORITY]));
  }

  @override
  Iterable<DbCharacter> getAllPlayerCharacters() {
    return _db.select("SELECT * FROM ${CHARACTERS_TABLE} WHERE ${CHARACTER_TYPE} = ${CHARACTER_TYPE_PC}").map((e) => e.toDbCharacter());
  }

  @override
  int getPlayerCharactersCount() {
    return _db.select("SELECT COUNT(*) FROM ${CHARACTERS_TABLE}").firstOrNull! as int;
  }

  @override
  DbCharacter? getCharacterById(int characterId) {
    return _db.select("SELECT * FROM ${CHARACTERS_TABLE} WHERE ${ID} = $characterId").map((e) => e.toDbCharacter()).firstOrNull;
  }

  @override
  void saveCharacter(Character character) {
    _db.execute(
        "REPLACE INTO ${CHARACTERS_TABLE} ($ID,$CREATION_DATE,$CHARACTER_PLAYER_NAME,$CHARACTER_NAME,$CHARACTER_STRENGTH,$CHARACTER_DEXTERITY,$CHARACTER_CONSTITUTION,$CHARACTER_INTELLIGENCE,$CHARACTER_WISDOM,$CHARACTER_CHARISMA,$CHARACTER_PRIMARY_CLASS,$CHARACTER_LEVEL,$CHARACTER_INITIATIVE_BONUS, $CHARACTER_ARMOR_CLASS,$CHARACTER_PASSIVE_WISDOM,$CHARACTER_STEALTH,$CHARACTER_INSIGHT,$CHARACTER_TYPE) " +
            "VALUES(${character.id}, ${character.creationDate}, ${character is PlayerCharacter ? "'${character.playerName}'" : "NULL"}, '${character.name}', ${character.strength}, ${character.dexterity}, ${character.constitution}, ${character.intelligence}, ${character.wisdom}, ${character.charisma}, ${character.primaryClass}, ${character.level}, ${character.initiativeBonus}, ${character.armorClass}, ${character.passiveWisdom}, ${character.stealth}, ${character.insight}, ${character.type}" +
            ");");
  }

  static Future<Directory> _getDatabaseDirectory() async {
    String directoryPath;
    if (Platform.isWindows) {
      directoryPath = p.join(Platform.environment['LOCALAPPDATA']!, "nanday_cosmos");
    } else if (Platform.isAndroid) {
      open.overrideFor(OperatingSystem.android, openCipherOnAndroid);
      Directory library = await getApplicationDocumentsDirectory();
      directoryPath = p.join(library.path, "nanday_dungeons");
    } else {
      throw UnimplementedError();
    }
    return await Directory(directoryPath).create(recursive: true);
  }

  static int getCurrentMigration(Database db) {
    ResultSet resultSet = db.select("SELECT * FROM sqlite_master WHERE type='table' AND name='$MIGRATION_TABLE_NAME'");
    if (resultSet.isNotEmpty) {
      ResultSet migrationResultSet = db.select("SELECT * FROM $MIGRATION_TABLE_NAME");
      for (var row in migrationResultSet) {
        return row[ID];
      }
    }
    return 0;
  }

  static const String _DB_FILE_NAME = "db.dungeonsdragonsdb";

  static const String MIGRATION_TABLE_NAME = "migrations";
  static const String ID = "id";
  static const String CREATION_DATE = "creation_date";

  static const String CHARACTERS_TABLE = "characters";
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
}

extension CharacterFromRow on Row {
  DbCharacter toDbCharacter() {
    return DbCharacter(
        this[DungeonsDatabase.ID],
        this[DungeonsDatabase.CREATION_DATE],
        this[DungeonsDatabase.CHARACTER_PLAYER_NAME],
        this[DungeonsDatabase.CHARACTER_NAME],
        this[DungeonsDatabase.CHARACTER_STRENGTH],
        this[DungeonsDatabase.CHARACTER_DEXTERITY],
        this[DungeonsDatabase.CHARACTER_CONSTITUTION],
        this[DungeonsDatabase.CHARACTER_INTELLIGENCE],
        this[DungeonsDatabase.CHARACTER_WISDOM],
        this[DungeonsDatabase.CHARACTER_CHARISMA],
        this[DungeonsDatabase.CHARACTER_PRIMARY_CLASS],
        this[DungeonsDatabase.CHARACTER_LEVEL],
        this[DungeonsDatabase.CHARACTER_INITIATIVE_BONUS],
        this[DungeonsDatabase.CHARACTER_ARMOR_CLASS],
        this[DungeonsDatabase.CHARACTER_PASSIVE_WISDOM],
        this[DungeonsDatabase.CHARACTER_STEALTH],
        this[DungeonsDatabase.CHARACTER_INSIGHT],
        this[DungeonsDatabase.CHARACTER_TYPE]);
  }
}
