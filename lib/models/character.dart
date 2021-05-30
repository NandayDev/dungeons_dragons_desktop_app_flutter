import 'package:dungeonsanddragons_helper/models/base_model.dart';
import 'package:dungeonsanddragons_helper/services/database.dart';

abstract class Character extends BaseModel {

  Character.fromExisting(
      int id,
      DateTime creationDate,
      this.strength,
      this.dexterity,
      this.constitution,
      this.intelligence,
      this.wisdom,
      this.charisma,
      this.primaryClass,
      this.level,
      this.initiativeBonus,
      this.armorClass,
      this.passiveWisdom,
      this.stealth,
      this.insight) : super.fromExisting(id, creationDate);

  Character.createNew(
      this.strength,
      this.dexterity,
      this.constitution,
      this.intelligence,
      this.wisdom,
      this.charisma,
      this.primaryClass,
      this.level,
      this.initiativeBonus,
      this.armorClass,
      this.passiveWisdom,
      this.stealth,
      this.insight) : super.createNew();

  @DatabaseColumn(DungeonsDatabase.CHARACTER_STRENGTH)
  int strength;
  int dexterity;
  int constitution;
  int intelligence;
  int wisdom;
  int charisma;

  String primaryClass;
  int level;

  int initiativeBonus;
  int armorClass;

  int passiveWisdom;
  int stealth;
  int insight;

  int get proficiencyBonus =>
      level % 4 == 0 ?
      (level / 4).floor() + 1 :
      (level / 4).floor() + 2;
}

class PlayerCharacter extends Character {

  PlayerCharacter.createNew(
      this.playerName,
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
      : super.createNew(
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

  PlayerCharacter.fromExisting(
      int id,
      DateTime creationDate,
      this.playerName,
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
      : super.fromExisting(
      id,
      creationDate,
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


  String playerName;


}

class NonPlayingCharacter extends Character {

  NonPlayingCharacter.createNew(
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
      : super.createNew(
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
}