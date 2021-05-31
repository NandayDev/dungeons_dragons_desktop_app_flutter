import 'package:dungeonsanddragons_helper/models/character.dart';
import 'package:dungeonsanddragons_helper/ui/characters/player_characters_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerCharacterListWidget extends ConsumerWidget {

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final PlayerCharactersListState state = watch(PlayerCharactersListViewModel.provider);
    var viewModel = context.read(PlayerCharactersListViewModel.provider.notifier);

    if (state.arePlayersToBeLoaded) {
      // Loads the player characters //
      viewModel.loadPlayerCharacters();
    }

    return Scaffold(
        body: Center(
            child: state.arePlayersToBeLoaded
                ? CircularProgressIndicator()
                : Container(
                alignment: Alignment.center,
                child: ListView.builder(
                    padding: EdgeInsets.all(16.0),
                    itemBuilder: (context, i) {
                      if (i.isOdd) return Divider();

                      final index = i ~/ 2;

                      if (index >= state.playerCharacters.length) {
                        return Container();
                      }
                      return CharacterListElement(state.playerCharacters[i]);
                    })
            )
        )
    );
  }
}

class CharacterListElement extends StatelessWidget {

  CharacterListElement(this._playerCharacter);

  final PlayerCharacter _playerCharacter;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          Text(_playerCharacter.playerName),
          Text(_playerCharacter.name)
        ],
      )
    );
  }

}
