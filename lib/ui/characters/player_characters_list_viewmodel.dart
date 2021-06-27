import 'package:dungeonsanddragons_helper/models/character.dart';
import 'package:dungeonsanddragons_helper/services/repositories/character_repository.dart';
import 'package:dungeonsanddragons_helper/services/dependency_injector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

///
/// View model for the player characters list
///
class PlayerCharactersListViewModel extends StateNotifier<PlayerCharactersListState> {

  static final provider = StateNotifierProvider<PlayerCharactersListViewModel, PlayerCharactersListState>((ref) => DependencyInjector.getInstance().resolve<PlayerCharactersListViewModel>());

  /// Constructor for D.I.
  PlayerCharactersListViewModel(this._repository) : super(PlayerCharactersListState.toBeLoadedYet());

  /// Repository for the characters
  final CharacterRepository _repository;

  ///
  /// Loads the player characters from the repository, and changes the state
  /// Widget will be notified
  ///
  Future loadPlayerCharacters() async {
    var playerCharacters = await _repository.getAllPlayerCharacters();
    state = PlayerCharactersListState.loaded(playerCharacters);
  }
}

///
/// State to share between view and viewmodel
///
class PlayerCharactersListState {

  /// Constructor for when player characters are yet to be loaded
  PlayerCharactersListState.toBeLoadedYet() {
    this.arePlayersToBeLoaded = true;
    this.playerCharacters = [];
  }

  /// Constructor for player characters when they're already loaded
  PlayerCharactersListState.loaded(this.playerCharacters) {
    this.arePlayersToBeLoaded = false;
  }

  /// Whether the players characters were loaded already
  late bool arePlayersToBeLoaded;
  /// List of player characters
  late List<PlayerCharacter> playerCharacters;
}