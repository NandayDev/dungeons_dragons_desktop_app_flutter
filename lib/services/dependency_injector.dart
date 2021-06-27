import 'package:dungeonsanddragons_helper/services/repositories/character_repository.dart';
import 'package:dungeonsanddragons_helper/services/repositories/combat_events_repository.dart';
import 'package:dungeonsanddragons_helper/ui/characters/player_characters_list_viewmodel.dart';
import 'package:dungeonsanddragons_helper/ui/combat_events/combat_event_list_viewmodel.dart';
import 'package:dungeonsanddragons_helper/ui/combat_events/details/combat_event_details_viewmodel.dart';
import 'package:flutter_simple_dependency_injection/injector.dart';

import 'repositories/character_notes_repository.dart';

///
/// Simple implementation of a dependency injector
///
class DependencyInjector {
  bool _initialized = false;
  Injector _injector = Injector();

  ///
  /// Initializes all the mappings for the D.I., for both services and view models
  ///
  void initialize() {
    // Services //
    _injector.map<CharacterRepository>((i) => CharacterRepositoryImpl(), isSingleton: true);
    _injector.map<CharacterNotesRepository>((i) => CharacterNotesRepositoryImpl(), isSingleton: true);
    _injector.map<CombatEventsRepository>((i) => CombatEventsRepositoryImpl(), isSingleton: true);

    // View models //
    _injector.map<PlayerCharactersListViewModel>((i) => PlayerCharactersListViewModel(resolve()));
    _injector.map<CombatEventListViewModel>((i) => CombatEventListViewModel(resolve()));
    _injector.map<CombatEventDetailsViewModel>((i) => CombatEventDetailsViewModel(resolve()));
  }

  ///
  /// Returns an instance of requested service
  ///
  T resolve<T>() {
    return _injector.get<T>();
  }

  ///
  /// Static instance (singleton)
  ///
  static DependencyInjector _instance = DependencyInjector();

  ///
  /// Returns the singleton instance of the DependencyInjector, to be used for the D.I.
  ///
  static DependencyInjector getInstance() {
    if (!_instance._initialized) {
      _instance._initialized = true;
      _instance.initialize();
    }
    return _instance;
  }
}
