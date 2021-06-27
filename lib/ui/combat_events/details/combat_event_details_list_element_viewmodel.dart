class CombatEventDetailsListElementViewModel {

  CombatEventDetailsListElementViewModel(
      this.characterName,
      int initiativeRolled,
      int currentHp,
      bool isRoundOver
      ) {
    this.initiativeRolled = initiativeRolled.toString();
    this.currentHp = currentHp.toString();
    this.isRoundOver = isRoundOver ? "Yes" : "No";
  }

  String characterName;

  late String initiativeRolled;

  late String currentHp;

  late String isRoundOver;
}