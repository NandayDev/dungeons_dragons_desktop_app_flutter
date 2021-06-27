import 'package:dungeonsanddragons_helper/models/character.dart';
import 'package:dungeonsanddragons_helper/models/character_note.dart';
import 'package:dungeonsanddragons_helper/utilities/enum_utility.dart';

import '../database.dart';

///
/// Repository for the character notes
///
abstract class CharacterNotesRepository {

  ///
  /// Returns a list of all character notes for given character
  ///
  Future<List<CharacterNote>> getAllCharacterNotes(Character character);
}

class CharacterNotesRepositoryImpl implements CharacterNotesRepository {

  @override
  Future<List<CharacterNote>> getAllCharacterNotes(Character character) async {
    var database = await DungeonsDatabase.getDatabaseInstance();
    var queryResult = await database.rawQuery(
        "SELECT * FROM ${DungeonsDatabase.CHARACTER_NOTES_TABLE} WHERE ${DungeonsDatabase.CHARACTER_NOTES_CHARACTER_ID} = ${character.id}");
    List<CharacterNote> notes = [];
    queryResult.forEach((row) {
      DateTime creationDate = DungeonsDatabase.getUtcDateTimeFromMillisecondsSinceEpoch(row[DungeonsDatabase.BASE_MODEL_CREATION_DATE] as int);
      NotePriority notePriority = EnumUtility.parseFromInt(
          NotePriority.values,
          row[DungeonsDatabase.CHARACTER_NOTES_PRIORITY] as int)!;
      notes.add(CharacterNote.fromExisting(
          row[DungeonsDatabase.BASE_MODEL_ID] as int,
          creationDate,
          character.id,
          row[DungeonsDatabase.CHARACTER_NOTES_CONTENT] as String,
          notePriority));
    });
    return notes;
  }

}