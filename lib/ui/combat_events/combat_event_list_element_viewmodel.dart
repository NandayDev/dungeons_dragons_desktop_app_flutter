class CombatEventListElementViewModel {

  CombatEventListElementViewModel(
      this._id,
      this._name,
      this._creationDate,
      this._numberOfCharacters,
      this._currentRound
      );

  int _id;
  /// Database ID
  int get id => _id;

  String _name;
  /// User-inserted name for this battle
  String get name => _name;

  DateTime _creationDate;
  /// Date of creation for the combat event
  DateTime get creationDate => _creationDate;

  int _numberOfCharacters;
  /// Count of PCs + NPCs + monsters
  int get numberOfCharacters => _numberOfCharacters;

  int _currentRound;
  /// Number of current round (0-indexed)
  int get currentRound => _currentRound;
}