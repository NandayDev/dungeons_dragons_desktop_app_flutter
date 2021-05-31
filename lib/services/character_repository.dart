import 'package:dungeonsanddragons_helper/models/character.dart';
import 'package:dungeonsanddragons_helper/services/database.dart';
import 'package:flutter/foundation.dart';

///
/// Repository for all characters persistent operations
///
abstract class CharacterRepository {
  ///
  /// Returns all player characters from the storage
  ///
  Future<List<PlayerCharacter>> getAllPlayerCharacters();

  ///
  /// Saves a player character to the storage
  ///
  Future<bool> savePlayerCharacter(PlayerCharacter character);
}

class CharacterRepositoryImpl implements CharacterRepository {
  @override
  Future<List<PlayerCharacter>> getAllPlayerCharacters() async {
    var database = await DungeonsDatabase.getDatabaseInstance();
    var queryResult = await database.rawQuery(
        "SELECT * FROM ${DungeonsDatabase.CHARACTERS_TABLE} WHERE ${DungeonsDatabase.CHARACTER_TYPE} = ${DungeonsDatabase.CHARACTER_TYPE_PC}");

    if (!kReleaseMode) {
      var countQueryResult = await database.rawQuery("SELECT COUNT(*) FROM ${DungeonsDatabase.CHARACTERS_TABLE}");
      var count = countQueryResult[0].values.first as int;
      if (count == 0) {
        var pc1 = PlayerCharacter.createNew(
            "Guido",
            "Sir Arthur Swampwalker",
            18,
            12,
            11,
            19,
            8,
            14,
            "Paladin",
            10,
            4,
            19,
            4,
            2,
            5);
        var pc2 = PlayerCharacter.createNew(
            "Andrea",
            "Darnas Oml",
            15,
            7,
            12,
            18,
            8,
            14,
            "Rogue",
            6,
            10,
            3,
            5,
            8,
            2);
        await savePlayerCharacter(pc1);
        await savePlayerCharacter(pc2);
      }
    }

    List<PlayerCharacter> playerCharacters = [];
    queryResult.forEach((row) {
      playerCharacters.add(PlayerCharacter.fromExisting(
          row[DungeonsDatabase.BASE_MODEL_ID] as int,
          DungeonsDatabase.getUtcDateTimeFromMillisecondsSinceEpoch(
              row[DungeonsDatabase.BASE_MODEL_CREATION_DATE] as int),
          row[DungeonsDatabase.CHARACTER_PLAYER_NAME] as String,
          row[DungeonsDatabase.CHARACTER_NAME] as String,
          row[DungeonsDatabase.CHARACTER_STRENGTH] as int,
          row[DungeonsDatabase.CHARACTER_DEXTERITY] as int,
          row[DungeonsDatabase.CHARACTER_CONSTITUTION] as int,
          row[DungeonsDatabase.CHARACTER_INTELLIGENCE] as int,
          row[DungeonsDatabase.CHARACTER_WISDOM] as int,
          row[DungeonsDatabase.CHARACTER_CHARISMA] as int,
          row[DungeonsDatabase.CHARACTER_PRIMARY_CLASS] as String,
          row[DungeonsDatabase.CHARACTER_LEVEL] as int,
          row[DungeonsDatabase.CHARACTER_INITIATIVE_BONUS] as int,
          row[DungeonsDatabase.CHARACTER_ARMOR_CLASS] as int,
          row[DungeonsDatabase.CHARACTER_PASSIVE_WISDOM] as int,
          row[DungeonsDatabase.CHARACTER_STEALTH] as int,
          row[DungeonsDatabase.CHARACTER_INSIGHT] as int));
    });
    return playerCharacters;
  }

  @override
  Future<bool> savePlayerCharacter(PlayerCharacter character) async {
    var database = await DungeonsDatabase.getDatabaseInstance();
    int result = await database.insert(
        DungeonsDatabase.CHARACTERS_TABLE, character._toPlayerCharacterMap());
    return result > 0;
  }
}

extension CharacterToMap on Character {

  ///
  /// Converts any character into a map with each property
  /// Useful for database operations
  ///
  Map<String, dynamic> _toMap() {
    return {
      DungeonsDatabase.BASE_MODEL_CREATION_DATE: DungeonsDatabase.getMillisecondsSinceEpochFromDateTime(creationDate),
      DungeonsDatabase.CHARACTER_NAME: name,
      DungeonsDatabase.CHARACTER_STRENGTH: strength,
      DungeonsDatabase.CHARACTER_DEXTERITY: dexterity,
      DungeonsDatabase.CHARACTER_CONSTITUTION: constitution,
      DungeonsDatabase.CHARACTER_INTELLIGENCE: intelligence,
      DungeonsDatabase.CHARACTER_WISDOM: wisdom,
      DungeonsDatabase.CHARACTER_CHARISMA: charisma,
      DungeonsDatabase.CHARACTER_PRIMARY_CLASS: primaryClass,
      DungeonsDatabase.CHARACTER_LEVEL: level,
      DungeonsDatabase.CHARACTER_INITIATIVE_BONUS: initiativeBonus,
      DungeonsDatabase.CHARACTER_ARMOR_CLASS: armorClass,
      DungeonsDatabase.CHARACTER_PASSIVE_WISDOM: passiveWisdom,
      DungeonsDatabase.CHARACTER_STEALTH: stealth,
      DungeonsDatabase.CHARACTER_INSIGHT: insight
    };
  }
}

extension PlayerCharacterToMap on PlayerCharacter {

  ///
  /// Converts a player character into a map
  ///
  Map<String, dynamic> _toPlayerCharacterMap() {
    var map = _toMap();
    map[DungeonsDatabase.CHARACTER_TYPE] = DungeonsDatabase.CHARACTER_TYPE_PC;
    map[DungeonsDatabase.CHARACTER_PLAYER_NAME] = playerName;
    return map;
  }
}
