import 'package:dungeonsanddragons_helper/services/dependency_injector.dart';
import 'package:dungeonsanddragons_helper/services/repositories/wiki_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WikiWidgetViewModel extends StateNotifier<WikiWidgetState> {

  WikiWidgetViewModel(this._repository) : super(WikiWidgetState.toBeLoaded());

  static final provider = StateNotifierProvider<WikiWidgetViewModel, WikiWidgetState>((ref) => DependencyInjector.getInstance().resolve<WikiWidgetViewModel>());

  final WikiRepository _repository;

  Future loadWiki() async {

  }
}

class WikiWidgetState {
  WikiWidgetState.toBeLoaded() {
    toBeLoaded = true;
  }

  late bool toBeLoaded;
}