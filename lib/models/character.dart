abstract class Character {

  Character(
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
      this.insight);

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

  PlayerCharacter(
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
      : super(
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

  NonPlayingCharacter(
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
      : super(
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