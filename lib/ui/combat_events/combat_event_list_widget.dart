import 'package:dungeonsanddragons_helper/ui/combat_events/combat_event_list_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CombatEventListWidget extends ConsumerWidget {

  late final CombatEventListViewModel _viewModel;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final CombatEventListState state = watch(
        CombatEventListViewModel.provider);
    _viewModel = context.read(CombatEventListViewModel.provider.notifier);

    if (state.areCombatEventsToBeLoadedYet) {
      // Loads the player characters //
      _viewModel.loadCombatEvents();
    }

    //TODO
    return Container();
  }
}