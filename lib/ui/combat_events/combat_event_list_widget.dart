import 'package:dungeonsanddragons_helper/ui/combat_events/combat_event_list_element_viewmodel.dart';
import 'package:dungeonsanddragons_helper/ui/combat_events/combat_event_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CombatEventListWidget extends ConsumerWidget {

  CombatEventListViewModel? _viewModel;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final CombatEventListState state = watch(
        CombatEventListViewModel.provider);
    if (_viewModel == null)
      _viewModel = context.read(CombatEventListViewModel.provider.notifier);

    if (state.areCombatEventsToBeLoadedYet) {
      // Loads the player characters //
      _viewModel!.loadCombatEvents();
    }

    return Scaffold(
        body: Center(
            child: state.areCombatEventsToBeLoadedYet
            // Shows a loading indicator while loading //
                ? CircularProgressIndicator()
            // Shows the list, if loaded //
                : Container(
                alignment: Alignment.center,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text("Date")),
                    DataColumn(label: Text("Battle name")),
                    DataColumn(label: Text("Characters")),
                    DataColumn(label: Text("Round num.")),
                    DataColumn(label: Text("Edit")),
                  ],
                  rows: _getTableRows(state.combatEvents, context)
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
      List<CombatEventListElementViewModel> combatEvents, BuildContext context) sync* {
    // Table rows //
    for (final combatEvent in combatEvents) {
      yield DataRow(cells: [
        DataCell(Text(combatEvent.creationDate.toString())),
        DataCell(Text(combatEvent.name)),
        DataCell(Text(combatEvent.numberOfCharacters.toString())),
        DataCell(Text(combatEvent.currentRound.toString())),
        DataCell(IconButton (
          icon: Icon(Icons.edit),
          hoverColor: Colors.primaries[0].shade100,
          onPressed: () {
            // TODO
          },))
      ]);
    }
  }
}