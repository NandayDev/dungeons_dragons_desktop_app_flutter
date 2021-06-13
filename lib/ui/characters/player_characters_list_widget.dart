import 'dart:ui';

import 'package:dungeonsanddragons_helper/models/character.dart';
import 'package:dungeonsanddragons_helper/ui/characters/player_characters_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PlayerCharacterListWidget extends ConsumerWidget {

  late PlayerCharactersListViewModel _viewModel;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final PlayerCharactersListState state = watch(PlayerCharactersListViewModel.provider);
    _viewModel = context.read(PlayerCharactersListViewModel.provider.notifier);

    if (state.arePlayersToBeLoaded) {
      // Loads the player characters //
      _viewModel.loadPlayerCharacters();
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
                          DataColumn(label: Text("Character name")),
                          DataColumn(label: Text("Class")),
                          DataColumn(label: Text("Level")),
                          DataColumn(label: Text("Initiative")),
                          DataColumn(label: Text("Armor class")),
                          DataColumn(label: Text("Passive wisdom")),
                          DataColumn(label: Text("Stealth")),
                          DataColumn(label: Text("Insight")),
                          DataColumn(label: Text("Edit")),
                        ],
                        rows: _getTableRows(state.playerCharacters, context)
                            .toList(),
                      showCheckboxColumn: false,
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
        DataCell(Text(character.playerName)),
        DataCell(Text(character.name)),
        DataCell(Text(character.primaryClass)),
        DataCell(Text(character.level.toString())),
        DataCell(Text(_bonusToString(character.initiativeBonus))),
        DataCell(Text(character.armorClass.toString())),
        DataCell(Text(_bonusToString(character.passiveWisdom))),
        DataCell(Text(_bonusToString(character.stealth))),
        DataCell(Text(_bonusToString(character.insight))),
        DataCell(IconButton (
          icon: Icon(Icons.edit),
          hoverColor: Colors.primaries[0].shade100,
          onPressed: () {

          },))
      ]);
    }
  }

  ///
  /// Converts a bonus into a readable string
  ///
  String _bonusToString(int bonus) => bonus >= 0 ? "+" + bonus.toString() : "-" + bonus.toString();
}
