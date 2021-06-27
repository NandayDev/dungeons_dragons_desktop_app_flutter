import 'package:dungeonsanddragons_helper/services/dependency_injector.dart';
import 'package:dungeonsanddragons_helper/services/repositories/combat_events_repository.dart';
import 'package:dungeonsanddragons_helper/ui/combat_events/details/combat_event_details_list_element_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CombatEventDetailsViewModel extends StateNotifier<CombatEventDetailsState>  {

  static final provider = StateNotifierProvider<CombatEventDetailsViewModel, CombatEventDetailsState>((ref) => DependencyInjector.getInstance().resolve<CombatEventDetailsViewModel>());

  CombatEventDetailsViewModel(this._repository) : super(CombatEventDetailsState.toBeLoaded());

  CombatEventsRepository _repository;

  ///
  /// Loads the combat event from the repository
  ///
  Future loadCombatEvent(int combatEventId) async {
    var combatEvents = await _repository.getSingleCombatEventDetails(combatEventId);
    if (combatEvents == null) {
      return;
    }
    // Notifies the change of state //
    state = CombatEventDetailsState.loaded(combatEvents);
  }


}

class CombatEventDetailsState {

  CombatEventDetailsState.toBeLoaded() {
    this.isEventToBeLoadedYet = true;
    this.combatEvents = [];
  }

  CombatEventDetailsState.loaded(List<CombatEventDetailsListElementViewModel> combatEvents) {
    this.isEventToBeLoadedYet = false;
    this.combatEvents = combatEvents;
  }

  late bool isEventToBeLoadedYet;

  late List<CombatEventDetailsListElementViewModel> combatEvents;
}