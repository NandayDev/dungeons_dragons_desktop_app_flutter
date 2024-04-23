import 'package:dungeonsanddragons_helper/models/character.dart';
import 'package:dungeonsanddragons_helper/models/db/db_character.dart';
import 'package:dungeonsanddragons_helper/utilities/database_utility.dart';
import 'package:flutter/foundation.dart';

import '../local_storage.dart';

///
/// Repository for all characters persistent operations
///
abstract class CharacterRepository {
  ///
  /// Returns all player characters from the storage
  ///
  Future<List<PlayerCharacter>> getAllPlayerCharacters();

  ///
  /// Returns a single player character, fetched by id
  ///
  Future<Character?> getSingleCharacter(int characterId);

  ///
  /// Saves a new or existing player character to the storage
  ///
  Future<bool> savePlayerCharacter(PlayerCharacter character);
}

class CharacterRepositoryImpl implements CharacterRepository {
  CharacterRepositoryImpl(this._localStorage);

  final LocalStorage _localStorage;
  List<PlayerCharacter>? _cachedPlayerCharacters;

  @override
  Future<List<PlayerCharacter>> getAllPlayerCharacters() async {
    var queryResult = await _localStorage.getAllPlayerCharacters();

    if (!kReleaseMode) {
      var count = await _localStorage.getPlayerCharactersCount();
      if (count == 0) {
        await savePlayerCharacter(MOCK_PC_1);
        await savePlayerCharacter(MOCK_PC_2);
      }
    }

    _cachedPlayerCharacters = [];
    queryResult.forEach((dbCharacter) {
      _cachedPlayerCharacters!.add(dbCharacter.toCharacter() as PlayerCharacter);
    });
    return _cachedPlayerCharacters!;
  }

  @override
  Future<Character?> getSingleCharacter(int characterId) async {
    if (_cachedPlayerCharacters != null) {
      for (var playerChar in _cachedPlayerCharacters!) {
        if (playerChar.id == characterId) {
          return playerChar;
        }
      }
    }
    return _localStorage.getCharacterById(characterId)?.toCharacter();
  }

  @override
  Future<bool> savePlayerCharacter(PlayerCharacter character) async {
    _cachedPlayerCharacters = null;
    _localStorage.saveCharacter(character);
    return true;
  }

  static PlayerCharacter MOCK_PC_1 = PlayerCharacter.fromExisting(
      1, DateTime.now().toUtc(), "Guido", "Sir Arthur Swampwalker", 18, 12, 11, 19, 8, 14, "Paladin", 10, 4, 19, 4, 2, 5);

  static PlayerCharacter MOCK_PC_2 =
      PlayerCharacter.fromExisting(2, DateTime.now().toUtc(), "Andrea", "Darnas Oml", 15, 7, 12, 18, 8, 14, "Rogue", 6, 10, 3, 5, 8, 2);
}

extension DbCharacterToCharacter on DbCharacter {
  Character toCharacter() {
    switch (type) {
      case DungeonsDatabase.CHARACTER_TYPE_PC:
        return PlayerCharacter.fromExisting(
            id,
            DatabaseUtility.getUtcDateTimeFromMillisecondsSinceEpoch(creationDate),
            playerName,
            name,
            strength,
            dexterity,
            constitution,
            intelligence,
            wisdom,
            charisma,
            primaryClass,
            level,
            initiativeBonus,
            armorClass,
            passiveWisdom,
            stealth,
            insight);

      case DungeonsDatabase.CHARACTER_TYPE_NPC:
        return NonPlayingCharacter.fromExisting(id, DatabaseUtility.getUtcDateTimeFromMillisecondsSinceEpoch(creationDate), name, strength, dexterity,
            constitution, intelligence, wisdom, charisma, primaryClass, level, initiativeBonus, armorClass, passiveWisdom, stealth, insight);

      case DungeonsDatabase.CHARACTER_TYPE_MONSTER:
      default:
        // TODO
        throw Error();
    }
  }
}
