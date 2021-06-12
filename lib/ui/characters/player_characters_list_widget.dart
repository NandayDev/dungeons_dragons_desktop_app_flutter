import 'package:dungeonsanddragons_helper/models/character.dart';
import 'package:dungeonsanddragons_helper/ui/characters/player_characters_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerCharacterListWidget extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final PlayerCharactersListState state =
        watch(PlayerCharactersListViewModel.provider);
    var viewModel =
        context.read(PlayerCharactersListViewModel.provider.notifier);

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
                    child: DataTable(
                        columns: [
                          DataColumn(label: Text("Player name")),
                          DataColumn(label: Text("Character name"))
                        ],
                        rows: _getTableRows(state.playerCharacters, context)
                            .toList()
                    )
            )
        )
    );
  }

  ///
  /// Returns the list of rows for the datatable, with the characters info
  ///
  Iterable<DataRow> _getTableRows(
      List<PlayerCharacter> characters, BuildContext context) sync* {
    // Table rows //
    for (final character in characters) {
      yield DataRow(cells: [
        DataCell(Text(character.playerName,)),
        DataCell(Text(character.name)),
      ]);
    }
  }
}
