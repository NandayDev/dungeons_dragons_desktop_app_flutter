import 'package:dungeonsanddragons_helper/services/combat_events_repository.dart';
import 'package:dungeonsanddragons_helper/services/dependency_injector.dart';
import 'package:dungeonsanddragons_helper/ui/combat_events/combat_event_list_element_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CombatEventListViewModel extends StateNotifier<CombatEventListState> {

  static final provider = StateNotifierProvider<CombatEventListViewModel, CombatEventListState>((ref) => DependencyInjector.getInstance().resolve<CombatEventListViewModel>());

  CombatEventListViewModel(this._repository) : super(CombatEventListState.toBeLoaded());

  final CombatEventsRepository _repository;

  ///
  /// Loads the combat events from the repository and changes the state
  ///
  Future loadCombatEvents() async {
    var combatEvents = await _repository.getCombatEvents(50, 0);
    state = CombatEventListState.loaded(combatEvents);
  }
}

class CombatEventListState {

  CombatEventListState.toBeLoaded() {
    _isLoading = true;
    _combatEvents = [];
  }
  CombatEventListState.loaded(this._combatEvents) {
    _isLoading = false;
  }

  late bool _isLoading;
  /// Whether combat events are currently being loaded
  bool get areCombatEventsToBeLoadedYet => _isLoading;

  late List<CombatEventListElementViewModel> _combatEvents;
  /// The list of combat events
  List<CombatEventListElementViewModel> get combatEvents => _combatEvents;
}