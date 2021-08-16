import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'wiki_widget_viewmodel.dart';

class WikiWidget extends ConsumerWidget {
  WikiWidgetViewModel? _viewModel;

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final WikiWidgetState state = watch(WikiWidgetViewModel.provider);
    if (_viewModel == null)
      _viewModel = context.read(WikiWidgetViewModel.provider.notifier);

    if (state.toBeLoaded) {
      _viewModel!.loadWiki();
    }

    return Scaffold(
        body: Center(
            child: state.toBeLoaded
                // Shows a loading indicator while loading //
                ? CircularProgressIndicator()
                // Shows the list, if loaded //
                : Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10.0),
                    child: Column())));
  }
}
