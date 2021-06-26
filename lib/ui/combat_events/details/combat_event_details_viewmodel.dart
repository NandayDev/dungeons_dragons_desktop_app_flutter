import 'package:dungeonsanddragons_helper/models/combat_event.dart';
import 'package:dungeonsanddragons_helper/services/combat_events_repository.dart';
import 'package:dungeonsanddragons_helper/services/dependency_injector.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CombatEventDetailsViewModel extends StateNotifier<CombatEventDetailsState>  {

  static final provider = StateNotifierProvider<CombatEventDetailsViewModel, CombatEventDetailsState>((ref) => DependencyInjector.getInstance().resolve<CombatEventDetailsViewModel>());

  CombatEventDetailsViewModel(this._repository) : super(CombatEventDetailsState.toBeLoaded());

  CombatEventsRepository _repository;

  Future loadCombatEvent(int combatEventId) async {
    var combatEvent = await _repository.getSingleCombatEvent(combatEventId);
    if (combatEvent == null) {
      return;
    }

    // TODO
  }
}

class CombatEventDetailsState {

  CombatEventDetailsState.toBeLoaded() {
    this.isEventToBeLoadedYet = true;
    this.combatEvent = null;
  }

  CombatEventDetailsState.loaded(CombatEvent combatEvent) {
    this.isEventToBeLoadedYet = false;
    this.combatEvent = combatEvent;
  }

  late bool isEventToBeLoadedYet;

  late CombatEvent? combatEvent;
}