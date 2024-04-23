import 'package:dungeonsanddragons_helper/services/database.dart';
import 'package:sqlite3/sqlite3.dart';

class MigrationContainer {
  MigrationContainer(this._db, this._currentMigration);

  final Database _db;
  int _currentMigration;

  bool migrateDatabase() {
    try {
      _migrate(0, _migrate_0_1);
      return DungeonsDatabase.getCurrentMigration(_db) == _currentMigration;
    } catch (e) {
      print("migrateDatabase: $e");
      return false;
    }
  }

  void _migrate(int versionToMigrateFrom, void Function() migrateMethod) {
    if (_currentMigration == versionToMigrateFrom) {
      migrateMethod();
      _currentMigration++;
    }
  }

  void _migrate_0_1() {
    _db.execute("BEGIN TRANSACTION;");
    _db.execute("CREATE TABLE ${DungeonsDatabase.MIGRATION_TABLE_NAME} (${DungeonsDatabase.ID} INTEGER NOT NULL)");
    _db.execute("INSERT INTO ${DungeonsDatabase.MIGRATION_TABLE_NAME} (${DungeonsDatabase.ID}) VALUES (1)");
    _db.execute("CREATE TABLE ${DungeonsDatabase.CHARACTERS_TABLE} (" +
        "${DungeonsDatabase.ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
        "${DungeonsDatabase.CREATION_DATE} INTEGER NOT NULL," +
        "${DungeonsDatabase.CHARACTER_TYPE} INTEGER NOT NULL," +
        "${DungeonsDatabase.CHARACTER_NAME} TEXT NOT NULL," +
        "${DungeonsDatabase.CHARACTER_PLAYER_NAME} TEXT NULL," +
        "${DungeonsDatabase.CHARACTER_STRENGTH} INTEGER NOT NULL," +
        "${DungeonsDatabase.CHARACTER_DEXTERITY} INTEGER NOT NULL," +
        "${DungeonsDatabase.CHARACTER_CONSTITUTION} INTEGER NOT NULL," +
        "${DungeonsDatabase.CHARACTER_INTELLIGENCE} INTEGER NOT NULL," +
        "${DungeonsDatabase.CHARACTER_WISDOM} INTEGER NOT NULL," +
        "${DungeonsDatabase.CHARACTER_CHARISMA} INTEGER NOT NULL," +
        "${DungeonsDatabase.CHARACTER_PRIMARY_CLASS} TEXT NOT NULL," +
        "${DungeonsDatabase.CHARACTER_LEVEL} INTEGER NOT NULL," +
        "${DungeonsDatabase.CHARACTER_INITIATIVE_BONUS} INTEGER NOT NULL," +
        "${DungeonsDatabase.CHARACTER_ARMOR_CLASS} INTEGER NOT NULL," +
        "${DungeonsDatabase.CHARACTER_PASSIVE_WISDOM} INTEGER NOT NULL," +
        "${DungeonsDatabase.CHARACTER_STEALTH} INTEGER NOT NULL," +
        "${DungeonsDatabase.CHARACTER_INSIGHT} INTEGER NOT NULL" +
        ");" +

        // Character notes table //
        "CREATE TABLE ${DungeonsDatabase.CHARACTER_NOTES_TABLE} (" +
        "${DungeonsDatabase.ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
        "${DungeonsDatabase.CREATION_DATE} INTEGER NOT NULL," +
        "${DungeonsDatabase.CHARACTER_NOTES_CHARACTER_ID} INTEGER NOT NULL," +
        "${DungeonsDatabase.CHARACTER_NOTES_CONTENT} TEXT NOT NULL," +
        "${DungeonsDatabase.CHARACTER_NOTES_PRIORITY} INTEGER NOT NULL," +
        "FOREIGN KEY(${DungeonsDatabase.CHARACTER_NOTES_CHARACTER_ID}) REFERENCES ${DungeonsDatabase.CHARACTERS_TABLE}(${DungeonsDatabase.ID})" +
        ");"

            // Combat events table //
            "CREATE TABLE ${DungeonsDatabase.COMBAT_EVENTS_TABLE} (" +
        "${DungeonsDatabase.ID} INTEGER PRIMARY KEY AUTOINCREMENT," +
        "${DungeonsDatabase.CREATION_DATE} INTEGER NOT NULL," +
        "${DungeonsDatabase.COMBAT_EVENT_NAME} TEXT NOT NULL," +
        "${DungeonsDatabase.COMBAT_EVENT_CHARACTERS} TEXT NOT NULL," +
        "${DungeonsDatabase.COMBAT_EVENT_CURRENT_HPS} TEXT NOT NULL," +
        "${DungeonsDatabase.COMBAT_EVENT_INITIATIVES_ROLLED} TEXT NOT NULL," +
        "${DungeonsDatabase.COMBAT_EVENT_IS_ROUND_OVER} TEXT NOT NULL," +
        "${DungeonsDatabase.COMBAT_EVENT_CURRENT_ROUND} INTEGER NOT NULL" +
        ");");
    _db.execute("COMMIT TRANSACTION;");
  }
}
