import 'package:dungeonsanddragons_helper/models/character.dart';
import 'package:dungeonsanddragons_helper/services/database.dart';

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
    List<PlayerCharacter> playerCharacters = [];
    queryResult.forEach((row) {
      playerCharacters.add(PlayerCharacter.fromExisting(
          row[DungeonsDatabase.BASE_MODEL_ID] as int,
          DungeonsDatabase.getUtcDateTimeFromMillisecondsSinceEpoch(
              row[DungeonsDatabase.BASE_MODEL_CREATION_DATE] as int),
          row[DungeonsDatabase.CHARACTER_PLAYER_NAME] as String,
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
        DungeonsDatabase.CHARACTERS_TABLE, character._toMap());
    return result > 0;
  }
}

extension CharacterToMap on Character {
  Map<String, dynamic> _toMap() {
    return {
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
  Map<String, dynamic> _toMap() {
    var map = (this as Character)._toMap();
    map[DungeonsDatabase.CHARACTER_TYPE] = DungeonsDatabase.CHARACTER_TYPE_PC;
    map[DungeonsDatabase.CHARACTER_PLAYER_NAME] = playerName;
    return map;
  }
}
