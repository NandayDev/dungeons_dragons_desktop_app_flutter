import 'package:dungeonsanddragons_helper/enums/character_type.dart';
import 'package:dungeonsanddragons_helper/models/base_model.dart';

///
/// Base class for any D&D character, being PC, NPC or monster
///
abstract class Character extends BaseModel {
  /// Creates a character instance for an existing one (e.g. already present into the database)
  Character.fromExisting(int id, DateTime creationDate, this.name, this.strength, this.dexterity, this.constitution, this.intelligence, this.wisdom,
      this.charisma, this.primaryClass, this.level, this.initiativeBonus, this.armorClass, this.passiveWisdom, this.stealth, this.insight, this.type)
      : super.fromExisting(id, creationDate);

  /// Creates a brand new character
  Character.createNew(this.name, this.strength, this.dexterity, this.constitution, this.intelligence, this.wisdom, this.charisma, this.primaryClass,
      this.level, this.initiativeBonus, this.armorClass, this.passiveWisdom, this.stealth, this.insight, this.type)
      : super.createNew();

  /// Character name
  String name;

  /// Strength ability score
  int strength;

  /// Dexterity ability score
  int dexterity;

  /// Constitution ability score
  int constitution;

  /// Intelligence ability score
  int intelligence;

  /// Wisdom ability score
  int wisdom;

  /// Charisma ability score
  int charisma;

  /// Name of the primary class for the character
  String primaryClass;

  /// Level of the primary class
  int level;

  /// Bonus to the initiative (all included)
  int initiativeBonus;

  /// Character's armor class
  int armorClass;

  /// Passive wisdom total bonus
  int passiveWisdom;

  /// Stealth skill score
  int stealth;

  /// Insight skill score
  int insight;

  /// Proficiency bonus based on the primary class and level
  int get proficiencyBonus => level % 4 == 0 ? (level / 4).floor() + 1 : (level / 4).floor() + 2;

  CharacterType type;
}

///
/// Class for PCs (Player Characters)
///
class PlayerCharacter extends Character {
  PlayerCharacter.createNew(this.playerName, String name, int strength, int dexterity, int constitution, int intelligence, int wisdom, int charisma,
      String primaryClass, int level, int initiativeBonus, int armorClass, int passiveWisdom, int stealth, int insight)
      : super.createNew(name, strength, dexterity, constitution, intelligence, wisdom, charisma, primaryClass, level, initiativeBonus, armorClass,
            passiveWisdom, stealth, insight, CharacterType.PLAYER_CHARACTER);

  PlayerCharacter.fromExisting(
      int id,
      DateTime creationDate,
      this.playerName,
      String name,
      int strength,
      int dexterity,
      int constitution,
      int intelligence,
      int wisdom,
      int charisma,
      String primaryClass,
      int level,
      int initiativeBonus,
      int armorClass,
      int passiveWisdom,
      int stealth,
      int insight)
      : super.fromExisting(id, creationDate, name, strength, dexterity, constitution, intelligence, wisdom, charisma, primaryClass, level,
            initiativeBonus, armorClass, passiveWisdom, stealth, insight, CharacterType.PLAYER_CHARACTER);

  /// Name of the player playing this character
  String playerName;
}

///
/// Class for NPCs (Non Playing Characters)
///
class NonPlayingCharacter extends Character {
  NonPlayingCharacter.createNew(String name, int strength, int dexterity, int constitution, int intelligence, int wisdom, int charisma,
      String primaryClass, int level, int initiativeBonus, int armorClass, int passiveWisdom, int stealth, int insight)
      : super.createNew(name, strength, dexterity, constitution, intelligence, wisdom, charisma, primaryClass, level, initiativeBonus, armorClass,
            passiveWisdom, stealth, insight, CharacterType.NON_PLAYING_CHARACTER);

  NonPlayingCharacter.fromExisting(int id, DateTime creationDate, String name, int strength, int dexterity, int constitution, int intelligence,
      int wisdom, int charisma, String primaryClass, int level, int initiativeBonus, int armorClass, int passiveWisdom, int stealth, int insight)
      : super.fromExisting(id, creationDate, name, strength, dexterity, constitution, intelligence, wisdom, charisma, primaryClass, level,
            initiativeBonus, armorClass, passiveWisdom, stealth, insight, CharacterType.NON_PLAYING_CHARACTER);
}
