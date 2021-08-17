import 'package:dungeonsanddragons_helper/services/dependency_injector.dart';
import 'package:dungeonsanddragons_helper/services/repositories/wiki_repository.dart';
import 'package:dungeonsanddragons_helper/ui/wiki/wiki_document_viewmodel.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class WikiWidgetViewModel extends StateNotifier<WikiWidgetState> {

  WikiWidgetViewModel(this._repository) : super(WikiWidgetState.toBeLoaded());

  static final provider = StateNotifierProvider<WikiWidgetViewModel, WikiWidgetState>((ref) => DependencyInjector.getInstance().resolve<WikiWidgetViewModel>());

  final WikiRepository _repository;

  Future loadWiki() async {
    var documents = await _repository.loadParentDocuments();
    state = WikiWidgetState.loaded(documents);
  }

  Future loadChildrenOfDocument(WikiDocumentViewModel document) async {
    document.childrenDocuments = await _repository.loadChildrenOfDocument(document);
  }
}

class WikiWidgetState {
  WikiWidgetState.toBeLoaded() {
    toBeLoaded = true;
    documents = [];
  }

  WikiWidgetState.loaded(this.documents) {
    toBeLoaded = false;
  }

  late bool toBeLoaded;
  late List<WikiDocumentViewModel> documents;
}