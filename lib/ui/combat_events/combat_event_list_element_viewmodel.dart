class CombatEventListElementViewModel {

  CombatEventListElementViewModel(
      this.id,
      this.name,
      this.creationDate,
      this.numberOfCharacters,
      this.currentRound
      );

  /// Database ID
  int id;

  /// User-inserted name for this battle
  String name;

  /// Date of creation for the combat event
  DateTime creationDate;

  /// Count of PCs + NPCs + monsters
  int numberOfCharacters;

  /// Number of current round
  int currentRound;
}