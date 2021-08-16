import 'package:dungeonsanddragons_helper/services/database.dart';
import 'package:dungeonsanddragons_helper/ui/wiki/wiki_document_viewmodel.dart';

abstract class WikiRepository {
  Future<List<WikiDocumentViewModel>> loadParentDocuments();

  Future<List<WikiDocumentViewModel>> loadChildrenOfDocument(WikiDocumentViewModel document);
}

class WikiRepositoryImpl extends WikiRepository {
  @override
  Future<List<WikiDocumentViewModel>> loadParentDocuments() async {
    var database = await DungeonsDatabase.getDatabaseInstance();

    var queryResults = await database.rawQuery(""
        "SELECT * FROM ${DungeonsDatabase.WIKI_DOCS_TABLE} "
        "WHERE ${DungeonsDatabase.WIKI_DOC_PARENT_ID} = NULL;");

    return _createFromQueryResult(queryResults);
  }

  @override
  Future<List<WikiDocumentViewModel>> loadChildrenOfDocument(WikiDocumentViewModel document) async {
    var database = await DungeonsDatabase.getDatabaseInstance();

    var queryResults = await database.rawQuery(""
        "SELECT * FROM ${DungeonsDatabase.WIKI_DOCS_TABLE} "
        "WHERE ${DungeonsDatabase.WIKI_DOC_PARENT_ID} = ${document.id};");

    return _createFromQueryResult(queryResults);
  }

  List<WikiDocumentViewModel> _createFromQueryResult(
      List<Map<String, Object?>> queryResults) {
    List<WikiDocumentViewModel> documentList = [];

    for (var result in queryResults) {
      documentList.add(new WikiDocumentViewModel(
          result[DungeonsDatabase.BASE_MODEL_ID] as int,
          result[DungeonsDatabase.WIKI_DOC_TITLE] as String));
    }

    return documentList;
  }
}
