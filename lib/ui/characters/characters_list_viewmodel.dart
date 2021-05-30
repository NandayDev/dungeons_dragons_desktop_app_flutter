import 'package:dungeonsanddragons_helper/models/character.dart';
import 'package:dungeonsanddragons_helper/services/dependency_injector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CharactersListViewModel extends StateNotifier<CharactersListState> {

  static final provider = StateNotifierProvider<CharactersListViewModel, CharactersListState>((ref) => DependencyInjector.getInstance().resolve<CharactersListViewModel>());

  CharactersListViewModel() : super(CharactersListState.toBeLoadedYet());

}

class CharactersListState {
  
  CharactersListState.toBeLoadedYet() {
    this.arePlayersToBeLoaded = true;
    this.playerCharacters = [];
  }

  CharactersListState.loaded(this.playerCharacters) {
    this.arePlayersToBeLoaded = false;
  }

  late bool arePlayersToBeLoaded;
  late List<PlayerCharacter> playerCharacters;
}