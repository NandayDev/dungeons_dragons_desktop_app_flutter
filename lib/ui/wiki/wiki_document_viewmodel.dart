class WikiDocumentViewModel {

  WikiDocumentViewModel(this.id, this.title);

  final int id;

  final String title;

  List<WikiDocumentViewModel> childrenDocuments = [];

}