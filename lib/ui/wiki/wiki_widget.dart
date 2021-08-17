import 'package:dungeonsanddragons_helper/ui/wiki/wiki_document_viewmodel.dart';
import 'package:flutter/material.dart';
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
                    child: Row(
                      children: [
                        WikiList(state.documents)
                      ],
                    ))));
  }
}

class WikiList extends StatefulWidget {
  const WikiList(this.documents) : super();

  final List<WikiDocumentViewModel> documents;

  @override
  _WikiListState createState() => _WikiListState();
}

class _WikiListState extends State<WikiList> {
  final List<int> colorCodes = [600, 500, 100];

  @override
  Widget build(BuildContext context) {
    return createWikiList(widget.documents);
  }

  Widget createWikiList(List<WikiDocumentViewModel> documents) {
    return Container(
        child: ListView.builder(
            padding: EdgeInsets.only(left: 5.0, top: 8.0, bottom: 8.0),
            itemCount: documents.length,
            itemBuilder: (BuildContext context, int index) {
              WikiDocumentViewModel currentDocument = documents[index];

              return Column(children: [
                Container(
                  height: 50,
                  color: Colors.amber[colorCodes[index]],
                  child: Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                      Text(currentDocument.title)
                    ],
                  ),
                ),
                currentDocument.childrenDocuments.length == 0
                    ? Container()
                    : createWikiList(currentDocument.childrenDocuments)
              ]);
            }));
  }
}
