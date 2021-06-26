import 'package:dungeonsanddragons_helper/ui/combat_events/details/combat_event_details_viewmodel.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CombatEventDetailsWidget extends ConsumerWidget {

  CombatEventDetailsWidget(this._combatEventId) : super(key: Key(_combatEventId.toString()));

  int _combatEventId;
  CombatEventDetailsViewModel? _viewModel;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final CombatEventDetailsState state = watch(CombatEventDetailsViewModel.provider);
    if (_viewModel == null) {
      _viewModel = context.read(CombatEventDetailsViewModel.provider.notifier);
    }

    // TODO: implement build
    throw UnimplementedError();
  }

}