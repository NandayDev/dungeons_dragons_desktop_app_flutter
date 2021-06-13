import 'package:dungeonsanddragons_helper/models/base_model.dart';

import 'character.dart';

///
/// Class representing a combat event, a fight, currently happening or past
///
class CombatEvent extends BaseModel {
  /// Creates a new combat event
  CombatEvent.createNew(
      this.characters,
      this.currentHps,
      this.initiativesRolled,
      this.isRoundOver,
      this.currentRound)
      : super.createNew();

  /// Creates a combat event already existing in the database
  CombatEvent.fromExisting(
      int id,
      DateTime creationDate,
      this.characters,
      this.currentHps,
      this.initiativesRolled,
      this.isRoundOver,
      this.currentRound)
      : super.fromExisting(id, creationDate);

  /// List of IDs for the combatants of the fight
  List<Character> characters;

  /// Each character linked to how many HPs it has currently
  Map<Character, int> currentHps;

  /// Each character linked to how many it rolled in initiative
  Map<Character, int> initiativesRolled;

  /// Each character linked to whether its round is over or not
  Map<Character, bool> isRoundOver;

  /// Current round of the combat (zero-indexed)
  int currentRound;
}
