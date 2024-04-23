import 'package:dungeonsanddragons_helper/models/character.dart';
import 'package:dungeonsanddragons_helper/models/character_note.dart';
import 'package:dungeonsanddragons_helper/utilities/database_utility.dart';
import 'package:dungeonsanddragons_helper/utilities/enum_utility.dart';

import '../../enums/note_priority.dart';
import '../local_storage.dart';

///
/// Repository for the character notes
///
abstract class CharacterNotesRepository {
  ///
  /// Returns a list of all character notes for given character
  ///
  List<CharacterNote> getAllCharacterNotes(Character character);
}

class CharacterNotesRepositoryImpl implements CharacterNotesRepository {
  CharacterNotesRepositoryImpl(this._localStorage);

  final LocalStorage _localStorage;

  @override
  List<CharacterNote> getAllCharacterNotes(Character character) {
    return _localStorage.getCharacterNotes(character).map((charNote) {
      DateTime creationDate = DatabaseUtility.getUtcDateTimeFromMillisecondsSinceEpoch(charNote.creationDate);
      NotePriority notePriority = EnumUtility.parseFromInt(NotePriority.values, charNote.priority)!;
      return CharacterNote.fromExisting(charNote.id, creationDate, character.id, charNote.content, notePriority);
    }).toList();
  }
}
