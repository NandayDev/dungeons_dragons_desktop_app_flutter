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
                    child: Table(
                        border: TableBorder.all(),
                        columnWidths: const <int, TableColumnWidth>{
                          0: FlexColumnWidth(),
                          1: FlexColumnWidth()
                        },
                        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                        children: _getTableRows(state.playerCharacters).toList()
                        ),
                  )));
  }

  Iterable<TableRow> _getTableRows(List<PlayerCharacter> characters) sync* {
    // Table header //
    yield TableRow(children: [
      TableCell(child: Text("Player name")),
      TableCell(child: Text("Character name"))
    ]);

    // Table rows //
    for (final character in characters) {
      yield TableRow(children: [
        TableCell(child: Text(character.playerName)),
        TableCell(child: Text(character.name)),
      ]);
    }
  }
}
